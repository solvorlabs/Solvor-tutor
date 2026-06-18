import 'package:flutter/material.dart';

class TimerBar extends StatelessWidget {
  final int elapsedSeconds;
  final int totalMinutes;

  const TimerBar({
    super.key,
    required this.elapsedSeconds,
    this.totalMinutes = 20,
  });

  int get remainingSeconds {
    final total = totalMinutes * 60;
    final remaining = total - elapsedSeconds;
    return remaining < 0 ? 0 : remaining;
  }

  String get formattedTime {
    final mins = remainingSeconds ~/ 60;
    final secs = remainingSeconds % 60;
    return '${mins.toString().padLeft(2, '0')}:${secs.toString().padLeft(2, '0')}';
  }

  bool get isWarning => remainingSeconds < 120;
  bool get isCritical => remainingSeconds < 60;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      decoration: BoxDecoration(
        color: isCritical
            ? Colors.red[50]
            : isWarning
                ? Colors.orange[50]
                : Colors.grey[100],
        borderRadius: BorderRadius.circular(8),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            Icons.timer,
            size: 18,
            color: isCritical
                ? Colors.red
                : isWarning
                    ? Colors.orange
                    : Colors.grey[700],
          ),
          const SizedBox(width: 6),
          Text(
            formattedTime,
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              fontFamily: 'monospace',
              color: isCritical
                  ? Colors.red
                  : isWarning
                      ? Colors.orange
                      : Colors.black87,
            ),
          ),
        ],
      ),
    );
  }
}
