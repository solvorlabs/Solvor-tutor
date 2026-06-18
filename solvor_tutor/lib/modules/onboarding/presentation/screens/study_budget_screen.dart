import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../onboarding_provider.dart';
import '../widgets/step_progress.dart';

class StudyBudgetScreen extends ConsumerWidget {
  const StudyBudgetScreen({super.key});

  static const _budgets = [
    (30, '30 min', 'Quick daily practice'),
    (60, '1 hour', 'Balanced study routine'),
    (120, '2 hours', 'Dedicated preparation'),
    (180, '3+ hours', 'Intensive preparation'),
  ];

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(onboardingProvider);
    final notifier = ref.read(onboardingProvider.notifier);

    return Scaffold(
      appBar: AppBar(title: const Text('Study Budget')),
      body: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const StepProgress(currentStep: 5, totalSteps: 6),
            const SizedBox(height: 40),
            Text(
              'How much time can you study daily?',
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
                  isSelected: state.dailyCapacityMinutes == b.$1,
                  onTap: () => notifier.setBudget(b.$1),
                ),
              ),
            ),
            const Spacer(),
            ElevatedButton(
              onPressed: state.dailyCapacityMinutes != null
                  ? () => notifier.nextStep()
                  : null,
              child: const Text('Continue'),
            ),
          ],
        ),
      ),
    );
  }
}

class _BudgetOption extends StatelessWidget {
  final int minutes;
  final String label;
  final String description;
  final bool isSelected;
  final VoidCallback onTap;

  const _BudgetOption({
    required this.minutes,
    required this.label,
    required this.description,
    required this.isSelected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: isSelected ? 4 : 1,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
        side: BorderSide(
          color: isSelected
              ? Theme.of(context).colorScheme.primary
              : Colors.transparent,
          width: 2,
        ),
      ),
      child: ListTile(
        onTap: onTap,
        contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        leading: CircleAvatar(
          backgroundColor: isSelected
              ? Theme.of(context).colorScheme.primary
              : Colors.grey[200],
          child: Text(
            label.split(' ').first,
            style: TextStyle(
              color: isSelected ? Colors.white : Colors.black87,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        title: Text(
          label,
          style: Theme.of(context).textTheme.titleMedium?.copyWith(
                fontWeight: FontWeight.w600,
              ),
        ),
        subtitle: Text(description),
        trailing: isSelected
            ? Icon(Icons.check_circle,
                color: Theme.of(context).colorScheme.primary)
            : null,
      ),
    );
  }
}
