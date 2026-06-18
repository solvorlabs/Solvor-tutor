import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'onboarding_provider.dart';
import 'screens/phone_input_screen.dart';
import 'screens/otp_verification_screen.dart';
import 'screens/exam_selector_screen.dart';
import 'screens/language_picker_screen.dart';
import 'screens/study_budget_screen.dart';
import 'screens/weak_domains_screen.dart';

class OnboardingScreen extends ConsumerWidget {
  const OnboardingScreen({super.key});

  static const _screens = <Widget>[
    PhoneInputScreen(),
    OtpVerificationScreen(),
    ExamSelectorScreen(),
    LanguagePickerScreen(),
    StudyBudgetScreen(),
    WeakDomainsScreen(),
  ];

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(onboardingProvider);

    if (state.currentStep >= _screens.length) {
      return const Scaffold(
        body: Center(child: CircularProgressIndicator()),
      );
    }

    return _screens[state.currentStep];
  }
}
