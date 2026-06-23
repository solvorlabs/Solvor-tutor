import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/theme/design_tokens.dart';
import '../../data/review_repository.dart';
import '../../../error_notebook/presentation/error_notebook_provider.dart';
import '../review_provider.dart';
import '../widgets/explanation_card.dart';

class ReviewScreen extends ConsumerWidget {
  final String testId;

  const ReviewScreen({super.key, required this.testId});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final dataAsync = ref.watch(reviewDataProvider(testId));
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return PopScope(
      canPop: false,
      onPopInvokedWithResult: (didPop, _) {
        if (!didPop) context.go('/home');
      },
      child: Scaffold(
        backgroundColor: isDark ? kVoid : kPaper,
        appBar: AppBar(
          title: const Text('TEST REVIEW'),
          leading: IconButton(
            icon: const Icon(Icons.home_outlined),
            onPressed: () => context.go('/home'),
          ),
        ),
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const PatternBanner(),
            Expanded(child: dataAsync.when(
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
          data: (data) {
            if (data.totalQuestions == 0) {
              return const Center(child: Text('No data available'));
            }

            final quadrants = data.speedAccuracyQuadrants;

            return SingleChildScrollView(
              padding: const EdgeInsets.all(16),
              child: Column(

                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  _SummaryBlock(
                    score: data.correctCount,
                    total: data.totalQuestions,
                    accuracy: data.accuracy,
                    avgTime: data.avgTimePerQuestion,
                    isDark: isDark,
                  ),
                  const SizedBox(height: 12),
                  _SpeedAccuracyBlock(quadrants: quadrants, isDark: isDark),
                  const SizedBox(height: 20),
                  Text(
                    'QUESTION REVIEW',
                    style: Theme.of(context).textTheme.labelSmall?.copyWith(
                          letterSpacing: 1.5,
                          color: isDark ? Colors.white38 : kMuted,
                        ),
                  ),
                  const SizedBox(height: 10),
                  ...data.questions.map((q) {
                    final attempt = data.attempts[q.id];
                    final isCorrect = attempt?.isCorrect ?? false;
                    final optionsEn =
                        List<String>.from(jsonDecode(q.optionsEn) as List);

                    return ExplanationCard(
                      questionText: q.questionEn,
                      options: optionsEn,
                      correctOption: q.correctOption,
                      selectedOption: attempt?.selectedOption,
                      isCorrect: isCorrect,
                      explanation: q.explanationEn,
                      shortcutFormulaNote: q.shortcutFormulaNote,
                      commonMistakeNote: q.commonMistakeNote,
                      showAddToNotebook: !isCorrect,
                      onAddToNotebook: () {
                        ref
                            .read(errorNotebookRepositoryProvider)
                            .triggerSchedule(q.id);
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: const Text('Added to Error Notebook'),
                            backgroundColor: isDark ? kSurface : null,
                            behavior: SnackBarBehavior.floating,
                          ),
                        );
                      },
                    );
                  }),
                  const SizedBox(height: 16),
                  GestureDetector(
                    onTap: () => context.go('/home'),
                    child: Container(
                      padding: const EdgeInsets.symmetric(vertical: 16),
                      color: isDark ? kNeonYellow : kInk,
                      alignment: Alignment.center,
                      child: Text(
                        'BACK TO HOME',
                        style: TextStyle(
                          color: isDark ? Colors.black : Colors.white,
                          fontWeight: FontWeight.w800,
                          letterSpacing: 1.5,
                          fontSize: 14,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 32),
                ],
              ),
            );
          },
        )),
          ],
        ),
      ),
    );
  }
}

class _SummaryBlock extends StatelessWidget {
  final int score;
  final int total;
  final double accuracy;
  final double avgTime;
  final bool isDark;

  const _SummaryBlock({
    required this.score,
    required this.total,
    required this.accuracy,
    required this.avgTime,
    required this.isDark,
  });

