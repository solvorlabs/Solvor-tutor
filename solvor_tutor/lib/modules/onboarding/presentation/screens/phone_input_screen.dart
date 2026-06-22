import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/l10n/app_strings.dart';
import '../../../../core/l10n/strings_provider.dart';
import '../onboarding_provider.dart';
import '../widgets/step_progress.dart';

class _Country {
  final String name;
  final String code;
  final String flag;
  const _Country(this.name, this.code, this.flag);
}

const _countries = [
  _Country('India', '+91', '🇮🇳'),
  _Country('United States', '+1', '🇺🇸'),
  _Country('United Kingdom', '+44', '🇬🇧'),
  _Country('Canada', '+1', '🇨🇦'),
  _Country('Australia', '+61', '🇦🇺'),
  _Country('UAE', '+971', '🇦🇪'),
  _Country('Saudi Arabia', '+966', '🇸🇦'),
  _Country('Singapore', '+65', '🇸🇬'),
  _Country('Malaysia', '+60', '🇲🇾'),
  _Country('Bangladesh', '+880', '🇧🇩'),
  _Country('Nepal', '+977', '🇳🇵'),
  _Country('Sri Lanka', '+94', '🇱🇰'),
  _Country('Pakistan', '+92', '🇵🇰'),
  _Country('Afghanistan', '+93', '🇦🇫'),
  _Country('Indonesia', '+62', '🇮🇩'),
  _Country('Philippines', '+63', '🇵🇭'),
  _Country('Thailand', '+66', '🇹🇭'),
  _Country('Vietnam', '+84', '🇻🇳'),
  _Country('South Korea', '+82', '🇰🇷'),
  _Country('Japan', '+81', '🇯🇵'),
  _Country('China', '+86', '🇨🇳'),
  _Country('Russia', '+7', '🇷🇺'),
  _Country('Germany', '+49', '🇩🇪'),
  _Country('France', '+33', '🇫🇷'),
  _Country('Italy', '+39', '🇮🇹'),
  _Country('Spain', '+34', '🇪🇸'),
  _Country('Netherlands', '+31', '🇳🇱'),
  _Country('New Zealand', '+64', '🇳🇿'),
];

class PhoneInputScreen extends ConsumerStatefulWidget {
  const PhoneInputScreen({super.key});

  @override
  ConsumerState<PhoneInputScreen> createState() => _PhoneInputScreenState();
}

class _PhoneInputScreenState extends ConsumerState<PhoneInputScreen> {
  late TextEditingController _controller;
  String _selectedCode = '+91';
  String _selectedFlag = '🇮🇳';
  bool _isSendingOtp = false;

