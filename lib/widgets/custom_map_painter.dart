import 'package:flutter/material.dart';

class MapPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    canvas.drawRect(
      Offset.zero & size,
      Paint()..color = const Color(0xFFFFFCF5),
    );

    final road = Paint()
      ..color = Colors.white
      ..strokeWidth = 13
      ..style = PaintingStyle.stroke;
    final fineRoad = Paint()
      ..color = const Color(0xFFF4E7D0)
      ..strokeWidth = 1.2
      ..style = PaintingStyle.stroke;

    for (
      var offset = -size.height;
      offset < size.width + size.height;
      offset += 42
    ) {
      canvas.drawLine(
        Offset(offset, 0),
        Offset(offset + size.height, size.height),
        road,
      );
      canvas.drawLine(
        Offset(offset, 0),
        Offset(offset + size.height, size.height),
        fineRoad,
      );
    }
    for (var y = 18.0; y < size.height; y += 35) {
      canvas.drawLine(Offset(0, y), Offset(size.width, y - 20), fineRoad);
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
