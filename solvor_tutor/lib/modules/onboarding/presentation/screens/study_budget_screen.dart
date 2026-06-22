import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../onboarding_provider.dart';
import '../widgets/step_progress.dart';

class StudyBudgetScreen extends ConsumerWidget {
  const StudyBudgetScreen({super.key});

  static const _budgets = [
    (30, '30 min', 'Quick daily practice', '⚡'),
    (60, '1 hour', 'Balanced study routine', '📚'),
    (120, '2 hours', 'Dedicated preparation', '🎯'),
    (180, '3+ hours', 'Intensive preparation', '🔥'),
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
        title: const Text('Study Budget'),
      ),
      body: Column(
        children: [
          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.fromLTRB(24, 24, 24, 0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  const StepProgress(currentStep: 5, totalSteps: 6),
                  const SizedBox(height: 40),
                  Text(
                    'How much time can you\nstudy daily?',
                    style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                          fontWeight: FontWeight.bold,
                        ),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'We will tailor your study plan accordingly',
                    style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                          color: Colors.grey[600],
                        ),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 32),
                  ..._budgets.map(
                    (b) => Padding(
                      padding: const EdgeInsets.only(bottom: 12),
                      child: _BudgetOption(
                        minutes: b.$1,
                        label: b.$2,
                        description: b.$3,
                        emoji: b.$4,
                        isSelected: state.dailyCapacityMinutes == b.$1,
                        onTap: () => notifier.setBudget(b.$1),
                      ),
                    ),
                  ),
                  const SizedBox(height: 16),
                ],
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(24, 12, 24, 28),
            child: ElevatedButton(
              onPressed: state.dailyCapacityMinutes != null
                  ? () => notifier.nextStep()
                  : null,
              child: const Text('Continue'),
            ),
          ),
        ],
      ),
    );
  }
}

class _BudgetOption extends StatelessWidget {
  final int minutes;
  final String label;
  final String description;
  final String emoji;
  final bool isSelected;
  final VoidCallback onTap;

  const _BudgetOption({
    required this.minutes,
    required this.label,
    required this.description,
    required this.emoji,
    required this.isSelected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final primary = Theme.of(context).colorScheme.primary;
    return GestureDetector(
      onTap: onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 180),
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
        decoration: BoxDecoration(
          color: isSelected ? primary.withOpacity(0.08) : null,
          border: Border.all(
            color: isSelected ? primary : Colors.grey.withOpacity(0.25),
            width: isSelected ? 2 : 1,
          ),
          borderRadius: BorderRadius.circular(14),
        ),
        child: Row(
          children: [
            Text(emoji, style: const TextStyle(fontSize: 26)),
            const SizedBox(width: 14),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    label,
                    style: Theme.of(context).textTheme.titleMedium?.copyWith(
                          fontWeight: FontWeight.w600,
                          color: isSelected ? primary : null,
                        ),
                  ),
                  Text(
                    description,
                    style: Theme.of(context).textTheme.bodySmall?.copyWith(
                          color: Colors.grey[600],
                        ),
                  ),
                ],
              ),
            ),
            if (isSelected)
              Icon(Icons.check_circle_rounded, color: primary, size: 22),
          ],
        ),
      ),
    );
  }
}
