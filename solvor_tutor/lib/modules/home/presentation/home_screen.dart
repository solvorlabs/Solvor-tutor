import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../core/l10n/app_strings.dart';
import '../../../core/l10n/strings_provider.dart';
import '../../../core/theme/design_tokens.dart';
import '../../../modules/error_notebook/presentation/error_notebook_provider.dart';
import '../../../modules/onboarding/presentation/onboarding_provider.dart';

class HomeScreen extends ConsumerWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final dueCountAsync = ref.watch(errorNotebookDueCountProvider);
    final dueCount = dueCountAsync.asData?.value ?? 0;
    final userAsync = ref.watch(currentUserProvider);
    final user = userAsync.asData?.value;

    final phone = user?.phoneNumber ?? '';
    final displayId =
        phone.length >= 4 ? phone.substring(phone.length - 4) : '----';
    final exam = user?.selectedExam ?? 'SSC / BANKING';

    final isDark = Theme.of(context).brightness == Brightness.dark;
    final ink = isDark ? Colors.white : kInk;
    final lang = ref.watch(langProvider);
    final border = isDark ? kSubtle : kBorder;

    return Scaffold(
      backgroundColor: isDark ? kVoid : kPaper,
      body: SafeArea(
        child: CustomScrollView(
          slivers: [
            // ── Hero header — full-bleed isometric grid ──────────────────
            SliverToBoxAdapter(
              child: LayoutBuilder(
                builder: (context, constraints) {
                  final w = constraints.maxWidth;
                  final bg = isDark ? kVoid : kPaper;
                  return SizedBox(
                    height: 220,
                    child: Stack(
                      children: [
                        // Layer 1: isometric pattern fills entire header
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

                        // Layer 2: gradient backing so text stays legible
                        // solid on left → transparent on right
                        Positioned.fill(
                          child: DecoratedBox(
                            decoration: BoxDecoration(
                              gradient: LinearGradient(
                                colors: [
                                  bg,
                                  bg,
                                  bg.withOpacity(0.0),
                                ],
                                stops: const [0.0, 0.58, 1.0],
                                begin: Alignment.centerLeft,
                                end: Alignment.centerRight,
                              ),
                            ),
                          ),
                        ),

                        // Layer 3: brand text anchored bottom-left
                        Positioned(
                          left: 20,
                          bottom: 28,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Text(
                                AppStrings.get('home_title', lang),
                                style: Theme.of(context)
                                    .textTheme
                                    .displayMedium
                                    ?.copyWith(letterSpacing: -2, height: 0.9),
                              ),
                              NeonText(
                                AppStrings.get('home_subtitle', lang),
                                style: Theme.of(context)
                                    .textTheme
                                    .displayMedium
                                    ?.copyWith(
                                      letterSpacing: -2,
                                      height: 0.9,
                                      fontWeight: FontWeight.w900,
                                    ),
                              ),
                              const SizedBox(height: 16),
                              GestureDetector(
                                 onTap: () => context.push('/settings'),
                                child: Container(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 10, vertical: 6),
                                  decoration: BoxDecoration(
                                    border: Border.all(color: border),
                                    color: isDark ? kSurface : Colors.white,
                                  ),
                                  child: Row(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      Icon(Icons.military_tech_outlined,
                                          size: 13,
                                          color: ink.withOpacity(0.5)),
                                      const SizedBox(width: 6),
                                      Text(
                                        exam.toUpperCase(),
                                        style: Theme.of(context)
                                            .textTheme
                                            .labelSmall
                                            ?.copyWith(
                                              color: ink,
                                              letterSpacing: 1.5,
                                            ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),

                        // Layer 4: profile badge floating top-right over pattern
                        Positioned(
                          right: 16,
                          top: 20,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              GestureDetector(
                                 onTap: () => context.push('/settings'),
                                child: Container(
                                  width: 46,
                                  height: 46,
                                  decoration: BoxDecoration(
                                    // opaque backing so it reads over the pattern
                                    color: isDark ? kVoid : kPaper,
                                    border: Border.all(
                                      color: isDark ? kNeonTeal : kInk,
                                      width: isDark ? 1.5 : 1.5,
                                    ),
                                  ),
                                  child: Center(
                                    child: Text(
                                      displayId,
                                      style: TextStyle(
                                        color: isDark ? kNeonTeal : kInk,
                                        fontWeight: FontWeight.w800,
                                        fontSize: 11,
                                        letterSpacing: 0.5,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                              const SizedBox(height: 8),
                              GestureDetector(
                                 onTap: () => context.push('/settings'),
                                child: Icon(
                                  Icons.settings_outlined,
                                  color: isDark
                                      ? kNeonTeal.withOpacity(0.8)
                                      : kInk.withOpacity(0.5),
                                  size: 20,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  );
                },
              ),
            ),

            // ── Gradient divider ─────────────────────────────────────────
            const SliverToBoxAdapter(child: GradientDivider(height: 3)),

            // ── Section label ─────────────────────────────────────────────
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.fromLTRB(20, 20, 20, 4),
                child: Text(
                  AppStrings.get('home_modules_label', lang),
                  style: Theme.of(context).textTheme.labelSmall,
                ),
              ),
            ),

            // ── Editorial module cards ────────────────────────────────────
            SliverList(
              delegate: SliverChildListDelegate([
                _EditorialCard(
                  category: 'ASSESSMENT',
                  title: AppStrings.get('home_diagnostic', lang),
                  subtitle: AppStrings.get('home_diagnostic_sub', lang),
                  accentColor: kNeonYellow,
                  onTap: () => context.push('/diagnostic'),
                ),
                _EditorialCard(
                  category: 'PRACTICE',
                  title: AppStrings.get('home_practice', lang),
                  subtitle: AppStrings.get('home_practice_sub', lang),
                  accentColor: kNeonPurple,
                  onTap: () => context.push('/diagnostic'),
                ),
                _EditorialCard(
                  category: 'REVIEW',
                  title: AppStrings.get('home_notebook', lang),
                  subtitle: AppStrings.homeNotebookSub(dueCount, lang),
                  badge: dueCount > 0 ? '$dueCount DUE' : null,
                  accentColor: kNeonTeal,
                  onTap: () => context.push('/error-notebook'),
                ),
                _EditorialCard(
                  category: 'ON-DEVICE AI',
                  title: AppStrings.get('home_ai_tutor', lang),
                  subtitle: AppStrings.get('home_ai_tutor_sub', lang),
                  accentColor: kNeonYellow,
                  onTap: () => context.push('/ai-tutor'),
                  isLast: true,
                ),
              ]),
            ),

            const SliverToBoxAdapter(child: SizedBox(height: 32)),
          ],
        ),
      ),
    );
  }
}

class _EditorialCard extends StatelessWidget {
  final String category;
  final String title;
  final String subtitle;
  final String? badge;
  final Color accentColor;
  final VoidCallback onTap;
  final bool isLast;
  final bool disabled;

  const _EditorialCard({
    required this.category,
    required this.title,
    required this.subtitle,
    required this.accentColor,
    required this.onTap,
    this.badge,
    this.isLast = false,
    this.disabled = false,
  });

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final ink = isDark ? Colors.white : kInk;
    final border = isDark ? kSubtle : kBorder;

    final card = Container(
      decoration: BoxDecoration(
        // Dark: pure void so neon accent bar pops; Light: white
        color: isDark ? kVoid : Colors.white,
        border: Border(
          top: BorderSide(color: border),
          bottom: isLast ? BorderSide(color: border) : BorderSide.none,
        ),
      ),
      padding: EdgeInsets.fromLTRB(isDark ? 23 : 20, 20, 20, 20),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Text(
                      category,
                      style: Theme.of(context).textTheme.labelSmall?.copyWith(
                            // Dark: neon accent color for eyebrow; Light: muted
                            color: isDark
                                ? accentColor.withOpacity(0.9)
                                : ink.withOpacity(0.4),
                          ),
                    ),
                    if (badge != null) ...[
                      const SizedBox(width: 8),
                      _NeonBadge(badge!, accentColor),
                    ],
                  ],
                ),
                const SizedBox(height: 6),
                Text(title, style: Theme.of(context).textTheme.titleLarge),
                const SizedBox(height: 4),
                Text(subtitle, style: Theme.of(context).textTheme.bodyMedium),
              ],
            ),
          ),
          const SizedBox(width: 12),
          Padding(
            padding: const EdgeInsets.only(top: 22),
            child: Icon(
              Icons.arrow_forward,
              size: 18,
              color: isDark
                  ? accentColor.withOpacity(disabled ? 0.3 : 0.7)
                  : ink.withOpacity(disabled ? 0.3 : 0.6),
            ),
          ),
        ],
      ),
    );

    return GestureDetector(
      onTap: disabled ? null : onTap,
      child: Opacity(
        opacity: disabled ? 0.45 : 1.0,
        child: isDark
            ? Stack(
                children: [
                  card,
                  // 3px neon accent on left edge (dark only)
                  Positioned(
                    left: 0,
                    top: 0,
                    bottom: 0,
                    child: Container(width: 3, color: accentColor),
                  ),
                ],
              )
            : card,
      ),
    );
  }
}

class _NeonBadge extends StatelessWidget {
  final String label;
  final Color accentColor;

  const _NeonBadge(this.label, this.accentColor);

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    if (isDark) {
      return Container(
        padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
        color: accentColor,
        child: Text(
          label,
          style: const TextStyle(
            color: Colors.black,
            fontSize: 9,
            fontWeight: FontWeight.w800,
            letterSpacing: 0.8,
          ),
        ),
      );
    }

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
      color: kInk,
      child: Text(
        label,
        style: const TextStyle(
          color: kPaper,
          fontSize: 9,
          fontWeight: FontWeight.w800,
          letterSpacing: 0.8,
        ),
      ),
    );
  }
}
