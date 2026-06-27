import 'dart:math' as math;
import 'package:flutter/material.dart';
import '../theme/design_tokens.dart';

enum MascotEmotion { idle, thinking, happy, sad, celebrating, greeting }

class MascotPainter extends CustomPainter {
  final MascotEmotion emotion;
  final bool isDark;

  const MascotPainter({required this.emotion, required this.isDark});

  @override
  void paint(Canvas canvas, Size size) {
    final cx = size.width / 2;
    final cy = size.height / 2;
    final r = size.width * 0.38;

    final headPaint = Paint()
      ..color = isDark ? kNeonPurple : kInk
      ..style = PaintingStyle.fill;

    final eyeWhite = Paint()
      ..color = Colors.white
      ..style = PaintingStyle.fill;

    final pupilPaint = Paint()
      ..color = isDark ? kNeonYellow : kPaper
      ..style = PaintingStyle.fill;

    final accentPaint = Paint()
      ..color = isDark ? kNeonYellow : kPaper
      ..style = PaintingStyle.fill;

    final mouthPaint = Paint()
      ..color = Colors.white
      ..style = PaintingStyle.stroke
      ..strokeWidth = size.width * 0.04
      ..strokeCap = StrokeCap.round;

    final antPaint = Paint()
      ..color = isDark ? kNeonTeal : kPaper
      ..strokeWidth = size.width * 0.04
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round;
    canvas.drawLine(
      Offset(cx - r * 0.4, cy - r),
      Offset(cx - r * 0.55, cy - r * 1.5),
      antPaint,
    );
    canvas.drawCircle(Offset(cx - r * 0.55, cy - r * 1.55), r * 0.1, Paint()..color = isDark ? kNeonTeal : kPaper);

    canvas.drawLine(
      Offset(cx + r * 0.4, cy - r),
      Offset(cx + r * 0.55, cy - r * 1.5),
      antPaint,
    );
    canvas.drawCircle(Offset(cx + r * 0.55, cy - r * 1.55), r * 0.1, Paint()..color = isDark ? kNeonTeal : kPaper);

    final headRect = RRect.fromRectAndRadius(
      Rect.fromCenter(center: Offset(cx, cy), width: r * 2, height: r * 1.9),
      Radius.circular(r * 0.4),
    );
    canvas.drawRRect(headRect, headPaint);

    final eyeRadius = r * 0.28;
    final eyeY = cy - r * 0.18;
    canvas.drawCircle(Offset(cx - r * 0.38, eyeY), eyeRadius, eyeWhite);
    canvas.drawCircle(Offset(cx + r * 0.38, eyeY), eyeRadius, eyeWhite);

    final double pShiftX = emotion == MascotEmotion.thinking ? r * 0.08 : 0;
    final double pShiftY = emotion == MascotEmotion.sad ? r * 0.06 : 0;
    canvas.drawCircle(Offset(cx - r * 0.38 + pShiftX, eyeY + pShiftY), eyeRadius * 0.45, pupilPaint);
    canvas.drawCircle(Offset(cx + r * 0.38 + pShiftX, eyeY + pShiftY), eyeRadius * 0.45, pupilPaint);

    if (emotion == MascotEmotion.celebrating) {
      final starPaint = Paint()..color = kNeonYellow..style = PaintingStyle.fill;
      _drawStar(canvas, Offset(cx - r * 0.38, eyeY), eyeRadius * 0.5, starPaint);
      _drawStar(canvas, Offset(cx + r * 0.38, eyeY), eyeRadius * 0.5, starPaint);
    }

    final mouthY = cy + r * 0.3;
    final beakPath = Path()
      ..moveTo(cx - r * 0.12, mouthY - r * 0.05)
      ..lineTo(cx + r * 0.12, mouthY - r * 0.05)
      ..lineTo(cx, mouthY + r * 0.15)
      ..close();
    canvas.drawPath(beakPath, accentPaint);

    final mouthRect = Rect.fromCenter(
      center: Offset(cx, mouthY + r * 0.22),
      width: r * 0.6,
      height: r * 0.35,
    );
    switch (emotion) {
      case MascotEmotion.happy:
      case MascotEmotion.celebrating:
      case MascotEmotion.greeting:
        canvas.drawArc(mouthRect, 0, math.pi, false, mouthPaint);
        break;
      case MascotEmotion.sad:
        canvas.drawArc(mouthRect, math.pi, math.pi, false, mouthPaint);
        break;
      case MascotEmotion.thinking:
        canvas.drawLine(
          Offset(cx - r * 0.15, mouthY + r * 0.22),
          Offset(cx + r * 0.15, mouthY + r * 0.22),
          mouthPaint,
        );
        canvas.drawCircle(
          Offset(cx + r * 0.26, mouthY + r * 0.22),
          r * 0.05,
          Paint()..color = Colors.white,
        );
        break;
      case MascotEmotion.idle:
        canvas.drawArc(
          Rect.fromCenter(
            center: Offset(cx, mouthY + r * 0.22),
            width: r * 0.4,
            height: r * 0.2,
          ),
          0,
          math.pi,
          false,
          mouthPaint,
        );
        break;
    }
  }

  void _drawStar(Canvas canvas, Offset center, double radius, Paint paint) {
    final path = Path();
    for (int i = 0; i < 5; i++) {
      final outer = Offset(
        center.dx + radius * math.cos((i * 4 * math.pi / 5) - math.pi / 2),
        center.dy + radius * math.sin((i * 4 * math.pi / 5) - math.pi / 2),
      );
      final inner = Offset(
        center.dx + radius * 0.4 * math.cos(((i * 4 + 2) * math.pi / 5) - math.pi / 2),
        center.dy + radius * 0.4 * math.sin(((i * 4 + 2) * math.pi / 5) - math.pi / 2),
      );
      if (i == 0) path.moveTo(outer.dx, outer.dy);
      else path.lineTo(outer.dx, outer.dy);
      path.lineTo(inner.dx, inner.dy);
    }
    path.close();
    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(MascotPainter old) =>
      old.emotion != emotion || old.isDark != isDark;
}
