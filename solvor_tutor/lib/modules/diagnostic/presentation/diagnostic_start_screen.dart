import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../core/l10n/app_strings.dart';
import '../../../core/l10n/strings_provider.dart';
import '../../../core/theme/design_tokens.dart';
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
    final lang = ref.watch(langProvider);
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      backgroundColor: isDark ? kVoid : kPaper,
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => context.go('/home'),
        ),
        title: Text(AppStrings.get('diagnostic_title', lang)),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          const PatternBanner(),
          Expanded(child: Padding(
        padding: const EdgeInsets.fromLTRB(24, 0, 24, 24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const Spacer(flex: 2),

            // Icon / hero block
            Container(
              width: 72,
              height: 72,
              color: isDark ? kNeonYellow : kInk,
              alignment: Alignment.center,
              child: Icon(
                Icons.assignment_outlined,
                size: 36,
                color: isDark ? Colors.black : Colors.white,
              ),
            ),
            const SizedBox(height: 24),

            Text(
              AppStrings.get('diagnostic_assessment', lang),
              style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                    fontWeight: FontWeight.w900,
                    letterSpacing: -0.5,
                  ),
            ),
            const SizedBox(height: 12),
            Text(
              AppStrings.get('diagnostic_desc', lang),
              style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                    color: isDark ? Colors.white54 : kMuted,
                    height: 1.5,
                  ),
            ),
            const SizedBox(height: 28),

            // Info rows
            _InfoRow(
              icon: Icons.quiz_outlined,
              label: AppStrings.get('diagnostic_questions', lang),
              value: '20',
              isDark: isDark,
            ),
            Container(height: 1, color: isDark ? kSubtle : kBorder),
            _InfoRow(
              icon: Icons.timer_outlined,
              label: AppStrings.get('diagnostic_time_limit', lang),
              value: '20 min',
              isDark: isDark,
            ),
            Container(height: 1, color: isDark ? kSubtle : kBorder),
            _InfoRow(
              icon: Icons.category_outlined,
              label: AppStrings.get('diagnostic_subjects', lang),
              value: 'Quant · Reasoning · English · GK',
              isDark: isDark,
            ),

            const Spacer(flex: 2),

            // CTA
            GestureDetector(
              onTap: () async {
                final db = ref.read(databaseProvider);
                final user = await UsersDao(db).getUser();
                if (user == null) return;

                final builder = ref.read(diagnosticProvider);
                final testId = await builder.buildDiagnosticTest(user.id);
                if (context.mounted) {
                  context.go('/test/$testId');
                }
              },
              child: Container(
                padding: const EdgeInsets.symmetric(vertical: 18),
                color: isDark ? kNeonYellow : kInk,
                alignment: Alignment.center,
                child: Text(
                  AppStrings.get('diagnostic_start', lang).toUpperCase(),
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w800,
                    letterSpacing: 1.5,
                    color: isDark ? Colors.black : Colors.white,
                  ),
                ),
              ),
            ),
            const Spacer(),
          ],
        ),
      )),
        ],
      ),
    );
  }
}

class _InfoRow extends StatelessWidget {
  final IconData icon;
  final String label;
  final String value;
  final bool isDark;

  const _InfoRow({
    required this.icon,
    required this.label,
    required this.value,
    required this.isDark,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 14),
      child: Row(
        children: [
          Icon(
            icon,
            size: 18,
            color: isDark ? kNeonYellow : kMuted,
          ),
          const SizedBox(width: 14),
          Expanded(
            child: Text(
              label,
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    color: isDark ? Colors.white70 : kInk,
                  ),
            ),
          ),
          Text(
            value,
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  fontWeight: FontWeight.w700,
                  color: isDark ? Colors.white : kInk,
                ),
          ),
        ],
      ),
    );
  }
}
