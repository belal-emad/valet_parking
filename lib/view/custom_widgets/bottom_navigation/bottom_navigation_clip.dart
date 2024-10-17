import 'package:flutter/material.dart';

class BottomNavigationClip extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    Paint paint = Paint();
    Path path = Path();

    // Path number 1

    paint.color = const Color(0xff0A59A1);
    path = Path();
    path.lineTo(0, size.height * 0.16);
    path.cubicTo(
        0, size.height * 0.09, 0, size.height * 0.05, 0, size.height * 0.03);
    path.cubicTo(size.width * 0.01, size.height * 0.03, size.width * 0.01,
        size.height * 0.02, size.width * 0.01, size.height * 0.02);
    path.cubicTo(size.width * 0.02, 0, size.width * 0.03, 0, size.width * 0.04,
        size.height * 0.01);
    path.cubicTo(size.width * 0.04, size.height * 0.01, size.width * 0.49,
        size.height * 0.26, size.width * 0.49, size.height * 0.26);
    path.cubicTo(size.width / 2, size.height * 0.26, size.width / 2,
        size.height * 0.26, size.width / 2, size.height * 0.26);
    path.cubicTo(size.width / 2, size.height * 0.26, size.width / 2,
        size.height * 0.26, size.width / 2, size.height * 0.26);
    path.cubicTo(size.width / 2, size.height * 0.26, size.width / 2,
        size.height * 0.26, size.width * 0.51, size.height * 0.26);
    path.cubicTo(size.width * 0.51, size.height * 0.26, size.width * 0.96,
        size.height * 0.01, size.width * 0.96, size.height * 0.01);
    path.cubicTo(size.width * 0.97, 0, size.width * 0.98, 0, size.width,
        size.height * 0.02);
    path.cubicTo(size.width, size.height * 0.02, size.width, size.height * 0.03,
        size.width, size.height * 0.03);
    path.cubicTo(size.width, size.height * 0.05, size.width, size.height * 0.09,
        size.width, size.height * 0.16);
    path.cubicTo(size.width, size.height * 0.16, size.width, size.height,
        size.width, size.height);
    path.cubicTo(size.width, size.height, 0, size.height, 0, size.height);
    path.cubicTo(0, size.height, 0, size.height * 0.16, 0, size.height * 0.16);
    path.cubicTo(
        0, size.height * 0.16, 0, size.height * 0.16, 0, size.height * 0.16);
    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return true;
  }
}
