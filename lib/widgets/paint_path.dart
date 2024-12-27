import 'package:flutter/material.dart';

class PathPainter extends CustomPainter {
  final List<Offset> path;
  final double scale;

  PathPainter({
    required this.path,
    required this.scale,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = Colors.blue
      ..strokeWidth = 3.0
      ..style = PaintingStyle.stroke
      ..isAntiAlias = true;

    if (path.isNotEmpty) {
      final scaledPath = Path();
      scaledPath.moveTo(path.first.dx * scale, path.first.dy * scale);

      for (int i = 1; i < path.length; i++) {
        scaledPath.lineTo(path[i].dx * scale, path[i].dy * scale);
      }

      canvas.drawPath(scaledPath, paint);
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}
