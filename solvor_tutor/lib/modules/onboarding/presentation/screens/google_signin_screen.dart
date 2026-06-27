import 'dart:convert';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:http/http.dart' as http;

import '../../../../core/theme/design_tokens.dart';
import '../onboarding_provider.dart';

const _apiBase = String.fromEnvironment('API_BASE', defaultValue: 'https://api.solvor.co.in');

class GoogleSignInScreen extends ConsumerStatefulWidget {
  const GoogleSignInScreen({super.key});

  @override
  ConsumerState<GoogleSignInScreen> createState() => _GoogleSignInScreenState();
}

class _GoogleSignInScreenState extends ConsumerState<GoogleSignInScreen> {
  bool _loading = false;

  Future<void> _signInWithGoogle() async {
    setState(() => _loading = true);
    try {
      final googleUser = await GoogleSignIn().signIn();
      if (googleUser == null) {
        setState(() => _loading = false);
        return;
      }
      final googleAuth = await googleUser.authentication;
      final credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );
      final userCred = await FirebaseAuth.instance.signInWithCredential(credential);
      final displayName = userCred.user?.displayName;
      if (displayName != null && displayName.isNotEmpty) {
        ref.read(onboardingProvider.notifier).setName(displayName);
      }
      final idToken = await userCred.user!.getIdToken();

      try {
        await http.post(
          Uri.parse('$_apiBase/auth/firebase-login'),
          headers: {'Content-Type': 'application/json'},
          body: jsonEncode({'idToken': idToken}),
        ).timeout(const Duration(seconds: 5));
      } catch (_) {
      }

      if (!mounted) return;
      ref.read(onboardingProvider.notifier).verifyOtp();
      ref.read(onboardingProvider.notifier).nextStep();
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Sign-in failed: $e')),
        );
      }
    } finally {
      if (mounted) setState(() => _loading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => ref.read(onboardingProvider.notifier).previousStep(),
        ),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const Spacer(),
              NeonText('SOLVOR', style: Theme.of(context).textTheme.displayLarge),
              Text('TUTOR', style: Theme.of(context).textTheme.displayLarge),
              const SizedBox(height: 48),
              Text(
                'Sign in with Google',
                style: Theme.of(context).textTheme.headlineSmall,
              ),
              const SizedBox(height: 8),
              Text(
                'One tap. No OTP. No waiting.',
                style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  color: kMuted,
                ),
              ),
              const SizedBox(height: 32),
              if (_loading)
                const Center(child: CircularProgressIndicator())
              else ...[
                ElevatedButton.icon(
                  icon: const Icon(Icons.g_mobiledata),
                  label: const Text('Sign in with Google'),
                  onPressed: _signInWithGoogle,
                ),
                const SizedBox(height: 12),
                TextButton(
                  onPressed: () {
                    ref.read(authMethodProvider.notifier).state = AuthMethod.phone;
                    ref.read(onboardingProvider.notifier).previousStep();
                  },
                  child: const Text('Use phone instead'),
                ),
              ],
              const Spacer(),
            ],
          ),
        ),
      ),
    );
  }
}
