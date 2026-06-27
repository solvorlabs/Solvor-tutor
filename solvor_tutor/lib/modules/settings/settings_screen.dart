import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../app.dart';
import '../../core/auth/auth_state.dart';
import '../../core/database/app_database.dart';
import '../../core/database/daos/users_dao.dart';
import '../../core/l10n/app_strings.dart';
import '../../core/l10n/strings_provider.dart';
import '../../core/theme/design_tokens.dart';
import '../../ai/gemma/gemma_provider.dart';
import '../onboarding/presentation/onboarding_provider.dart';
import 'profile_edit_screen.dart';

class SettingsScreen extends ConsumerWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final lang = ref.watch(langProvider);
    final themeMode = ref.watch(themeModeProvider);
    final userAsync = ref.watch(currentUserProvider);
    final user = userAsync.asData?.value;

    final isDark = Theme.of(context).brightness == Brightness.dark;
    final ink = isDark ? Colors.white : kInk;
    final border = isDark ? kSubtle : kBorder;

    return Scaffold(
      appBar: AppBar(
        title: Text(AppStrings.get('settings_title', lang)),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_rounded),
          onPressed: () => context.go('/home'),
        ),
      ),
      body: ListView(
        children: [
          const GradientDivider(height: 2),

          // ── Profile block ────────────────────────────────────────────
          GestureDetector(
            onTap: () => Navigator.push(
              context,
              MaterialPageRoute(builder: (_) => const ProfileEditScreen()),
            ),
            child: Container(
              padding: const EdgeInsets.all(20),
              child: Row(
                children: [
                  Container(
                    width: 52,
                    height: 52,
                    decoration: BoxDecoration(
                      border: Border.all(color: border, width: 1),
                    ),
                    child: Center(
                      child: Icon(
                        Icons.person_outline,
                        size: 28,
                        color: ink,
                      ),
                    ),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          user?.name ??
                              (user?.phoneNumber != null
                                  ? '+91 ${user!.phoneNumber}'
                                  : 'Student'),
                          style: Theme.of(context).textTheme.titleLarge,
                        ),
                        const SizedBox(height: 2),
                        Text(
                          (user?.selectedExam ?? 'SSC / Banking').toUpperCase(),
                          style: Theme.of(context).textTheme.labelSmall,
                        ),
                        const SizedBox(height: 2),
                        Text(
                          '${user?.uiLanguage ?? 'English'} · ${user?.dailyCapacityMinutes ?? '--'} min / day',
                          style: Theme.of(context).textTheme.labelSmall?.copyWith(
                                color: ink.withOpacity(0.55),
                              ),
                        ),
                      ],
                    ),
                  ),
                  Icon(
                    Icons.chevron_right_rounded,
                    size: 18,
                    color: ink.withOpacity(0.4),
                  ),
                ],
              ),
            ),
          ),
          Divider(height: 1, color: border),

          // ── Appearance ───────────────────────────────────────────────
          _SectionLabel(AppStrings.get('settings_appearance', lang), context),
          _SettingsRow(
            label: 'System default',
            icon: Icons.brightness_auto_outlined,
            selected: themeMode == ThemeMode.system,
            onTap: () =>
                ref.read(themeModeProvider.notifier).state = ThemeMode.system,
          ),
          Divider(height: 1, color: border),
          _SettingsRow(
            label: 'Light',
            icon: Icons.light_mode_outlined,
            selected: themeMode == ThemeMode.light,
            onTap: () =>
                ref.read(themeModeProvider.notifier).state = ThemeMode.light,
          ),
          Divider(height: 1, color: border),
          _SettingsRow(
            label: 'Dark  ·  neon accents',
            icon: Icons.dark_mode_outlined,
            selected: themeMode == ThemeMode.dark,
            onTap: () =>
                ref.read(themeModeProvider.notifier).state = ThemeMode.dark,
            neonLabel: true,
          ),
          Divider(height: 1, color: border),

          // ── Study preferences ────────────────────────────────────────
          _SectionLabel(AppStrings.get('settings_study', lang), context),
          _TappableRow(
            label: 'Language',
            value: user?.uiLanguage ?? 'English',
            onTap: () => _showLanguageSheet(context, ref, user?.id),
          ),
          Divider(height: 1, color: border),
          _TappableRow(
            label: 'Daily goal',
            value: user?.dailyCapacityMinutes != null
                ? '${user!.dailyCapacityMinutes} min'
                : 'Not set',
            onTap: () => _showGoalSheet(context, ref, user?.id),
          ),
          Divider(height: 1, color: border),

          // ── About ────────────────────────────────────────────────────
          _SectionLabel(AppStrings.get('settings_about', lang), context),
          const _InfoRow(label: 'Version', value: '1.0.0'),
          Divider(height: 1, color: kSubtle),
          const _InfoRow(label: 'Build', value: 'Samsung Hackathon'),
          Divider(height: 1, color: kSubtle),
          const _InfoRow(label: 'AI Runtime', value: 'LiteRT · On-device'),
          Divider(height: 1, color: kSubtle),
          _GemmaSettingsTile(isDark: isDark),
          Divider(height: 1, color: kSubtle),

          // ── Logout ───────────────────────────────────────────────────
          Divider(height: 1, color: isDark ? Colors.red[400] : Colors.red[700]),
          GestureDetector(
            onTap: () => _showLogoutDialog(context, ref, user?.id),
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 13),
              child: Row(
                children: [
                  Icon(
                    Icons.logout,
                    size: 18,
                    color: isDark ? Colors.red[400] : Colors.red[700],
                  ),
                  const SizedBox(width: 14),
                  Text(
                    'Log out',
                    style:
                        Theme.of(context).textTheme.titleMedium?.copyWith(
                              color: isDark ? Colors.red[400] : Colors.red[700],
                            ),
                  ),
                ],
              ),
            ),
          ),

          const SizedBox(height: 40),
        ],
      ),
    );
  }

  void _showLanguageSheet(BuildContext context, WidgetRef ref, String? userId) {
    if (userId == null) return;
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final ink = isDark ? Colors.white : kInk;
    final border = isDark ? kSubtle : kBorder;
    final currentLang = ref.read(currentUserProvider).asData?.value?.uiLanguage;
    const options = ['English', 'Hindi', 'Hinglish'];

    showModalBottomSheet(
      context: context,
      backgroundColor: isDark ? kSurface : Colors.white,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.zero),
      builder: (ctx) {
        return Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            for (final option in options) ...[
              GestureDetector(
                onTap: () async {
                  await UsersDao(ref.read(databaseProvider))
                      .updateLanguage(userId, option);
                  ref.invalidate(currentUserProvider);
                  ref.read(onboardingProvider.notifier).setLanguage(option);
                  if (ctx.mounted) Navigator.pop(ctx);
                },
                child: Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 20, vertical: 13),
                  child: Row(
                    children: [
                      Text(
                        option,
                        style: Theme.of(context).textTheme.titleMedium,
                      ),
                      const Spacer(),
                      if (option == currentLang)
                        Icon(Icons.check, size: 16, color: ink),
                    ],
                  ),
                ),
              ),
              Divider(height: 1, color: border),
            ],
          ],
        );
      },
    );
  }

  void _showGoalSheet(BuildContext context, WidgetRef ref, String? userId) {
    if (userId == null) return;
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final ink = isDark ? Colors.white : kInk;
    final border = isDark ? kSubtle : kBorder;
    final currentGoal =
        ref.read(currentUserProvider).asData?.value?.dailyCapacityMinutes;

    final options = [
      ('30 min', 30),
      ('1 hour', 60),
      ('2 hours', 120),
      ('3+ hours', 180),
    ];

    showModalBottomSheet(
      context: context,
      backgroundColor: isDark ? kSurface : Colors.white,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.zero),
      builder: (ctx) {
        return Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            for (final (label, minutes) in options) ...[
              GestureDetector(
                onTap: () async {
                  await UsersDao(ref.read(databaseProvider))
                      .updateDailyGoal(userId, minutes);
                  ref.invalidate(currentUserProvider);
                  if (ctx.mounted) Navigator.pop(ctx);
                },
                child: Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 20, vertical: 13),
                  child: Row(
                    children: [
                      Text(
                        label,
                        style: Theme.of(context).textTheme.titleMedium,
                      ),
                      const Spacer(),
                      if (minutes == currentGoal)
                        Icon(Icons.check, size: 16, color: ink),
                    ],
                  ),
                ),
              ),
              Divider(height: 1, color: border),
            ],
          ],
        );
      },
    );
  }

  void _showLogoutDialog(BuildContext context, WidgetRef ref, String? userId) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        backgroundColor: isDark ? kSurface : Colors.white,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.zero),
        title: const Text('Log out?'),
        content: const Text('Are you sure you want to log out?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(ctx),
            child: Text(
              'Cancel',
              style: TextStyle(
                color: isDark ? Colors.white70 : Colors.black54,
              ),
            ),
          ),
          TextButton(
            onPressed: () async {
              if (userId != null) {
                await UsersDao(ref.read(databaseProvider)).deleteUser(userId);
              }
              ref.read(authStateProvider.notifier).setLoggedIn(false);
              if (ctx.mounted) Navigator.pop(ctx);
              context.go('/onboarding');
            },
            child: Text(
              'Log out',
              style: TextStyle(
                color: isDark ? Colors.red[400] : Colors.red[700],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _SectionLabel extends StatelessWidget {
  final String label;
  final BuildContext ctx;
  const _SectionLabel(this.label, this.ctx);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(20, 20, 20, 8),
      child: Text(
        label,
        style: Theme.of(context).textTheme.labelSmall,
      ),
    );
  }
}

class _SettingsRow extends StatelessWidget {
  final String label;
  final IconData icon;
  final bool selected;
  final VoidCallback onTap;
  final bool neonLabel;

  const _SettingsRow({
    required this.label,
    required this.icon,
    required this.selected,
    required this.onTap,
    this.neonLabel = false,
  });

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final ink = isDark ? Colors.white : kInk;

    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 14),
        child: Row(
          children: [
            Icon(icon, size: 18, color: ink.withOpacity(selected ? 1.0 : 0.4)),
            const SizedBox(width: 14),
            Expanded(
              child: neonLabel && selected && isDark
                  ? ShaderMask(
                      blendMode: BlendMode.srcIn,
                      shaderCallback: (b) => kNeonGradient.createShader(b),
                      child: Text(label,
                          style: Theme.of(context).textTheme.titleMedium),
                    )
                  : Text(
                      label,
                      style: Theme.of(context).textTheme.titleMedium?.copyWith(
                            color: ink.withOpacity(selected ? 1.0 : 0.55),
                          ),
                    ),
            ),
            if (selected)
              Icon(Icons.check, size: 16, color: ink),
          ],
        ),
      ),
    );
  }
}

