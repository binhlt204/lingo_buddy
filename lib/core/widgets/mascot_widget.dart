import 'dart:math' as math;
import 'package:flutter/material.dart';
import '../theme/app_theme.dart';

enum MascotMood { happy, learning, proud, sleeping }

class MascotWidget extends StatefulWidget {
  final double size;
  final MascotMood mood;
  final String? speechBubbleText;

  const MascotWidget({
    super.key,
    this.size = 100,
    this.mood = MascotMood.happy,
    this.speechBubbleText,
  });

  @override
  State<MascotWidget> createState() => _MascotWidgetState();
}

class _MascotWidgetState extends State<MascotWidget>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _bounceAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 2400),
    )..repeat(reverse: true);

    _bounceAnimation = Tween<double>(begin: 0.0, end: -6.0).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeInOut),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _bounceAnimation,
      builder: (context, child) {
        return Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            if (widget.speechBubbleText != null) ...[
              Container(
                margin: const EdgeInsets.only(bottom: 8),
                padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(16),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.04),
                      blurRadius: 10,
                      offset: const Offset(0, 4),
                    ),
                  ],
                  border: Border.all(color: AppColors.border, width: 1.2),
                ),
                child: Text(
                  widget.speechBubbleText!,
                  style: const TextStyle(
                    fontSize: 13,
                    fontWeight: FontWeight.w700,
                    color: AppColors.textMain,
                  ),
                ),
              ),
            ],
            Transform.translate(
              offset: Offset(0, _bounceAnimation.value),
              child: SizedBox(
                width: widget.size,
                height: widget.size,
                child: CustomPaint(
                  painter: _MochiCatPainter(mood: widget.mood),
                ),
              ),
            ),
          ],
        );
      },
    );
  }
}

class _MochiCatPainter extends CustomPainter {
  final MascotMood mood;

  _MochiCatPainter({required this.mood});

