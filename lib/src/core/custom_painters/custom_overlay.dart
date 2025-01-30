import 'package:eyeblinkdetectface/index.dart';

class OvalOverlayPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    // White overlay paint
    final overlayPaint = Paint()
      ..color = Colors.white // White overlay with opacity
      ..style = PaintingStyle.fill;

    // Blue border paint
    final borderPaint = Paint()
      ..color = Colors.green.shade400 // Blue border color
      ..strokeWidth = 5.0 // Border thickness
      ..style = PaintingStyle.stroke; // Stroke for border

    // Create the full screen white overlay
    final path = Path()..addRect(Rect.fromLTWH(0, 0, size.width, size.height));

    // Define the oval shape
    final ovalRect = Rect.fromCenter(
      center: Offset(size.width / 2, size.height / 2),
      width: size.width * 0.7, // Adjust size of the oval
      height: size.height * 0.5,
    );

    final ovalPath = Path()..addOval(ovalRect);

    // Subtract the oval from the overlay
    path.addPath(ovalPath, Offset.zero);
    path.fillType = PathFillType.evenOdd;

    // Draw the overlay
    canvas.drawPath(path, overlayPaint);

    // Draw the blue border
    canvas.drawOval(ovalRect, borderPaint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => false;
}
