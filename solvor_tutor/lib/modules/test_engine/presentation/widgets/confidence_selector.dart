import 'package:flutter/material.dart';

class ConfidenceSelector extends StatelessWidget {
  final String? selected;
  final ValueChanged<String> onSelected;

  const ConfidenceSelector({
    super.key,
    required this.selected,
    required this.onSelected,
  });

  static const _options = [
    ('Sure', Icons.emoji_events, Colors.green),
    ('Guessed', Icons.casino, Colors.orange),
    ('Not Sure', Icons.help_outline, Colors.red),
  ];

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'How sure are you?',
          style: Theme.of(context).textTheme.titleSmall?.copyWith(
                color: Colors.grey[600],
                fontWeight: FontWeight.w600,
              ),
        ),
        const SizedBox(height: 8),
        Row(
          children: _options.map((opt) {
            final isSelected = selected == opt.$1;
            return Expanded(
              child: Padding(
                padding: EdgeInsets.only(
                  left: opt == _options.first ? 0 : 4,
                  right: opt == _options.last ? 0 : 4,
                ),
                child: GestureDetector(
                  onTap: () => onSelected(opt.$1),
                  child: AnimatedContainer(
                    duration: const Duration(milliseconds: 200),
                    padding: const EdgeInsets.symmetric(vertical: 10),
                    decoration: BoxDecoration(
                      color: isSelected ? opt.$3.withOpacity(0.15) : Colors.grey[100],
                      borderRadius: BorderRadius.circular(8),
                      border: Border.all(
                        color: isSelected ? opt.$3 : Colors.grey[300]!,
                        width: isSelected ? 2 : 1,
                      ),
                    ),
                    child: Column(
                      children: [
                        Icon(opt.$2,
                            size: 20,
                            color: isSelected ? opt.$3 : Colors.grey[600]),
                        const SizedBox(height: 4),
                        Text(
                          opt.$1,
                          style: TextStyle(
                            fontSize: 11,
                            fontWeight:
                                isSelected ? FontWeight.bold : FontWeight.normal,
                            color: isSelected ? opt.$3 : Colors.grey[600],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            );
          }).toList(),
        ),
      ],
    );
  }
}
