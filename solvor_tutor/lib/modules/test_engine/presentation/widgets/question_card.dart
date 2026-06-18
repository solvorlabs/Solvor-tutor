import 'package:flutter/material.dart';

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
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Card(
          elevation: 1,
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Text(
              questionText,
              style: Theme.of(context).textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.w500,
                    height: 1.5,
                  ),
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

  @override
  Widget build(BuildContext context) {
    final labels = ['A', 'B', 'C', 'D'];

    Color bgColor = Colors.white;
    Color borderColor = Colors.grey[300]!;
    Color textColor = Colors.black87;
    Color labelColor = Colors.grey[600]!;
    IconData? icon;

    if (isCorrect) {
      bgColor = Colors.green[50]!;
      borderColor = Colors.green;
      textColor = Colors.green[900]!;
      labelColor = Colors.green;
      icon = Icons.check_circle;
    } else if (isWrong) {
      bgColor = Colors.red[50]!;
      borderColor = Colors.red;
      textColor = Colors.red[900]!;
      labelColor = Colors.red;
      icon = Icons.cancel;
    } else if (isSelected) {
      bgColor = Theme.of(context).colorScheme.primary.withOpacity(0.08);
      borderColor = Theme.of(context).colorScheme.primary;
      labelColor = Theme.of(context).colorScheme.primary;
    }

    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
        decoration: BoxDecoration(
          color: bgColor,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: borderColor, width: isSelected ? 2 : 1),
        ),
        child: Row(
          children: [
            CircleAvatar(
              radius: 14,
              backgroundColor: isSelected || isCorrect || isWrong
                  ? borderColor
                  : Colors.grey[200],
              child: Text(
                labels[index],
                style: TextStyle(
                  color: isSelected || isCorrect || isWrong
                      ? Colors.white
                      : Colors.grey[600],
                  fontWeight: FontWeight.bold,
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
                  fontWeight:
                      isSelected ? FontWeight.w600 : FontWeight.normal,
                ),
              ),
            ),
            if (icon != null) Icon(icon, color: borderColor, size: 20),
          ],
        ),
      ),
    );
  }
}
