import 'dart:math';
import 'package:barber_shops/screens/authentication/sign_in_form.dart';
import 'package:barber_shops/utils/social_icons.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'sign_up_form.dart';

class AuthDashboard extends StatelessWidget {
  const AuthDashboard({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24),
          child: Column(
            children: [
              // ── Back arrow ──
              Align(
                alignment: Alignment.centerLeft,
                child: IconButton(
                  icon: const Icon(Icons.arrow_back_ios, size: 22),
                  onPressed: () => Navigator.pop(context),
                ),
              ),

              // ── Central illustration ──
              Expanded(flex: 3, child: Center(child: _AuthIllustration())),

              // ── "Let's you in" headline ──
              Text(
                "Let's you in",
                style: GoogleFonts.poppins(
                  fontSize: 30,
                  fontWeight: FontWeight.w700,
                  color: const Color(0xFF1A1A2E),
                ),
              ),
              const SizedBox(height: 28),

              // ── Social buttons ──
              _SocialButton(
                icon: FacebookIcon(),
                label: 'Continue with Facebook',
                backgroundColor: const Color(0xFF1877F2),
                textColor: Colors.white,
                onTap: () {},
              ),
              const SizedBox(height: 14),
              _SocialButton(
                icon: GoogleIcon(),
                label: 'Continue with Google',
                backgroundColor: Colors.white,
                textColor: Colors.black87,
                borderColor: const Color(0xFFE0E0E0),
                onTap: () {},
              ),
              const SizedBox(height: 14),
              _SocialButton(
                icon: AppleIcon(iconColor: Colors.white),
                label: 'Continue with Apple',
                backgroundColor: const Color(0xFF1A1A2E),
                textColor: Colors.white,
                onTap: () {},
              ),
              const SizedBox(height: 28),

              // ── "or" divider ──
              Row(
                children: [
                  const Expanded(
                    child: Divider(color: Color(0xFFE8E8E8), thickness: 1),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 18),
                    child: Text(
                      'or',
                      style: GoogleFonts.poppins(
                        fontSize: 14,
                        color: Colors.grey,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                  const Expanded(
                    child: Divider(color: Color(0xFFE8E8E8), thickness: 1),
                  ),
                ],
              ),
              const SizedBox(height: 28),

              // ── Sign in with password ──
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () {
                    // Navigate to sign in form
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (_) => const SignInForm()),
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFFFF9800),
                    foregroundColor: Colors.white,
                    elevation: 0,
                    padding: const EdgeInsets.symmetric(vertical: 17),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(14),
                    ),
                  ),
                  child: Text(
                    'Sign in with password',
                    style: GoogleFonts.poppins(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 28),

              // ── Footer ──
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "Don't have an account? ",
                    style: GoogleFonts.poppins(
                      fontSize: 14,
                      color: Colors.grey,
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (_) => const SignUpForm()),
                      );
                    },
                    child: Text(
                      'Sign up',
                      style: GoogleFonts.poppins(
                        fontSize: 14,
                        color: const Color(0xFFFF9800),
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }
}

// ──────────────────────────────────────────────
//  Custom illustration: person sitting by window & tree
// ──────────────────────────────────────────────

class _AuthIllustration extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      size: const Size(280, 240),
      painter: _IllustrationPainter(),
    );
  }
}

