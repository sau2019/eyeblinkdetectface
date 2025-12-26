import 'dart:math';

import 'package:eyeblinkdetectface/index.dart';

class M7FaceDetectorPainter extends CustomPainter {
  M7FaceDetectorPainter(
    this.face,
    this.absoluteImageSize,
    this.rotation,
  );

  final Face face;
  final Size absoluteImageSize;
  final InputImageRotation rotation;

  @override
  void paint(Canvas canvas, Size size) {
    final Paint paint = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1.0
      ..color = Eyeblinkdetectface.instance.contourDetectionColor ??
          const Color(0xffab48e0);

    void paintContour(FaceContourType type) {
      final faceContour = face.contours[type];
      if (faceContour?.points != null) {
        for (var i = 0; i < faceContour!.points.length; i++) {
          final Point<int> p1 = faceContour.points[i];
          if (i + 1 < faceContour.points.length) {
            final Point<int> p2 = faceContour.points[i + 1];
            canvas.drawLine(
              Offset(
                M7MathHelper.instance.translateX(
                  p1.x.toDouble(),
                  rotation,
                  size,
                  absoluteImageSize,
                ),
                M7MathHelper.instance.translateY(
                  p1.y.toDouble(),
                  rotation,
                  size,
                  absoluteImageSize,
                ),
              ),
              Offset(
                M7MathHelper.instance.translateX(
                  p2.x.toDouble(),
                  rotation,
                  size,
                  absoluteImageSize,
                ),
                M7MathHelper.instance.translateY(
                  p2.y.toDouble(),
                  rotation,
                  size,
                  absoluteImageSize,
                ),
              ),
              paint,
            );
          }
        }
        for (final Point point in faceContour.points) {
          canvas.drawCircle(
            Offset(
              M7MathHelper.instance.translateX(
                point.x.toDouble(),
                rotation,
                size,
                absoluteImageSize,
              ),
              M7MathHelper.instance.translateY(
                point.y.toDouble(),
                rotation,
                size,
                absoluteImageSize,
              ),
            ),
            1,
            paint,
          );
        }
      }
    }

    paintContour(FaceContourType.face);
    paintContour(FaceContourType.leftEyebrowTop);
    paintContour(FaceContourType.leftEyebrowBottom);
    paintContour(FaceContourType.rightEyebrowTop);
    paintContour(FaceContourType.rightEyebrowBottom);
    paintContour(FaceContourType.leftEye);
    paintContour(FaceContourType.rightEye);
    paintContour(FaceContourType.upperLipTop);
    paintContour(FaceContourType.upperLipBottom);
    paintContour(FaceContourType.lowerLipTop);
    paintContour(FaceContourType.lowerLipBottom);
    paintContour(FaceContourType.noseBridge);
    paintContour(FaceContourType.noseBottom);
    paintContour(FaceContourType.leftCheek);
    paintContour(FaceContourType.rightCheek);
  }

  @override
  bool shouldRepaint(M7FaceDetectorPainter oldDelegate) {
    return oldDelegate.absoluteImageSize != absoluteImageSize ||
        oldDelegate.face != face;
  }
}
