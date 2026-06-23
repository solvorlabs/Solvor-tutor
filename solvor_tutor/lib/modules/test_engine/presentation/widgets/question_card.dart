import 'package:flutter/material.dart';
import '../../../../core/theme/design_tokens.dart';

class QuestionCard extends StatelessWidget {
  final String questionText;
  final List<String> options;
  final int? selectedOption;
  final int? correctOption;
  final bool showCorrect;
  final ValueChanged<int> onOptionSelected;

  const QuestionCard({
    super.key,
    required this.questionText,
    required this.options,
    required this.selectedOption,
    this.correctOption,
    this.showCorrect = false,
    required this.onOptionSelected,
  });

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Container(
          width: double.infinity,
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: isDark ? kSurface : Colors.white,
            border: Border.all(color: isDark ? kSubtle : kBorder),
          ),
          child: Text(
            questionText,
            style: Theme.of(context).textTheme.titleMedium?.copyWith(
                  fontWeight: FontWeight.w500,
                  height: 1.5,
                ),
          ),
        ),
        const SizedBox(height: 12),
        ...List.generate(options.length, (index) {
          return Padding(
            padding: const EdgeInsets.only(bottom: 8),
            child: _OptionTile(
              index: index,
              text: options[index],
              isSelected: selectedOption == index,
              isCorrect: showCorrect && correctOption == index,
              isWrong: showCorrect &&
                  selectedOption == index &&
                  correctOption != index,
              onTap: () => onOptionSelected(index),
            ),
          );
        }),
      ],
    );
  }
}

class _OptionTile extends StatelessWidget {
  final int index;
  final String text;
  final bool isSelected;
  final bool isCorrect;
  final bool isWrong;
  final VoidCallback onTap;

  const _OptionTile({
    required this.index,
    required this.text,
    required this.isSelected,
    required this.isCorrect,
    required this.isWrong,
    required this.onTap,
  });

  static const _labels = ['A', 'B', 'C', 'D'];
  static const _neonRed = Color(0xFFFF4444);

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    Color borderColor = isDark ? kSubtle : kBorder;
    Color bgColor = isDark ? kSurface : Colors.white;
    Color textColor = isDark ? Colors.white : kInk;
    Color labelBg = isDark ? kSubtle : kBorder;
    Color labelText = isDark ? Colors.white54 : kMuted;
    IconData? icon;

    if (isCorrect) {
      borderColor = kNeonTeal;
      bgColor = kNeonTeal.withOpacity(isDark ? 0.10 : 0.05);
      textColor = isDark ? kNeonTeal : Colors.green[900]!;
      labelBg = kNeonTeal;
      labelText = Colors.black;
      icon = Icons.check_circle;
    } else if (isWrong) {
      borderColor = _neonRed;
      bgColor = _neonRed.withOpacity(isDark ? 0.10 : 0.05);
      textColor = isDark ? _neonRed : Colors.red[900]!;
      labelBg = _neonRed;
      labelText = Colors.white;
      icon = Icons.cancel;
    } else if (isSelected) {
      borderColor = isDark ? kNeonYellow : kInk;
      bgColor = isDark ? kNeonYellow.withOpacity(0.06) : kInk.withOpacity(0.04);
      labelBg = isDark ? kNeonYellow : kInk;
      labelText = isDark ? Colors.black : Colors.white;
    }

    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
        decoration: BoxDecoration(
          color: bgColor,
          border: Border.all(
            color: borderColor,
            width: isSelected || isCorrect || isWrong ? 2 : 1,
          ),
        ),
        child: Row(
          children: [
            Container(
              width: 28,
              height: 28,
              color: labelBg,
              alignment: Alignment.center,
              child: Text(
                _labels[index],
                style: TextStyle(
                  color: labelText,
                  fontWeight: FontWeight.w800,
                  fontSize: 12,
                ),
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Text(
                text,
                style: TextStyle(
                  color: textColor,
                  fontWeight: isSelected ? FontWeight.w600 : FontWeight.normal,
                ),
              ),
            ),
            if (icon != null) ...[
              const SizedBox(width: 8),
              Icon(icon, color: borderColor, size: 20),
            ],
          ],
        ),
      ),
    );
  }
}
