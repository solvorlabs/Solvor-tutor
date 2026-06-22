import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../app.dart';
import '../../../../core/theme/design_tokens.dart';
import '../onboarding_provider.dart';

class AuthMethodScreen extends ConsumerWidget {
  const AuthMethodScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final ink = isDark ? Colors.white : kInk;

    return Scaffold(
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
              Text('How do you want to sign in?',
                  style: Theme.of(context).textTheme.headlineSmall),
              const SizedBox(height: 24),
              ElevatedButton.icon(
                icon: const Icon(Icons.phone_android),
                label: const Text('Continue with Phone'),
                onPressed: () {
                  ref.read(authMethodProvider.notifier).state = AuthMethod.phone;
                  ref.read(onboardingProvider.notifier).nextStep();
                },
              ),
              const SizedBox(height: 12),
              OutlinedButton.icon(
                icon: const Icon(Icons.mail_outline),
                label: const Text('Continue with Google / Email'),
                onPressed: () {
                  ref.read(authMethodProvider.notifier).state = AuthMethod.google;
                  ref.read(onboardingProvider.notifier).nextStep();
                },
              ),
              const Spacer(),
            ],
          ),
        ),
      ),
    );
  }
}
