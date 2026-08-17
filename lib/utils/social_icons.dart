import "package:flutter/material.dart";
// ──────────────────────────────────────────────
//  Brand icons
// ──────────────────────────────────────────────

class FacebookIcon extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 26,
      height: 26,
      decoration: const BoxDecoration(
        color: Colors.white,
        shape: BoxShape.circle,
      ),
      child: const Center(
        child: Text(
          'f',
          style: TextStyle(
            fontSize: 17,
            fontWeight: FontWeight.w800,
            color: Color(0xFF1877F2),
          ),
        ),
      ),
    );
  }
}

class GoogleIcon extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 26,
      height: 26,
      child: CustomPaint(painter: _GoogleIconPainter()),
    );
  }
}

class _GoogleIconPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final p = Paint()..style = PaintingStyle.fill;

    // Blue
    p.color = const Color(0xFF4285F4);
    canvas.drawArc(
      Rect.fromLTWH(0, 0, size.width, size.height),
      -0.3,
      2.2,
      true,
      p,
    );

    // Red
    p.color = const Color(0xFFEA4335);
    canvas.drawArc(
      Rect.fromLTWH(1, 1, size.width - 2, size.height - 2),
      2.0,
      0.9,
      true,
      p,
    );

    // Yellow
    p.color = const Color(0xFFFBBC05);
    canvas.drawArc(
      Rect.fromLTWH(2, 3, size.width - 4, size.height - 6),
      3.0,
      0.7,
      true,
      p,
    );

    // Green
    p.color = const Color(0xFF34A853);
    canvas.drawArc(
      Rect.fromLTWH(2, 3, size.width - 4, size.height - 6),
      3.8,
      0.8,
      true,
      p,
    );
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

class AppleIcon extends StatelessWidget {
  final Color iconColor;
  AppleIcon({super.key, required this.iconColor});

  @override
  Widget build(BuildContext context) {
    return Icon(Icons.apple, color: iconColor, size: 26);
  }
}