class _IllustrationPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()..style = PaintingStyle.fill;
    final stroke = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = 3
      ..strokeCap = StrokeCap.round;

    final w = size.width;
    final h = size.height;

    // ── Window frame ──
    final windowPaint = Paint()
      ..color = const Color(0xFF1A1A2E)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 4;
    final windowRect = RRect.fromRectAndRadius(
      Rect.fromLTWH(w * 0.18, h * 0.05, w * 0.64, h * 0.72),
      const Radius.circular(16),
    );
    canvas.drawRRect(windowRect, windowPaint);

    // Window cross bars
    canvas.drawLine(
      Offset(w * 0.5, h * 0.05),
      Offset(w * 0.5, h * 0.77),
      windowPaint,
    );
    canvas.drawLine(
      Offset(w * 0.18, h * 0.35),
      Offset(w * 0.82, h * 0.35),
      windowPaint,
    );

    // ── Sun (top-left pane) ──
    paint.color = const Color(0xFFFF9800);
    canvas.drawCircle(Offset(w * 0.32, h * 0.18), 14, paint);

    // Sun rays
    stroke.color = const Color(0xFFFF9800);
    for (var angle = 0.0; angle < 360; angle += 45) {
      final rad = angle * 3.14159 / 180;
      final dx = w * 0.32 + 20 * cos(rad);
      final dy = h * 0.18 + 20 * sin(rad);
      canvas.drawLine(
        Offset(w * 0.32 + 10 * cos(rad), h * 0.18 + 10 * sin(rad)),
        Offset(dx, dy),
        stroke..strokeWidth = 2.5,
      );
    }

    // ── Cloud (top-right pane) ──
    paint.color = const Color(0xFFB0BEC5);
    canvas.drawCircle(Offset(w * 0.63, h * 0.20), 10, paint);
    canvas.drawCircle(Offset(w * 0.70, h * 0.17), 13, paint);
    canvas.drawCircle(Offset(w * 0.76, h * 0.21), 9, paint);

    // ── Potted plant (bottom-left pane) ──
    // Pot
    final potPaint = Paint()..color = const Color(0xFFFF9800);
    final potPath = Path()
      ..moveTo(w * 0.25, h * 0.68)
      ..lineTo(w * 0.28, h * 0.80)
      ..lineTo(w * 0.38, h * 0.80)
      ..lineTo(w * 0.41, h * 0.68)
      ..close();
    canvas.drawPath(potPath, potPaint);

    // Pot rim
    paint.color = const Color(0xFFE65100);
    canvas.drawRRect(
      RRect.fromRectAndRadius(
        Rect.fromLTWH(w * 0.24, h * 0.66, w * 0.18, h * 0.04),
        const Radius.circular(3),
      ),
      paint,
    );

    // Leaves
    paint.color = const Color(0xFF4CAF50);
    canvas.drawOval(
      Rect.fromLTWH(w * 0.27, h * 0.52, w * 0.06, h * 0.16),
      paint,
    );
    canvas.drawOval(
      Rect.fromLTWH(w * 0.33, h * 0.48, w * 0.06, h * 0.18),
      paint,
    );
    canvas.drawOval(
      Rect.fromLTWH(w * 0.28, h * 0.44, w * 0.05, h * 0.12),
      paint,
    );
    paint.color = const Color(0xFF66BB6A);
    canvas.drawOval(
      Rect.fromLTWH(w * 0.35, h * 0.50, w * 0.05, h * 0.10),
      paint,
    );

    // ── Person sitting (bottom-right pane) ──
    final personColor = const Color(0xFF1A1A2E);
    paint.color = personColor;

    // Head
    canvas.drawCircle(Offset(w * 0.65, h * 0.50), 11, paint);

    // Body (sitting posture)
    final bodyPath = Path()
      ..moveTo(w * 0.62, h * 0.58)
      ..lineTo(w * 0.60, h * 0.72)
      ..lineTo(w * 0.64, h * 0.72)
      ..lineTo(w * 0.66, h * 0.62)
      ..close();
    canvas.drawPath(bodyPath, paint);

    // Arms
    stroke.color = personColor;
    stroke.strokeWidth = 5;
    // Left arm down
    canvas.drawLine(
      Offset(w * 0.63, h * 0.62),
      Offset(w * 0.57, h * 0.68),
      stroke,
    );
    // Right arm
    canvas.drawLine(
      Offset(w * 0.68, h * 0.62),
      Offset(w * 0.73, h * 0.66),
      stroke,
    );

    // Legs (crossed)
    canvas.drawLine(
      Offset(w * 0.63, h * 0.72),
      Offset(w * 0.58, h * 0.80),
      stroke,
    );
    canvas.drawLine(
      Offset(w * 0.65, h * 0.72),
      Offset(w * 0.70, h * 0.80),
      stroke,
    );

    // ── Floor line ──
    stroke.color = const Color(0xFFE0E0E0);
    stroke.strokeWidth = 2;
    canvas.drawLine(
      Offset(w * 0.10, h * 0.84),
      Offset(w * 0.90, h * 0.84),
      stroke,
    );

    // Small plant on floor
    paint.color = const Color(0xFFA5D6A7);
    canvas.drawOval(
      Rect.fromLTWH(w * 0.12, h * 0.78, w * 0.04, h * 0.06),
      paint,
    );
    paint.color = const Color(0xFF8D6E63);
    canvas.drawRRect(
      RRect.fromRectAndRadius(
        Rect.fromLTWH(w * 0.11, h * 0.83, w * 0.06, h * 0.03),
        const Radius.circular(2),
      ),
      paint,
    );
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

// ──────────────────────────────────────────────
//  Reusable social button
// ──────────────────────────────────────────────

class _SocialButton extends StatelessWidget {
  final Widget icon;
  final String label;
  final Color backgroundColor;
  final Color textColor;
  final Color? borderColor;
  final VoidCallback onTap;

  const _SocialButton({
    required this.icon,
    required this.label,
    required this.backgroundColor,
    required this.textColor,
    this.borderColor,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: Material(
        color: backgroundColor,
        borderRadius: BorderRadius.circular(14),
        child: InkWell(
          onTap: onTap,
          borderRadius: BorderRadius.circular(14),
          child: Container(
            padding: const EdgeInsets.symmetric(vertical: 14),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(14),
              border: borderColor != null
                  ? Border.all(color: borderColor!, width: 1.2)
                  : null,
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                icon,
                const SizedBox(width: 12),
                Text(
                  label,
                  style: GoogleFonts.poppins(
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                    color: textColor,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
