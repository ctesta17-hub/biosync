import 'package:flutter/material.dart';

class LungsIcon extends StatelessWidget {
  final double size;
  final Color color;

  const LungsIcon({super.key, required this.size, required this.color});

  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      size: Size(size, size),
      painter: _LungsPainter(color: color),
    );
  }
}

class _LungsPainter extends CustomPainter {
  final Color color;
  const _LungsPainter({required this.color});

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = color
      ..style = PaintingStyle.stroke
      ..strokeWidth = size.width * 0.07
      ..strokeCap = StrokeCap.round
      ..strokeJoin = StrokeJoin.round;

    final w = size.width;
    final h = size.height;
    final path = Path();

    // Trachea
    path.moveTo(w * 0.5, h * 0.05);
    path.lineTo(w * 0.5, h * 0.38);

    // Left bronchus
    path.moveTo(w * 0.5, h * 0.28);
    path.quadraticBezierTo(w * 0.28, h * 0.28, w * 0.22, h * 0.42);
    path.moveTo(w * 0.22, h * 0.42);
    path.cubicTo(
        w * 0.04, h * 0.44, w * 0.04, h * 0.90, w * 0.28, h * 0.92);
    path.cubicTo(
        w * 0.40, h * 0.93, w * 0.44, h * 0.78, w * 0.44, h * 0.60);
    path.lineTo(w * 0.44, h * 0.38);

    // Right bronchus
    path.moveTo(w * 0.5, h * 0.28);
    path.quadraticBezierTo(w * 0.72, h * 0.28, w * 0.78, h * 0.42);
    path.moveTo(w * 0.78, h * 0.42);
    path.cubicTo(
        w * 0.96, h * 0.44, w * 0.96, h * 0.90, w * 0.72, h * 0.92);
    path.cubicTo(
        w * 0.60, h * 0.93, w * 0.56, h * 0.78, w * 0.56, h * 0.60);
    path.lineTo(w * 0.56, h * 0.38);

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(_LungsPainter old) => old.color != color;
}