  @override
  void paint(Canvas canvas, Size size) {
    final center = Offset(size.width / 2, size.height * 0.55);
    final radius = size.width * 0.40;

    // Shadow
    final shadowPaint = Paint()
      ..color = Colors.black.withOpacity(0.05)
      ..maskFilter = const MaskFilter.blur(BlurStyle.normal, 6);
    canvas.drawOval(
      Rect.fromCenter(
        center: Offset(center.dx, size.height * 0.95),
        width: size.width * 0.65,
        height: size.height * 0.12,
      ),
      shadowPaint,
    );

    // Body Paint (Cream white cat)
    final bodyPaint = Paint()
      ..color = const Color(0xFFFFFDF9)
      ..style = PaintingStyle.fill;

    final outlinePaint = Paint()
      ..color = const Color(0xFF423B33)
      ..style = PaintingStyle.stroke
      ..strokeWidth = size.width * 0.024
      ..strokeCap = StrokeCap.round
      ..strokeJoin = StrokeJoin.round;

    final earInnerPaint = Paint()
      ..color = const Color(0xFFFFD4C4)
      ..style = PaintingStyle.fill;

    // Ears
    final leftEarPath = Path()
      ..moveTo(center.dx - radius * 0.72, center.dy - radius * 0.5)
      ..lineTo(center.dx - radius * 0.85, center.dy - radius * 1.15)
      ..lineTo(center.dx - radius * 0.22, center.dy - radius * 0.82)
      ..close();

    final rightEarPath = Path()
      ..moveTo(center.dx + radius * 0.72, center.dy - radius * 0.5)
      ..lineTo(center.dx + radius * 0.85, center.dy - radius * 1.15)
      ..lineTo(center.dx + radius * 0.22, center.dy - radius * 0.82)
      ..close();

    canvas.drawPath(leftEarPath, bodyPaint);
    canvas.drawPath(leftEarPath, outlinePaint);
    canvas.drawPath(rightEarPath, bodyPaint);
    canvas.drawPath(rightEarPath, outlinePaint);

    // Inner Ears
    final leftInnerEar = Path()
      ..moveTo(center.dx - radius * 0.65, center.dy - radius * 0.55)
      ..lineTo(center.dx - radius * 0.78, center.dy - radius * 1.0)
      ..lineTo(center.dx - radius * 0.32, center.dy - radius * 0.80)
      ..close();
    final rightInnerEar = Path()
      ..moveTo(center.dx + radius * 0.65, center.dy - radius * 0.55)
      ..lineTo(center.dx + radius * 0.78, center.dy - radius * 1.0)
      ..lineTo(center.dx + radius * 0.32, center.dy - radius * 0.80)
      ..close();
    canvas.drawPath(leftInnerEar, earInnerPaint);
    canvas.drawPath(rightInnerEar, earInnerPaint);

    // Head / Round Body
    canvas.drawCircle(center, radius, bodyPaint);
    canvas.drawCircle(center, radius, outlinePaint);

    // Blush Cheeks (Cute pink ovals)
    final blushPaint = Paint()
      ..color = const Color(0xFFFFB7A2).withOpacity(0.45)
      ..style = PaintingStyle.fill;
    canvas.drawOval(
      Rect.fromCenter(
        center: Offset(center.dx - radius * 0.55, center.dy + radius * 0.15),
        width: radius * 0.32,
        height: radius * 0.20,
      ),
      blushPaint,
    );
    canvas.drawOval(
      Rect.fromCenter(
        center: Offset(center.dx + radius * 0.55, center.dy + radius * 0.15),
        width: radius * 0.32,
        height: radius * 0.20,
      ),
      blushPaint,
    );

    // Round Glasses (Mochi wears cute nerd glasses)
    final glassesPaint = Paint()
      ..color = const Color(0xFF6B584C)
      ..style = PaintingStyle.stroke
      ..strokeWidth = size.width * 0.022;

    final leftGlassCenter = Offset(center.dx - radius * 0.35, center.dy);
    final rightGlassCenter = Offset(center.dx + radius * 0.35, center.dy);
    final glassRadius = radius * 0.30;

    canvas.drawCircle(leftGlassCenter, glassRadius, glassesPaint);
    canvas.drawCircle(rightGlassCenter, glassRadius, glassesPaint);
    // Bridge between glasses
    canvas.drawLine(
      Offset(leftGlassCenter.dx + glassRadius, leftGlassCenter.dy),
      Offset(rightGlassCenter.dx - glassRadius, rightGlassCenter.dy),
      glassesPaint,
    );

    // Eyes inside glasses
    final eyePaint = Paint()
      ..color = const Color(0xFF2B2620)
      ..style = PaintingStyle.fill;

    if (mood == MascotMood.happy || mood == MascotMood.proud) {
      // Curved happy eyes ^ ^
      final happyEyePaint = Paint()
        ..color = const Color(0xFF2B2620)
        ..style = PaintingStyle.stroke
        ..strokeWidth = size.width * 0.024
        ..strokeCap = StrokeCap.round;

      canvas.drawArc(
        Rect.fromCenter(center: leftGlassCenter, width: glassRadius * 1.1, height: glassRadius * 0.9),
        math.pi * 1.1,
        math.pi * 0.8,
        false,
        happyEyePaint,
      );
      canvas.drawArc(
        Rect.fromCenter(center: rightGlassCenter, width: glassRadius * 1.1, height: glassRadius * 0.9),
        math.pi * 1.1,
        math.pi * 0.8,
        false,
        happyEyePaint,
      );
    } else {
      // Normal cute dot eyes with sparkle
      canvas.drawCircle(leftGlassCenter, glassRadius * 0.35, eyePaint);
      canvas.drawCircle(rightGlassCenter, glassRadius * 0.35, eyePaint);

      // Eye glint
      final glintPaint = Paint()..color = Colors.white;
      canvas.drawCircle(
        Offset(leftGlassCenter.dx - 2, leftGlassCenter.dy - 2),
        glassRadius * 0.12,
        glintPaint,
      );
      canvas.drawCircle(
        Offset(rightGlassCenter.dx - 2, rightGlassCenter.dy - 2),
        glassRadius * 0.12,
        glintPaint,
      );
    }

    // Cat Nose & Mouth (3 shape)
    final noseCenter = Offset(center.dx, center.dy + radius * 0.22);
    final mouthPaint = Paint()
      ..color = const Color(0xFF423B33)
      ..style = PaintingStyle.stroke
      ..strokeWidth = size.width * 0.020
      ..strokeCap = StrokeCap.round;

    final mouthPath = Path()
      ..moveTo(noseCenter.dx - radius * 0.14, noseCenter.dy + radius * 0.08)
      ..quadraticBezierTo(
        noseCenter.dx - radius * 0.07,
        noseCenter.dy + radius * 0.18,
        noseCenter.dx,
        noseCenter.dy + radius * 0.08,
      )
      ..quadraticBezierTo(
        noseCenter.dx + radius * 0.07,
        noseCenter.dy + radius * 0.18,
        noseCenter.dx + radius * 0.14,
        noseCenter.dy + radius * 0.08,
      );
    canvas.drawPath(mouthPath, mouthPaint);

    // Tiny Triangle Nose
    final nosePaint = Paint()
      ..color = const Color(0xFFFF9E94)
      ..style = PaintingStyle.fill;
    final nosePath = Path()
      ..moveTo(noseCenter.dx - 3, noseCenter.dy)
      ..lineTo(noseCenter.dx + 3, noseCenter.dy)
      ..lineTo(noseCenter.dx, noseCenter.dy + 3)
      ..close();
    canvas.drawPath(nosePath, nosePaint);
  }

  @override
  bool shouldRepaint(covariant _MochiCatPainter oldDelegate) =>
      oldDelegate.mood != mood;
}
