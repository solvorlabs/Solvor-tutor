import 'dart:convert';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:http/http.dart' as http;

import '../../../../core/l10n/app_strings.dart';
import '../../../../core/l10n/strings_provider.dart';
import '../onboarding_provider.dart';
import '../widgets/step_progress.dart';

const _apiBase = String.fromEnvironment('API_BASE', defaultValue: 'https://api.solvor.co.in');

class OtpVerificationScreen extends ConsumerStatefulWidget {
  const OtpVerificationScreen({super.key});

  @override
  ConsumerState<OtpVerificationScreen> createState() => _OtpVerificationScreenState();
}

class _OtpVerificationScreenState extends ConsumerState<OtpVerificationScreen> {
  final List<String> _digits = List.filled(6, '');
  final List<FocusNode> _focusNodes = List.generate(6, (_) => FocusNode());
  bool _isVerifying = false;
  bool _isResending = false;

  String get _enteredOtp => _digits.join();

  @override
  void dispose() {
    for (final node in _focusNodes) {
      node.dispose();
    }
    super.dispose();
  }

  Future<void> _verifyOtp() async {
    if (_enteredOtp.length != 6) return;

    setState(() => _isVerifying = true);

    try {
      final verificationId = ref.read(verificationIdProvider);
      if (verificationId == null) {
        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Verification expired. Request OTP again.')),
          );
        }
        return;
      }

      final credential = PhoneAuthProvider.credential(
        verificationId: verificationId,
        smsCode: _enteredOtp,
      );

      final userCred = await FirebaseAuth.instance.signInWithCredential(credential);
      final idToken = await userCred.user!.getIdToken();

      try {
        await http.post(
          Uri.parse('$_apiBase/auth/firebase-login'),
          headers: {'Content-Type': 'application/json'},
          body: jsonEncode({'idToken': idToken}),
        ).timeout(const Duration(seconds: 5));
      } catch (_) {
        // Backend may not be running; Firebase auth is sufficient to proceed
      }

      if (!mounted) return;

      final notifier = ref.read(onboardingProvider.notifier);
      notifier.verifyOtp();
      notifier.nextStep();
    } on FirebaseAuthException catch (e) {
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(e.message ?? 'Invalid code. Try again.')),
      );
    } catch (e) {
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Network error. Please try again.')),
      );
    } finally {
      if (mounted) setState(() => _isVerifying = false);
    }
  }

  Future<void> _resendOtp() async {
    setState(() => _isResending = true);

    try {
      final raw = ref.read(onboardingProvider).phoneNumber;
      final clean = raw
          .replaceAll(RegExp(r'[^\d]'), '')
          .replaceFirst(RegExp(r'^91'), '');
      final fullNumber = '+91$clean';

      await FirebaseAuth.instance.verifyPhoneNumber(
        phoneNumber: fullNumber,
        verificationCompleted: (PhoneAuthCredential credential) async {
          await FirebaseAuth.instance.signInWithCredential(credential);
          if (mounted) {
            ref.read(onboardingProvider.notifier).nextStep();
          }
        },
        verificationFailed: (FirebaseAuthException e) {
          if (mounted) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text(e.message ?? 'Resend failed')),
            );
          }
        },
        codeSent: (String verificationId, int? resendToken) {
          ref.read(verificationIdProvider.notifier).state = verificationId;
          if (mounted) {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text('OTP resent')),
            );
          }
        },
        codeAutoRetrievalTimeout: (String verificationId) {
          ref.read(verificationIdProvider.notifier).state = verificationId;
        },
        timeout: const Duration(seconds: 60),
      );
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Error: $e')),
        );
      }
    } finally {
      if (mounted) setState(() => _isResending = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    final lang = ref.watch(langProvider);

    return Scaffold(
      resizeToAvoidBottomInset: true,
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => ref.read(onboardingProvider.notifier).previousStep(),
        ),
        title: const Text('Verify OTP'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const StepProgress(currentStep: 3, totalSteps: 6),
            const SizedBox(height: 40),
            Icon(
              Icons.message_outlined,
              size: 64,
              color: Theme.of(context).colorScheme.primary,
            ),
            const SizedBox(height: 24),
            Text(
              AppStrings.get('onboarding_otp_title', lang),
              style: Theme.of(context).textTheme.headlineMedium,
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 8),
            Text(
              'A 6-digit code was sent to your phone',
              style: Theme.of(context).textTheme.bodyMedium,
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 32),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: List.generate(
                6,
                (index) => SizedBox(
                  width: 48,
                  child: TextField(
                    focusNode: _focusNodes[index],
                    textAlign: TextAlign.center,
                    keyboardType: TextInputType.number,
                    maxLength: 1,
                    decoration: const InputDecoration(counterText: ''),
                    onChanged: (v) {
                      setState(() => _digits[index] = v);
                      if (v.isNotEmpty && index < 5) {
                        _focusNodes[index + 1].requestFocus();
                      }
                      if (_enteredOtp.length == 6) {
                        _verifyOtp();
                      }
                    },
                  ),
                ),
              ),
            ),
            const SizedBox(height: 24),
            ElevatedButton(
              onPressed: _enteredOtp.length == 6 && !_isVerifying
                  ? _verifyOtp
                  : null,
              child: _isVerifying
                  ? const SizedBox(
                      width: 20,
                      height: 20,
                      child: CircularProgressIndicator(strokeWidth: 2),
                    )
                  : Text(AppStrings.get('onboarding_continue', lang)),
            ),
            const SizedBox(height: 12),
            TextButton(
              onPressed: _isResending ? null : _resendOtp,
              child: _isResending
                  ? const SizedBox(
                      width: 16,
                      height: 16,
                      child: CircularProgressIndicator(strokeWidth: 2),
                    )
                  : const Text('Resend OTP'),
            ),
            TextButton.icon(
              onPressed: () {
                final notifier = ref.read(onboardingProvider.notifier);
                notifier.skipOtp();
                notifier.nextStep();
              },
              icon: const Icon(Icons.skip_next),
              label: Text(AppStrings.get('onboarding_skip_otp', lang)),
            ),
            const SizedBox(height: 40),
          ],
        ),
      ),
    );
  }
}
