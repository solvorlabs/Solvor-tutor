import 'package:flutter/material.dart';
import '../../../../core/theme/design_tokens.dart';

class ConfidenceSelector extends StatelessWidget {
  final String? selected;
  final ValueChanged<String> onSelected;

  const ConfidenceSelector({
    super.key,
    required this.selected,
    required this.onSelected,
  });

  static const _options = [
    ('Sure', Icons.check_circle_outline),
    ('Guessed', Icons.shuffle),
    ('Not Sure', Icons.help_outline),
  ];

  static const _neonRed = Color(0xFFFF4444);

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    Color _accent(String label) {
      if (isDark) {
        return switch (label) {
          'Sure' => kNeonTeal,
          'Guessed' => kNeonYellow,
          _ => _neonRed,
        };
      }
      return switch (label) {
        'Sure' => Colors.green,
        'Guessed' => Colors.orange,
        _ => Colors.red,
      };
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'HOW SURE ARE YOU?',
          style: Theme.of(context).textTheme.labelSmall?.copyWith(
                color: isDark ? Colors.white38 : kMuted,
                letterSpacing: 1.2,
              ),
        ),
        const SizedBox(height: 8),
        Row(
          children: [
            for (var i = 0; i < _options.length; i++) ...[
              if (i > 0) const SizedBox(width: 6),
              Expanded(
                child: _ConfidenceChip(
                  label: _options[i].$1,
                  icon: _options[i].$2,
                  isSelected: selected == _options[i].$1,
                  accent: _accent(_options[i].$1),
                  isDark: isDark,
                  onTap: () => onSelected(_options[i].$1),
                ),
              ),
            ],
          ],
        ),
      ],
    );
  }
}

class _ConfidenceChip extends StatelessWidget {
  final String label;
  final IconData icon;
  final bool isSelected;
  final Color accent;
  final bool isDark;
  final VoidCallback onTap;

  const _ConfidenceChip({
    required this.label,
    required this.icon,
    required this.isSelected,
    required this.accent,
    required this.isDark,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 150),
        padding: const EdgeInsets.symmetric(vertical: 10),
        decoration: BoxDecoration(
          color: isSelected
              ? accent.withOpacity(isDark ? 0.12 : 0.08)
              : (isDark ? kSurface : Colors.white),
          border: Border.all(
            color: isSelected ? accent : (isDark ? kSubtle : kBorder),
            width: isSelected ? 2 : 1,
          ),
        ),
        child: Column(
          children: [
            Icon(
              icon,
              size: 18,
              color: isSelected ? accent : (isDark ? Colors.white38 : kMuted),
            ),
            const SizedBox(height: 4),
            Text(
              label,
              style: TextStyle(
                fontSize: 11,
                fontWeight: isSelected ? FontWeight.w700 : FontWeight.normal,
                color: isSelected ? accent : (isDark ? Colors.white38 : kMuted),
                letterSpacing: 0.3,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
