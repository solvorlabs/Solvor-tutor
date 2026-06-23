import 'dart:math' as math;
import 'package:flutter/material.dart';

// ── Palette ────────────────────────────────────────────────────────────────
const kPaper = Color(0xFFFAFAFA);
const kInk = Color(0xFF0A0A0A);
const kMuted = Color(0xFF5E5E5E);
const kBorder = Color(0xFFE2E2E2);

const kVoid = Color(0xFF050505);
const kSurface = Color(0xFF111111);
const kSubtle = Color(0xFF1C1C1C);
const kMutedDark = Color(0xFF7A7A7A);

// Neon triad — replaces black stripes in dark mode
const kNeonYellow = Color(0xFFF5E642);
const kNeonPurple = Color(0xFFC026D3);
const kNeonTeal = Color(0xFF0D9488);

const kNeonGradient = LinearGradient(
  colors: [kNeonYellow, kNeonPurple, kNeonTeal],
  begin: Alignment.centerLeft,
  end: Alignment.centerRight,
);

// ── Stripe painter ──────────────────────────────────────────────────────────
class StripePainter extends CustomPainter {
  final bool isDark;
  final double spacing;
  final double strokeWidth;

  const StripePainter({
    required this.isDark,
    this.spacing = 11,
    this.strokeWidth = 2.2,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final rect = Rect.fromLTWH(0, 0, size.width, size.height);

    final Paint paint = Paint()
      ..strokeWidth = strokeWidth
      ..style = PaintingStyle.stroke;

    if (isDark) {
      paint.shader = kNeonGradient.createShader(rect);
    } else {
      paint.color = kInk;
    }

    // Diagonal lines at 45°
    final double extent = size.width + size.height;
    for (double i = -size.height; i < extent; i += spacing) {
      canvas.drawLine(Offset(i, 0), Offset(i + size.height, size.height), paint);
    }
  }

  @override
  bool shouldRepaint(StripePainter old) =>
      old.isDark != isDark ||
      old.spacing != spacing ||
      old.strokeWidth != strokeWidth;
}

// ── Reusable stripe widget ──────────────────────────────────────────────────
class StripeBlock extends StatelessWidget {
  final double height;
  final double? width;
  final double spacing;
  final double strokeWidth;
  final BorderRadius borderRadius;

  const StripeBlock({
    super.key,
    this.height = 120,
    this.width,
    this.spacing = 11,
    this.strokeWidth = 2.2,
    this.borderRadius = BorderRadius.zero,
  });

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return ClipRRect(
      borderRadius: borderRadius,
      child: CustomPaint(
        painter: StripePainter(
          isDark: isDark,
          spacing: spacing,
          strokeWidth: strokeWidth,
        ),
        child: SizedBox(
          height: height,
          width: width ?? double.infinity,
        ),
      ),
    );
  }
}

// ── Neon gradient text (dark only, falls back to ink in light) ──────────────
// 2-stop yellow→teal avoids the per-letter rainbow effect of 3 stops on short words
class NeonText extends StatelessWidget {
  final String text;
  final TextStyle? style;

  const NeonText(this.text, {super.key, this.style});

  static const _twoStop = LinearGradient(
    colors: [kNeonYellow, kNeonTeal],
    begin: Alignment.centerLeft,
    end: Alignment.centerRight,
  );

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    if (!isDark) {
      return Text(text, style: style?.copyWith(color: kInk) ?? const TextStyle(color: kInk));
    }
    return ShaderMask(
      blendMode: BlendMode.srcIn,
      shaderCallback: (bounds) => _twoStop.createShader(bounds),
      child: Text(text, style: style ?? const TextStyle(color: Colors.white)),
    );
  }
}

// ── Neon gradient divider (dark) / black divider (light) ────────────────────
class GradientDivider extends StatelessWidget {
  final double height;

  const GradientDivider({super.key, this.height = 2});

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    if (!isDark) {
      return Container(height: height, color: kInk);
    }
    return Container(
      height: height,
      decoration: const BoxDecoration(gradient: kNeonGradient),
    );
  }
}

// ── Isometric grid painter ───────────────────────────────────────────────────
// 3 line families at +30°, -30°, 90° → creates genuine isometric depth.
// Dark: each family gets its own neon color.
// Light: same 3 families in black at varying opacity (heaviest = foreground).
class IsometricPainter extends CustomPainter {
  final bool isDark;
  final double spacing;
  final double strokeWidth;

  const IsometricPainter({
    required this.isDark,
    this.spacing = 26,
    this.strokeWidth = 1.3,
  });

  void _drawFamily(Canvas canvas, Size size, double angleDeg, Paint paint) {
    final angle = angleDeg * math.pi / 180;
    final dx = math.cos(angle);
    final dy = math.sin(angle);
    // perpendicular direction (for stepping between lines)
    final nx = -dy;
    final ny = dx;

    final cx = size.width / 2;
    final cy = size.height / 2;
    final diag = math.sqrt(size.width * size.width + size.height * size.height);
    final n = (diag / spacing).ceil() + 2;
    final halfLen = diag + spacing;

    for (int i = -n; i <= n; i++) {
      final px = cx + nx * i * spacing;
      final py = cy + ny * i * spacing;
      canvas.drawLine(
        Offset(px - dx * halfLen, py - dy * halfLen),
        Offset(px + dx * halfLen, py + dy * halfLen),
        paint,
      );
    }
  }

  @override
  void paint(Canvas canvas, Size size) {
    final base = Paint()
      ..strokeWidth = strokeWidth
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.butt;

    if (isDark) {
      // +30°: yellow — reads as "top cube face" lighting
      _drawFamily(canvas, size, 30, base..color = kNeonYellow.withOpacity(0.65));
      // -30°: purple — "left face"
      _drawFamily(canvas, size, -30, base..color = kNeonPurple.withOpacity(0.55));
      // 90° vertical: teal — "right face"
      _drawFamily(canvas, size, 90, base..color = kNeonTeal.withOpacity(0.50));
    } else {
      // Light: varying opacity creates depth without color
      _drawFamily(canvas, size, 30, base..color = kInk.withOpacity(0.60));
      _drawFamily(canvas, size, -30, base..color = kInk.withOpacity(0.38));
      _drawFamily(canvas, size, 90, base..color = kInk.withOpacity(0.22));
    }
  }

  @override
  bool shouldRepaint(IsometricPainter old) =>
      old.isDark != isDark ||
      old.spacing != spacing ||
      old.strokeWidth != strokeWidth;
}

// ── Reusable isometric pattern strip for inner screen headers ───────────────
class PatternBanner extends StatelessWidget {
  final double height;

  const PatternBanner({super.key, this.height = 52});

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return SizedBox(
      height: height,
      child: Stack(
        children: [
          Positioned.fill(
            child: ClipRect(
              child: CustomPaint(
                painter: IsometricPainter(
                  isDark: isDark,
                  spacing: 20,
                  strokeWidth: 1.0,
                ),
              ),
            ),
          ),
          // fade to background on bottom so it blends into content
          Positioned.fill(
            child: DecoratedBox(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    (isDark ? kVoid : kPaper).withOpacity(0.0),
                    isDark ? kVoid : kPaper,
                  ],
                  stops: const [0.4, 1.0],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
