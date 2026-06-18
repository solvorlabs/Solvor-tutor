import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../core/database/app_database.dart';
import '../../../core/database/daos/questions_dao.dart';
import '../../../core/database/daos/tests_dao.dart';
import '../../../core/database/daos/users_dao.dart';
import '../data/diagnostic_builder.dart';

final diagnosticProvider = Provider<DiagnosticTestBuilder>((ref) {
  final db = ref.watch(databaseProvider);
  return DiagnosticTestBuilder(TestsDao(db), QuestionsDao(db));
});

class DiagnosticStartScreen extends ConsumerWidget {
  const DiagnosticStartScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(title: const Text('Diagnostic Test')),
      body: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const Spacer(flex: 2),
            Icon(
              Icons.assignment_outlined,
              size: 80,
              color: Theme.of(context).colorScheme.primary,
            ),
            const SizedBox(height: 24),
            Text(
              'Diagnostic Assessment',
              style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 16),
            Text(
              'This quick test will assess your current level across all subjects.',
              style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                    color: Colors.grey[600],
                  ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 32),
            _InfoRow(
              icon: Icons.quiz_outlined,
              label: 'Questions',
              value: '20',
            ),
            const SizedBox(height: 12),
            _InfoRow(
              icon: Icons.timer_outlined,
              label: 'Time Limit',
              value: '20 minutes',
            ),
            const SizedBox(height: 12),
            _InfoRow(
              icon: Icons.category_outlined,
              label: 'Subjects',
              value: 'Quant, Reasoning, English, GK',
            ),
            const Spacer(flex: 2),
            ElevatedButton(
              onPressed: () async {
                final db = ref.read(databaseProvider);
                final user = await UsersDao(db).getUser();
                if (user == null) return;

                final builder = ref.read(diagnosticProvider);
                final testId = await builder.buildDiagnosticTest(user.id);
                if (context.mounted) {
                  context.go('/test/$testId');
                }
              },
              style: ElevatedButton.styleFrom(
                padding: const EdgeInsets.symmetric(vertical: 16),
              ),
              child: const Text('Start Test', style: TextStyle(fontSize: 18)),
            ),
            const Spacer(),
          ],
        ),
      ),
    );
  }
}

class _InfoRow extends StatelessWidget {
  final IconData icon;
  final String label;
  final String value;

  const _InfoRow({
    required this.icon,
    required this.label,
    required this.value,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        child: Row(
          children: [
            Icon(icon, color: Theme.of(context).colorScheme.primary),
            const SizedBox(width: 16),
            Text(label, style: Theme.of(context).textTheme.titleMedium),
            const Spacer(),
            Text(
              value,
              style: Theme.of(context).textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
            ),
          ],
        ),
      ),
    );
  }
}
