import 'package:eyeblinkdetectface/index.dart';
import 'dart:math' as math;
import 'package:flutter/material.dart';

class OvalOverlayPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    // White overlay paint
    final overlayPaint = Paint()
      ..color = Colors.white // Optional: Add opacity to see through
      ..style = PaintingStyle.fill;

    // Blue border paint
    final borderPaint = Paint()
      ..color = Colors.red.shade400
      ..strokeWidth = 5.0
      ..style = PaintingStyle.stroke;

    // Create the full-screen white overlay
    final path = Path()..addRect(Rect.fromLTWH(0, 0, size.width, size.height));

    // Define the circular face area
    final double diameter = math.min(size.width, size.height) * 0.8;
    final Rect circleRect = Rect.fromCenter(
      center: Offset(size.width / 2, size.height / 2),
      width: diameter,
      height: diameter,
    );

    final Path circlePath = Path()..addOval(circleRect);

    // Cut out the circle from the overlay
    path.addPath(circlePath, Offset.zero);
    path.fillType = PathFillType.evenOdd;

    // Draw the overlay
    canvas.drawPath(path, overlayPaint);

    // Draw the blue circular border
    canvas.drawOval(circleRect, borderPaint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => false;
}