  @override
  Widget build(BuildContext context) {
    final accuracyColor = accuracy >= 0.6 ? kNeonTeal : const Color(0xFFFF4444);

    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: isDark ? kSurface : Colors.white,
        border: Border.all(color: isDark ? kSubtle : kBorder),
      ),
      child: Column(
        children: [
          Text(
            'TEST COMPLETE',
            style: Theme.of(context).textTheme.labelSmall?.copyWith(
                  letterSpacing: 2,
                  color: isDark ? kNeonYellow : kMuted,
                ),
          ),
          const SizedBox(height: 16),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              _Stat(
                label: 'SCORE',
                value: '$score/$total',
                color: isDark ? Colors.white : kInk,
              ),
              _Stat(
                label: 'ACCURACY',
                value: '${(accuracy * 100).toInt()}%',
                color: accuracyColor,
              ),
              _Stat(
                label: 'AVG TIME',
                value: '${avgTime.toInt()}s',
                color: isDark ? Colors.white54 : kMuted,
              ),
            ],
          ),
          const SizedBox(height: 16),
          ClipRect(
            child: LinearProgressIndicator(
              value: accuracy,
              minHeight: 6,
              backgroundColor: isDark ? kSubtle : kBorder,
              valueColor: AlwaysStoppedAnimation(accuracyColor),
            ),
          ),
        ],
      ),
    );
  }
}

class _Stat extends StatelessWidget {
  final String label;
  final String value;
  final Color color;

  const _Stat({required this.label, required this.value, required this.color});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          value,
          style: TextStyle(
            fontSize: 26,
            fontWeight: FontWeight.w900,
            color: color,
          ),
        ),
        const SizedBox(height: 4),
        Text(
          label,
          style: TextStyle(
            fontSize: 10,
            letterSpacing: 1.2,
            color: color.withOpacity(0.6),
            fontWeight: FontWeight.w600,
          ),
        ),
      ],
    );
  }
}

class _SpeedAccuracyBlock extends StatelessWidget {
  final Map<String, int> quadrants;
  final bool isDark;

  const _SpeedAccuracyBlock({required this.quadrants, required this.isDark});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: isDark ? kSurface : Colors.white,
        border: Border.all(color: isDark ? kSubtle : kBorder),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'SPEED VS ACCURACY',
            style: Theme.of(context).textTheme.labelSmall?.copyWith(
                  letterSpacing: 1.5,
                  color: isDark ? Colors.white38 : kMuted,
                ),
          ),
          const SizedBox(height: 12),
          Row(
            children: [
              Expanded(
                child: _QuadBox(
                  label: 'Fast + Correct',
                  count: quadrants['Fast+Correct'] ?? 0,
                  color: kNeonTeal,
                  isDark: isDark,
                ),
              ),
              const SizedBox(width: 8),
              Expanded(
                child: _QuadBox(
                  label: 'Slow + Correct',
                  count: quadrants['Slow+Correct'] ?? 0,
                  color: const Color(0xFF38BDF8),
                  isDark: isDark,
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          Row(
            children: [
              Expanded(
                child: _QuadBox(
                  label: 'Fast + Wrong',
                  count: quadrants['Fast+Wrong'] ?? 0,
                  color: kNeonYellow,
                  isDark: isDark,
                ),
              ),
              const SizedBox(width: 8),
              Expanded(
                child: _QuadBox(
                  label: 'Slow + Wrong',
                  count: quadrants['Slow+Wrong'] ?? 0,
                  color: const Color(0xFFFF4444),
                  isDark: isDark,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _QuadBox extends StatelessWidget {
  final String label;
  final int count;
  final Color color;
  final bool isDark;

  const _QuadBox({
    required this.label,
    required this.count,
    required this.color,
    required this.isDark,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 14),
      decoration: BoxDecoration(
        color: color.withOpacity(isDark ? 0.10 : 0.06),
        border: Border.all(color: color.withOpacity(0.4)),
      ),
      child: Column(
        children: [
          Text(
            '$count',
            style: TextStyle(
              fontSize: 28,
              fontWeight: FontWeight.w900,
              color: color,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            label,
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 10,
              color: color.withOpacity(0.8),
              fontWeight: FontWeight.w600,
              letterSpacing: 0.3,
            ),
          ),
        ],
      ),
    );
  }
}
