import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../core/l10n/app_strings.dart';
import '../../../core/l10n/strings_provider.dart';
import '../../../core/theme/design_tokens.dart';
import '../../../core/mascot/mascot_widget.dart';
import '../../error_notebook/presentation/error_notebook_provider.dart';
import '../../onboarding/presentation/onboarding_provider.dart';
import 'providers/home_provider.dart';

class HomeScreen extends ConsumerWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final dueCountAsync = ref.watch(errorNotebookDueCountProvider);
    final dueCount = dueCountAsync.asData?.value ?? 0;
    final userAsync = ref.watch(currentUserProvider);
    final user = userAsync.asData?.value;

    final greetingAsync = ref.watch(homeGreetingProvider);
    final streakAsync = ref.watch(streakProvider);
    final progressAsync = ref.watch(dailyProgressProvider);

    final isDark = Theme.of(context).brightness == Brightness.dark;
    final ink = isDark ? Colors.white : kInk;
    final lang = ref.watch(langProvider);

    final exam = user?.selectedExam ?? 'SSC / BANKING';

    String weakTopic = 'General Studies';
    try {
      final list = List<String>.from(
          jsonDecode(user?.weakDomains ?? '[]') as List);
      if (list.isNotEmpty) weakTopic = list.first;
    } catch (_) {}

    final streakData = streakAsync.asData?.value;
    final progress = progressAsync.asData?.value;

    return Scaffold(
      backgroundColor: isDark ? kVoid : kPaper,
      body: SafeArea(
        child: CustomScrollView(
          slivers: [
            SliverToBoxAdapter(
              child: LayoutBuilder(
                builder: (context, constraints) {
                  return SizedBox(
                    height: 200,
                    child: Stack(
                      children: [
                        Positioned.fill(
                          child: ClipRect(
                            child: CustomPaint(
                              painter: IsometricPainter(
                                isDark: isDark,
                                spacing: 26,
                                strokeWidth: 1.3,
                              ),
                            ),
                          ),
                        ),
                        Positioned.fill(
                          child: DecoratedBox(
                            decoration: BoxDecoration(
                              gradient: LinearGradient(
                                begin: Alignment.centerLeft,
                                end: Alignment.centerRight,
                                colors: isDark
                                    ? [
                                        kVoid,
                                        kVoid.withValues(alpha: 0.85),
                                        kVoid.withValues(alpha: 0.0),
                                      ]
                                    : [
                                        kPaper,
                                        kPaper.withValues(alpha: 0.85),
                                        kPaper.withValues(alpha: 0.0),
                                      ],
                              ),
                            ),
                          ),
                        ),
                        Positioned(
                          left: 20,
                          top: 0,
                          bottom: 0,
                          right: 0,
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              MascotWidget(
                                emotion: streakData?.studiedToday == true
                                    ? MascotEmotion.happy
                                    : MascotEmotion.greeting,
                                size: 90,
                              ),
                              const SizedBox(width: 16),
                              Expanded(
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    greetingAsync.when(
                                      data: (g) => Text(
                                        g,
                                        style: TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.w700,
                                          color: ink,
                                          height: 1.35,
                                        ),
                                      ),
                                      loading: () => Text(
                                        'Namaste!',
                                        style: TextStyle(
                                            fontSize: 16,
                                            fontWeight: FontWeight.w700,
                                            color: ink),
                                      ),
                                      error: (_, __) => const SizedBox.shrink(),
                                    ),
                                    const SizedBox(height: 8),
                                    if (streakData != null &&
                                        streakData.currentStreak > 0)
                                      _StreakBadge(
                                          streak: streakData.currentStreak,
                                          isDark: isDark),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                        Positioned(
                          top: 16,
                          right: 16,
                          child: Container(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 10, vertical: 4),
                            color:
                                isDark ? kNeonPurple.withValues(alpha: 0.2) : kInk.withValues(alpha: 0.07),
                            child: Text(
                              exam.toUpperCase(),
                              style: TextStyle(
                                fontSize: 10,
                                fontWeight: FontWeight.w700,
                                letterSpacing: 1.2,
                                color: isDark ? kNeonPurple : kMuted,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  );
                },
              ),
            ),

            if (progress != null)
              SliverToBoxAdapter(
                child: _DailyPlanCard(progress: progress, isDark: isDark),
              ),

            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.fromLTRB(16, 16, 16, 0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'ABHI KAREIN',
                      style: TextStyle(
                        fontSize: 10,
                        fontWeight: FontWeight.w700,
                        letterSpacing: 1.4,
                        color: isDark ? kNeonTeal : kMuted,
                      ),
                    ),
                    const SizedBox(height: 10),
                    Row(
                      children: [
                        Expanded(
                          child: _QuickCard(
                            label: 'Aaj ka Topic',
                            sublabel: weakTopic,
                            icon: Icons.auto_stories_outlined,
                            accentColor: kNeonTeal,
                            isDark: isDark,
                            onTap: () => context.push('/lesson/$weakTopic'),
                          ),
                        ),
                        const SizedBox(width: 10),
                        Expanded(
                          child: _QuickCard(
                            label: 'AI Tutor',
                            sublabel: 'Solvy se baat karo',
                            icon: Icons.chat_bubble_outline,
                            accentColor: kNeonPurple,
                            isDark: isDark,
                            onTap: () => context.push('/tutor-chat'),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),

            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.fromLTRB(16, 24, 16, 0),
                child: Text(
                  'PRACTICE',
                  style: TextStyle(
                    fontSize: 10,
                    fontWeight: FontWeight.w700,
                    letterSpacing: 1.4,
                    color: isDark ? kNeonYellow : kMuted,
                  ),
                ),
              ),
            ),

            SliverPadding(
              padding: const EdgeInsets.fromLTRB(16, 10, 16, 32),
              sliver: SliverGrid(
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  mainAxisSpacing: 10,
                  crossAxisSpacing: 10,
                  childAspectRatio: 1.6,
                ),
                delegate: SliverChildListDelegate([
                  _FeatureCard(
                    label: AppStrings.get('home_diagnostic', lang),
                    icon: Icons.biotech_outlined,
                    accent: kNeonYellow,
                    isDark: isDark,
                    onTap: () => context.push('/diagnostic'),
                  ),
                  _FeatureCard(
                    label: AppStrings.get('home_practice', lang),
                    icon: Icons.quiz_outlined,
                    accent: kNeonTeal,
                    isDark: isDark,
                    onTap: () => context.push('/test/quick'),
                  ),
                  _FeatureCard(
                    label: AppStrings.get('home_error_notebook', lang),
                    icon: Icons.book_outlined,
                    accent: kNeonPurple,
                    badge: dueCount > 0 ? '$dueCount due' : null,
                    isDark: isDark,
                    onTap: () => context.push('/error-notebook'),
                  ),
                  _FeatureCard(
                    label: AppStrings.get('home_review', lang),
                    icon: Icons.history_outlined,
                    accent: kNeonYellow,
                    isDark: isDark,
                    onTap: () => context.push('/review/latest'),
                  ),
                ]),
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton.small(
        onPressed: () => context.push('/settings'),
        backgroundColor: isDark ? kSurface : kBorder,
        child: Icon(Icons.settings_outlined, color: isDark ? Colors.white54 : kMuted, size: 18),
      ),
    );
  }
}

class _StreakBadge extends StatelessWidget {
  final int streak;
  final bool isDark;
  const _StreakBadge({required this.streak, required this.isDark});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
      decoration: BoxDecoration(
        color: isDark ? kNeonYellow.withValues(alpha: 0.15) : kInk.withValues(alpha: 0.08),
        border: Border.all(
          color: isDark ? kNeonYellow.withValues(alpha: 0.4) : kInk.withValues(alpha: 0.15),
        ),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(Icons.local_fire_department,
              size: 14, color: isDark ? kNeonYellow : kInk),
          const SizedBox(width: 5),
          Text(
            '$streak day streak',
            style: TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.w700,
              color: isDark ? kNeonYellow : kInk,
            ),
          ),
        ],
      ),
    );
  }
}

class _DailyPlanCard extends StatelessWidget {
  final DailyProgress progress;
  final bool isDark;
  const _DailyPlanCard({required this.progress, required this.isDark});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 16, 16, 0),
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: isDark ? kSurface : Colors.white,
          border: Border(
            left: BorderSide(color: kNeonTeal, width: 3),
            top: BorderSide(color: isDark ? kSubtle : kBorder),
            right: BorderSide(color: isDark ? kSubtle : kBorder),
            bottom: BorderSide(color: isDark ? kSubtle : kBorder),
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Text(
                  'AAJ KA PLAN',
                  style: TextStyle(
                    fontSize: 10,
                    fontWeight: FontWeight.w700,
                    letterSpacing: 1.4,
                    color: isDark ? kNeonTeal : kMuted,
                  ),
                ),
                const Spacer(),
                Text(
                  progress.isComplete
                      ? 'Complete! 🎉'
                      : '${progress.questionsAnswered} / ${progress.dailyGoal} questions',
                  style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w600,
                    color: isDark ? Colors.white70 : kInk,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 10),
            ClipRect(
              child: Container(
                height: 6,
                color: isDark ? kSubtle : kBorder,
                child: FractionallySizedBox(
                  alignment: Alignment.centerLeft,
                  widthFactor: progress.fraction,
                  child: Container(
                    color: progress.isComplete ? kNeonYellow : kNeonTeal,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _QuickCard extends StatelessWidget {
  final String label;
  final String sublabel;
  final IconData icon;
  final Color accentColor;
  final bool isDark;
  final VoidCallback onTap;

  const _QuickCard({
    required this.label,
    required this.sublabel,
    required this.icon,
    required this.accentColor,
    required this.isDark,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(14),
        decoration: BoxDecoration(
          color: isDark ? kSurface : Colors.white,
          border: Border(
            left: BorderSide(color: accentColor, width: 3),
            top: BorderSide(color: isDark ? kSubtle : kBorder),
            right: BorderSide(color: isDark ? kSubtle : kBorder),
            bottom: BorderSide(color: isDark ? kSubtle : kBorder),
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Icon(icon, color: accentColor, size: 20),
            const SizedBox(height: 8),
            Text(
              label,
              style: TextStyle(
                fontSize: 13,
                fontWeight: FontWeight.w700,
                color: isDark ? Colors.white : kInk,
              ),
            ),
            const SizedBox(height: 2),
            Text(
              sublabel,
              style: TextStyle(
                fontSize: 11,
                color: isDark ? Colors.white38 : kMuted,
              ),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
          ],
        ),
      ),
    );
  }
}

class _FeatureCard extends StatelessWidget {
  final String label;
  final IconData icon;
  final Color accent;
  final bool isDark;
  final String? badge;
  final VoidCallback onTap;

  const _FeatureCard({
    required this.label,
    required this.icon,
    required this.accent,
    required this.isDark,
    required this.onTap,
    this.badge,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(14),
        decoration: BoxDecoration(
          color: isDark ? kSurface : Colors.white,
          border: Border.all(color: isDark ? kSubtle : kBorder),
        ),
        child: Stack(
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Icon(icon, color: accent, size: 22),
                Text(
                  label,
                  style: TextStyle(
                    fontSize: 13,
                    fontWeight: FontWeight.w600,
                    color: isDark ? Colors.white : kInk,
                  ),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
              ],
            ),
            if (badge != null)
              Positioned(
                top: 0,
                right: 0,
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                  color: accent,
                  child: Text(
                    badge!,
                    style: const TextStyle(
                      fontSize: 9,
                      fontWeight: FontWeight.w700,
                      color: Colors.black,
                    ),
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }
}