class _TappableRow extends StatelessWidget {
  final String label;
  final String value;
  final VoidCallback onTap;

  const _TappableRow({
    required this.label,
    required this.value,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final ink = isDark ? Colors.white : kInk;

    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 13),
        child: Row(
          children: [
            Text(
              label,
              style: Theme.of(context).textTheme.titleMedium?.copyWith(
                    color: ink.withOpacity(0.55),
                  ),
            ),
            const Spacer(),
            Text(
              value,
              style: Theme.of(context).textTheme.titleMedium,
            ),
            const SizedBox(width: 4),
            Icon(
              Icons.chevron_right_rounded,
              size: 18,
              color: ink.withOpacity(0.4),
            ),
          ],
        ),
      ),
    );
  }
}

class _GemmaSettingsTile extends ConsumerWidget {
  final bool isDark;

  const _GemmaSettingsTile({required this.isDark});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final gemmaState = ref.watch(gemmaDownloadStatusProvider);
    final ink = isDark ? Colors.white : kInk;

    return GestureDetector(
      onTap: () {
        if (gemmaState.status == GemmaDownloadStatus.ready) {
          ref.read(gemmaDownloadStatusProvider.notifier).deleteModel();
        } else if (gemmaState.status == GemmaDownloadStatus.notDownloaded) {
          ref.read(gemmaDownloadStatusProvider.notifier).startDownload();
        }
      },
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 13),
        child: Row(
          children: [
            Icon(
              Icons.memory,
              size: 18,
              color: gemmaState.status == GemmaDownloadStatus.ready
                  ? kNeonTeal
                  : ink.withOpacity(0.4),
            ),
            const SizedBox(width: 14),
            Text(
              'Gemma 4',
              style: Theme.of(context).textTheme.titleMedium?.copyWith(
                    color: ink.withOpacity(0.55),
                  ),
            ),
            const Spacer(),
            Text(
              switch (gemmaState.status) {
                GemmaDownloadStatus.notDownloaded => 'Not downloaded',
                GemmaDownloadStatus.downloading => 'Downloading...',
                GemmaDownloadStatus.ready => 'Ready (1.5 GB)',
                GemmaDownloadStatus.error =>
                  gemmaState.error != null && gemmaState.error!.length < 40
                      ? gemmaState.error!
                      : 'Error',
              },
              style: Theme.of(context).textTheme.titleMedium?.copyWith(
                    color: gemmaState.status == GemmaDownloadStatus.ready
                        ? kNeonTeal
                        : ink,
                  ),
            ),
            const SizedBox(width: 4),
            Icon(
              gemmaState.status == GemmaDownloadStatus.ready
                  ? Icons.delete_outline
                  : Icons.download_outlined,
              size: 16,
              color: gemmaState.status == GemmaDownloadStatus.ready
                  ? Colors.red[300]
                  : ink.withOpacity(0.4),
            ),
          ],
        ),
      ),
    );
  }
}

class _InfoRow extends StatelessWidget {
  final String label;
  final String value;

  const _InfoRow({required this.label, required this.value});

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final ink = isDark ? Colors.white : kInk;

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 13),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            label,
            style: Theme.of(context).textTheme.titleMedium?.copyWith(
                  color: ink.withOpacity(0.55),
                ),
          ),
          Text(
            value,
            style: Theme.of(context).textTheme.titleMedium,
          ),
        ],
      ),
    );
  }
}
