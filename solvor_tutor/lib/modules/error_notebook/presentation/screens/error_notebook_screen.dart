import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/l10n/app_strings.dart';
import '../../../../core/l10n/strings_provider.dart';
import '../../../../core/theme/design_tokens.dart';
import '../error_notebook_provider.dart';

class ErrorNotebookScreen extends ConsumerWidget {
  const ErrorNotebookScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final lang = ref.watch(langProvider);
    final queueAsync = ref.watch(errorNotebookProvider);
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      backgroundColor: isDark ? kVoid : kPaper,
      appBar: AppBar(
        title: Text(AppStrings.get('error_notebook_title', lang)),
        leading: IconButton(
          icon: const Icon(Icons.home_outlined),
          onPressed: () => context.go('/home'),
        ),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          const PatternBanner(),
          Expanded(
            child: queueAsync.when(
              loading: () => const Center(child: CircularProgressIndicator()),
              error: (e, _) => Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text('Error: $e'),
                    const SizedBox(height: 16),
                    ElevatedButton(
                      onPressed: () => context.go('/home'),
                      child: const Text('Back to Home'),
                    ),
                  ],
                ),
              ),
              data: (items) {
                if (items.isEmpty) {
                  return Center(
                    child: Padding(
                      padding: const EdgeInsets.all(32),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Container(
                            width: 64,
                            height: 64,
                            color: isDark ? kNeonTeal.withValues(alpha: 0.15) : kBorder,
                            child: Icon(
                              Icons.check_circle_outline,
                              size: 32,
                              color: isDark ? kNeonTeal : kMuted,
                            ),
                          ),
                          const SizedBox(height: 16),
                          Text(
                            'All caught up!',
                            style: Theme.of(context).textTheme.titleLarge?.copyWith(
                                  fontWeight: FontWeight.w800,
                                ),
                          ),
                          const SizedBox(height: 8),
                          Text(
                            'No reviews due today.',
                            style: TextStyle(
                              color: isDark ? Colors.white38 : kMuted,
                              fontSize: 15,
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                }

                return Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    // Due count header
                    Container(
                      padding: const EdgeInsets.fromLTRB(20, 14, 20, 14),
                      color: isDark ? kSurface : Colors.white,
                      child: Row(
                        children: [
                          Container(
                            width: 32,
                            height: 32,
                            color: isDark ? kNeonTeal : kInk,
                            child: Center(
                              child: Text(
                                '${items.length}',
                                style: TextStyle(
                                  color: isDark ? Colors.black : Colors.white,
                                  fontWeight: FontWeight.w900,
                                  fontSize: 14,
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(width: 12),
                          Text(
                            'DUE TODAY',
                            style: Theme.of(context).textTheme.labelSmall?.copyWith(
                                  letterSpacing: 1.5,
                                  color: isDark ? Colors.white54 : kMuted,
                                ),
                          ),
                        ],
                      ),
                    ),
                    Container(height: 1, color: isDark ? kSubtle : kBorder),
                    Expanded(
                      child: ListView.separated(
                        padding: const EdgeInsets.all(16),
                        itemCount: items.length,
                        separatorBuilder: (_, __) => const SizedBox(height: 8),
                        itemBuilder: (context, index) {
                          final item = items[index];
                          final optionsEn = List<String>.from(
                              jsonDecode(item.question.optionsEn) as List);

                          return GestureDetector(
                            onTap: () => context.push(
                              '/error-notebook/flashcard',
                              extra: items,
                            ),
                            child: Container(
                              padding: const EdgeInsets.fromLTRB(16, 14, 12, 14),
                              decoration: BoxDecoration(
                                color: isDark ? kSurface : Colors.white,
                                border: Border.all(color: isDark ? kSubtle : kBorder),
                              ),
                              child: Stack(
                                children: [
                                  // neon left accent
                                  Positioned(
                                    left: -16,
                                    top: -14,
                                    bottom: -14,
                                    child: Container(width: 3, color: kNeonTeal),
                                  ),
                                  Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        item.question.questionEn,
                                        maxLines: 2,
                                        overflow: TextOverflow.ellipsis,
                                        style: TextStyle(
                                          fontWeight: FontWeight.w500,
                                          color: isDark ? Colors.white : kInk,
                                          fontSize: 14,
                                        ),
                                      ),
                                      const SizedBox(height: 10),
                                      Row(
                                        children: [
                                          _Tag(
                                            label: 'Day ${item.daysInSystem + 1}',
                                            color: kNeonPurple,
                                            isDark: isDark,
                                          ),
                                          const SizedBox(width: 6),
                                          _Tag(
                                            label: '${item.intervalDays}d interval',
                                            color: kNeonYellow,
                                            isDark: isDark,
                                          ),
                                        ],
                                      ),
                                      const SizedBox(height: 8),
                                      Row(
                                        children: [
                                          Icon(Icons.check,
                                              size: 13,
                                              color: isDark ? kNeonTeal : Colors.green[700]),
                                          const SizedBox(width: 4),
                                          Expanded(
                                            child: Text(
                                              optionsEn[item.question.correctOption],
                                              maxLines: 1,
                                              overflow: TextOverflow.ellipsis,
                                              style: TextStyle(
                                                fontSize: 12,
                                                color: isDark ? kNeonTeal : Colors.green[700],
                                              ),
                                            ),
                                          ),
                                          Icon(
                                            Icons.chevron_right,
                                            size: 16,
                                            color: isDark ? Colors.white24 : kMuted,
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                  ],
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

class _Tag extends StatelessWidget {
  final String label;
  final Color color;
  final bool isDark;

  const _Tag({required this.label, required this.color, required this.isDark});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 7, vertical: 2),
      color: color.withValues(alpha: isDark ? 0.18 : 0.10),
      child: Text(
        label,
        style: TextStyle(
          fontSize: 11,
          fontWeight: FontWeight.w700,
          color: isDark ? color : color.withValues(alpha: 0.85),
          letterSpacing: 0.3,
        ),
      ),
    );
  }
}