  @override
  void initState() {
    super.initState();
    final phone = ref.read(onboardingProvider).phoneNumber;
    _controller = TextEditingController(text: phone);
    _syncCountry(phone);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _syncCountry(String phone) {
    for (final c in _countries) {
      if (phone.startsWith(c.code)) {
        _selectedCode = c.code;
        _selectedFlag = c.flag;
        return;
      }
    }
    _selectedCode = '+91';
    _selectedFlag = '🇮🇳';
  }

  String _cleanPhone(String raw) {
    return raw
        .replaceAll(RegExp(r'[^\d]'), '')
        .replaceFirst(RegExp(r'^91'), '');
  }

  Future<void> _sendOtp() async {
    setState(() => _isSendingOtp = true);

    try {
      final raw = ref.read(onboardingProvider).phoneNumber;
      final clean = _cleanPhone(raw);
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
              SnackBar(content: Text(e.message ?? 'Verification failed')),
            );
            setState(() => _isSendingOtp = false);
          }
        },
        codeSent: (String verificationId, int? resendToken) {
          ref.read(verificationIdProvider.notifier).state = verificationId;
          if (mounted) {
            ref.read(onboardingProvider.notifier).nextStep();
            setState(() => _isSendingOtp = false);
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
        setState(() => _isSendingOtp = false);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final lang = ref.watch(langProvider);
    final state = ref.watch(onboardingProvider);
    final notifier = ref.read(onboardingProvider.notifier);

    return Scaffold(
      resizeToAvoidBottomInset: true,
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => ref.read(onboardingProvider.notifier).previousStep(),
        ),
        title: const Text('Create Profile'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const StepProgress(currentStep: 2, totalSteps: 6),
            const SizedBox(height: 40),
            Icon(
              Icons.phone_android,
              size: 64,
              color: Theme.of(context).colorScheme.primary,
            ),
            const SizedBox(height: 24),
            Text(
              AppStrings.get('onboarding_phone_title', lang),
              style: Theme.of(context).textTheme.headlineMedium,
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 8),
            Text(
              AppStrings.get('onboarding_phone_subtitle', lang),
              style: Theme.of(context).textTheme.bodyMedium,
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 32),
            TextField(
              controller: _controller,
              keyboardType: TextInputType.phone,
              decoration: InputDecoration(
                labelText: 'Phone Number',
                hintText: '$_selectedCode 9876543210',
                prefixIcon: GestureDetector(
                  onTap: () => _showCountryPicker(),
                  child: Padding(
                    padding: const EdgeInsets.only(left: 12, right: 8),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(_selectedFlag, style: const TextStyle(fontSize: 22)),
                        const SizedBox(width: 6),
                        Text(
                          _selectedCode,
                          style: const TextStyle(
                            fontWeight: FontWeight.w600,
                            fontSize: 15,
                          ),
                        ),
                        const Icon(
                          Icons.arrow_drop_down,
                          size: 20,
                        ),
                      ],
                    ),
                  ),
                ),
                prefixIconConstraints: const BoxConstraints(minWidth: 0, minHeight: 0),
              ),
              onChanged: (v) {
                _syncCountry(v);
                notifier.setPhoneNumber(v);
              },
            ),
            const SizedBox(height: 24),
            ElevatedButton(
              onPressed: state.phoneNumber.replaceAll(RegExp(r'\D'), '').length >= 10 && !_isSendingOtp
                  ? _sendOtp
                  : null,
              child: _isSendingOtp
                  ? const SizedBox(
                      width: 20,
                      height: 20,
                      child: CircularProgressIndicator(strokeWidth: 2),
                    )
                  : Text(AppStrings.get('onboarding_continue', lang)),
            ),
            const SizedBox(height: 40),
          ],
        ),
      ),
    );
  }

  void _showCountryPicker() {
    final notifier = ref.read(onboardingProvider.notifier);
    final searchController = TextEditingController();
    ValueNotifier<List<_Country>> filtered = ValueNotifier(_countries);

    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
      ),
      builder: (ctx) {
        return DraggableScrollableSheet(
          initialChildSize: 0.7,
          minChildSize: 0.5,
          maxChildSize: 0.9,
          expand: false,
          builder: (_, scrollController) {
            return StatefulBuilder(
              builder: (context, setState) {
                return Column(
                  children: [
                    const SizedBox(height: 8),
                    Container(
                      width: 32,
                      height: 4,
                      decoration: BoxDecoration(
                        color: Colors.grey[300],
                        borderRadius: BorderRadius.circular(2),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(16, 16, 16, 8),
                      child: TextField(
                        controller: searchController,
                        decoration: const InputDecoration(
                          hintText: 'Search country...',
                          prefixIcon: Icon(Icons.search),
                          isDense: true,
                        ),
                        onChanged: (v) {
                          setState(() {
                            filtered.value = _countries
                                .where((c) =>
                                    c.name.toLowerCase().contains(v.toLowerCase()) ||
                                    c.code.contains(v))
                                .toList();
                          });
                        },
                      ),
                    ),
                    Expanded(
                      child: ValueListenableBuilder<List<_Country>>(
                        valueListenable: filtered,
                        builder: (_, list, __) {
                          return ListView.separated(
                            controller: scrollController,
                            itemCount: list.length,
                            separatorBuilder: (_, __) => const Divider(height: 1),
                            itemBuilder: (_, i) {
                              final c = list[i];
                              final isSelected = c.code == _selectedCode;
                              return ListTile(
                                leading: Text(c.flag, style: const TextStyle(fontSize: 26)),
                                title: Text(c.name),
                                trailing: Text(
                                  c.code,
                                  style: TextStyle(
                                    fontWeight: FontWeight.w600,
                                    color: isSelected
                                        ? Theme.of(context).colorScheme.primary
                                        : null,
                                  ),
                                ),
                                selected: isSelected,
                                onTap: () {
                                  final number = _controller.text
                                      .replaceAll(RegExp(r'^\+\d{1,3}\s?'), '')
                                      .trim();
                                  final full = '${c.code} $number';
                                  _controller.text = full;
                                  _controller.selection = TextSelection.fromPosition(
                                    TextPosition(offset: full.length),
                                  );
                                  setState(() {
                                    _selectedCode = c.code;
                                    _selectedFlag = c.flag;
                                  });
                                  notifier.setPhoneNumber(full);
                                  Navigator.pop(ctx);
                                },
                              );
                            },
                          );
                        },
                      ),
                    ),
                  ],
                );
              },
            );
          },
        );
      },
    );
  }
}
