import 'package:flutter/material.dart';
import 'mascot_painter.dart';

export 'mascot_painter.dart' show MascotEmotion;

class MascotWidget extends StatefulWidget {
  final MascotEmotion emotion;
  final double size;

  const MascotWidget({
    super.key,
    required this.emotion,
    this.size = 80,
  });

  @override
  State<MascotWidget> createState() => _MascotWidgetState();
}

class _MascotWidgetState extends State<MascotWidget>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _bounce;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1800),
    )..repeat(reverse: true);
    _bounce = Tween<double>(begin: -4, end: 4).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeInOut),
    );
  }

  @override
  void didUpdateWidget(MascotWidget oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.emotion != widget.emotion) {
      _controller.stop();
      _controller.duration = widget.emotion == MascotEmotion.celebrating
          ? const Duration(milliseconds: 400)
          : const Duration(milliseconds: 1800);
      _controller.repeat(reverse: true);
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return AnimatedBuilder(
      animation: _bounce,
      builder: (context, child) => Transform.translate(
        offset: Offset(0, _bounce.value),
        child: SizedBox(
          width: widget.size,
          height: widget.size * 1.2,
          child: CustomPaint(
            painter: MascotPainter(
              emotion: widget.emotion,
              isDark: isDark,
            ),
          ),
        ),
      ),
    );
  }
}
