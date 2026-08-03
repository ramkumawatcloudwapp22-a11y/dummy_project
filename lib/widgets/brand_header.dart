import 'dart:math' as math;
import 'package:flutter/material.dart';
import '../core/l10n/l10n_ext.dart';
import '../core/theme/app_colors.dart';

/// Gold shield emblem used across Splash / Login / Signup
class TechYodhaEmblem extends StatelessWidget {
  final double size;

  const TechYodhaEmblem({super.key, this.size = 120});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: size,
      height: size,
      child: CustomPaint(painter: _EmblemPainter()),
    );
  }
}

class _EmblemPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final w = size.width;
    final h = size.height;

    final goldStroke = Paint()
      ..color = AppColors.goldBright
      ..style = PaintingStyle.stroke
      ..strokeWidth = w * 0.035;

    final goldFill = Paint()
      ..color = AppColors.gold.withValues(alpha: 0.22)
      ..style = PaintingStyle.fill;

    final goldSolid = Paint()
      ..color = AppColors.goldBright
      ..style = PaintingStyle.fill;

    final shield = Path()
      ..moveTo(w * 0.5, h * 0.05)
      ..lineTo(w * 0.88, h * 0.18)
      ..lineTo(w * 0.88, h * 0.52)
      ..quadraticBezierTo(w * 0.88, h * 0.78, w * 0.5, h * 0.95)
      ..quadraticBezierTo(w * 0.12, h * 0.78, w * 0.12, h * 0.52)
      ..lineTo(w * 0.12, h * 0.18)
      ..close();

    canvas.drawPath(shield, goldFill);
    canvas.drawPath(shield, goldStroke);

    final innerStroke = Paint()
      ..color = AppColors.goldBright
      ..style = PaintingStyle.stroke
      ..strokeWidth = w * 0.018;

    final inner = Path()
      ..moveTo(w * 0.5, h * 0.12)
      ..lineTo(w * 0.78, h * 0.22)
      ..lineTo(w * 0.78, h * 0.50)
      ..quadraticBezierTo(w * 0.78, h * 0.70, w * 0.5, h * 0.85)
      ..quadraticBezierTo(w * 0.22, h * 0.70, w * 0.22, h * 0.50)
      ..lineTo(w * 0.22, h * 0.22)
      ..close();
    canvas.drawPath(inner, innerStroke);

    _drawStar(canvas, Offset(w * 0.5, h * 0.20), w * 0.05, goldSolid);

    final sword = Paint()
      ..color = AppColors.goldBright
      ..style = PaintingStyle.stroke
      ..strokeWidth = w * 0.028
      ..strokeCap = StrokeCap.round;
    canvas.drawLine(Offset(w * 0.32, h * 0.32), Offset(w * 0.68, h * 0.62), sword);
    canvas.drawLine(Offset(w * 0.68, h * 0.32), Offset(w * 0.32, h * 0.62), sword);

    _drawStar(canvas, Offset(w * 0.35, h * 0.72), w * 0.032, goldSolid);
    _drawStar(canvas, Offset(w * 0.50, h * 0.76), w * 0.032, goldSolid);
    _drawStar(canvas, Offset(w * 0.65, h * 0.72), w * 0.032, goldSolid);
  }

  void _drawStar(Canvas canvas, Offset center, double radius, Paint paint) {
    final path = Path();
    for (var i = 0; i < 5; i++) {
      final angle = -math.pi / 2 + i * 2 * math.pi / 5;
      final x = center.dx + radius * math.cos(angle);
      final y = center.dy + radius * math.sin(angle);
      if (i == 0) {
        path.moveTo(x, y);
      } else {
        path.lineTo(x, y);
      }
      final innerAngle = angle + math.pi / 5;
      final ix = center.dx + radius * 0.4 * math.cos(innerAngle);
      final iy = center.dy + radius * 0.4 * math.sin(innerAngle);
      path.lineTo(ix, iy);
    }
    path.close();
    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

/// Brand title block: TECH YODHA + star divider + subtitle
class BrandHeader extends StatelessWidget {
  final double emblemSize;
  final bool compact;

  const BrandHeader({
    super.key,
    this.emblemSize = 110,
    this.compact = false,
  });

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;

    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        TechYodhaEmblem(size: emblemSize),
        SizedBox(height: compact ? 8 : 14),
        Text(
          l10n.appNameUpper,
          style: TextStyle(
            color: AppColors.textWhite,
            fontSize: compact ? 26 : 32,
            fontWeight: FontWeight.w800,
            letterSpacing: 3,
          ),
        ),
        const SizedBox(height: 8),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(width: 40, height: 1, color: AppColors.gold),
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 8),
              child: Icon(Icons.star, color: AppColors.gold, size: 12),
            ),
            Container(width: 40, height: 1, color: AppColors.gold),
          ],
        ),
        const SizedBox(height: 8),
        Text(
          l10n.brandTagline,
          style: TextStyle(
            color: AppColors.textWhite.withValues(alpha: 0.85),
            fontSize: compact ? 11 : 13,
            fontWeight: FontWeight.w400,
          ),
        ),
      ],
    );
  }
}
