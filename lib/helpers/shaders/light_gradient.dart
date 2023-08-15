import 'package:flutter/material.dart';

class LightGradient extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    Paint paint = Paint();
    paint.shader = const LinearGradient(
      colors: [
        Color.fromARGB(255, 79, 194, 248),
        Color.fromARGB(255, 41, 208, 246),
        Color.fromARGB(223, 130, 196, 250),
      ],
    ).createShader(Rect.fromLTRB(0, 0, size.width, size.height));
    canvas.drawPaint(paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return oldDelegate != this;
  }
}
