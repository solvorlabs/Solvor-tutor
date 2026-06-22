import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/auth/auth_state.dart';
import '../onboarding_provider.dart';
import '../widgets/step_progress.dart';

class WeakDomainsScreen extends ConsumerWidget {
  const WeakDomainsScreen({super.key});

  static const _subjects = [
    'Quantitative Aptitude',
    'Logical Reasoning',
    'English Language',
    'General Knowledge',
  ];

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(onboardingProvider);
    final notifier = ref.read(onboardingProvider.notifier);

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => ref.read(onboardingProvider.notifier).previousStep(),
        ),
        title: const Text('Weak Areas'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const StepProgress(currentStep: 6, totalSteps: 6),
            const SizedBox(height: 40),
            Text(
              'Which subjects need more practice?',
              style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 8),
            Text(
              'Select all that apply (you can change later)',
              style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                    color: Colors.grey[600],
                  ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 32),
            ..._subjects.map(
              (subject) => Padding(
                padding: const EdgeInsets.only(bottom: 12),
                child: _WeakDomainTile(
                  subject: subject,
                  isSelected: state.weakDomains.contains(subject),
                  onTap: () => notifier.toggleWeakDomain(subject),
                ),
              ),
            ),
            const Spacer(),
            if (state.isSaving)
              const Center(child: CircularProgressIndicator())
            else
              ElevatedButton(
                onPressed: () async {
                  final profile = await notifier.completeOnboarding();
                  if (profile != null && context.mounted) {
                    ref.read(authStateProvider.notifier).setLoggedIn(true);
                    context.go('/home');
                  }
                },
                child: const Text('Complete Setup'),
              ),
          ],
        ),
      ),
    );
  }
}

class _WeakDomainTile extends StatelessWidget {
  final String subject;
  final bool isSelected;
  final VoidCallback onTap;

  const _WeakDomainTile({
    required this.subject,
    required this.isSelected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final iconMap = {
      'Quantitative Aptitude': Icons.calculate,
      'Logical Reasoning': Icons.psychology,
      'English Language': Icons.menu_book,
      'General Knowledge': Icons.public,
    };

    return Card(
      elevation: isSelected ? 4 : 1,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
        side: BorderSide(
          color: isSelected
              ? Theme.of(context).colorScheme.secondary
              : Colors.transparent,
          width: 2,
        ),
      ),
      child: CheckboxListTile(
        onChanged: (_) => onTap(),
        value: isSelected,
        title: Text(
          subject,
          style: Theme.of(context).textTheme.titleMedium?.copyWith(
                fontWeight: FontWeight.w600,
              ),
        ),
        secondary: Icon(
          iconMap[subject] ?? Icons.school,
          color: isSelected
              ? Theme.of(context).colorScheme.secondary
              : Colors.grey,
        ),
        activeColor: Theme.of(context).colorScheme.secondary,
      ),
    );
  }
}
