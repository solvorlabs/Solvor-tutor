import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'onboarding_provider.dart';
import 'screens/auth_method_screen.dart';
import 'screens/exam_selector_screen.dart';
import 'screens/google_signin_screen.dart';
import 'screens/language_picker_screen.dart';
import 'screens/otp_verification_screen.dart';
import 'screens/phone_input_screen.dart';
import 'screens/study_budget_screen.dart';
import 'screens/weak_domains_screen.dart';

class OnboardingScreen extends ConsumerWidget {
  const OnboardingScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(onboardingProvider);
    final method = ref.watch(authMethodProvider);
    final step = state.currentStep;
    final notifier = ref.read(onboardingProvider.notifier);

    Widget screen;
    switch (step) {
      case 0:
        screen = const AuthMethodScreen();
      case 1:
        screen = method == AuthMethod.google
            ? const GoogleSignInScreen()
            : const PhoneInputScreen();
      case 2:
        screen = method == AuthMethod.google
            ? const ExamSelectorScreen()
            : const OtpVerificationScreen();
      case 3:
        screen = const ExamSelectorScreen();
      case 4:
        screen = const LanguagePickerScreen();
      case 5:
        screen = const StudyBudgetScreen();
      case 6:
        screen = const WeakDomainsScreen();
      default:
        screen = const Scaffold(
          body: Center(child: CircularProgressIndicator()),
        );
    }

    return PopScope(
      canPop: step == 0,
      onPopInvokedWithResult: (didPop, _) {
        if (!didPop) {
          notifier.previousStep();
        }
      },
      child: screen,
    );
  }
}
