import 'package:barber_shops/screens/authentication/sign_in_form.dart';
import 'package:barber_shops/utils/app_text_field.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class CreateNewPassword extends StatefulWidget {
  const CreateNewPassword({super.key});

  @override
  State<CreateNewPassword> createState() => _CreateNewPasswordState();
}

class _CreateNewPasswordState extends State<CreateNewPassword> {
  static const _orange = Color(0xFFFF9800);
  static const _dark = Color(0xFF1A1A2E);

  final _formKey = GlobalKey<FormState>();
  final _pwdCtrl = TextEditingController();
  final _confirmCtrl = TextEditingController();

  bool _obscurePwd = true;
  bool _obscureConfirm = true;
  bool _rememberMe = false;

  @override
  void dispose() {
    _pwdCtrl.dispose();
    _confirmCtrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 8),

              // ── Header: back arrow + title ──
              Row(
                children: [
                  IconButton(
                    icon: const Icon(Icons.arrow_back_ios, size: 22),
                    onPressed: () => Navigator.pop(context),
                  ),
                  Text(
                    "Create New Password",
                    style: GoogleFonts.poppins(
                      fontSize: 22,
                      fontWeight: FontWeight.w700,
                      color: _dark,
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 16),

              // ── Illustration ──
              const Center(child: _PhoneIllustration()),

              const SizedBox(height: 16),

              // ── Heading ──
              Text(
                "Create Your New Password",
                style: GoogleFonts.poppins(
                  fontSize: 24,
                  fontWeight: FontWeight.w700,
                  color: _dark,
                ),
              ),

              const SizedBox(height: 24),

              // ── Password fields ──
              Form(
                key: _formKey,
                child: Column(
                  children: [
                    AppTextField(
                      controller: _pwdCtrl,
                      hint: "New Password",
                      prefixIcon: Icons.lock_outlined,
                      obscureText: _obscurePwd,
                      suffixIcon: IconButton(
                        icon: Icon(
                          _obscurePwd
                              ? Icons.visibility_off_outlined
                              : Icons.visibility_outlined,
                          color: Colors.grey,
                        ),
                        onPressed: () =>
                            setState(() => _obscurePwd = !_obscurePwd),
                      ),
                      validator: (v) => v == null || v.trim().isEmpty
                          ? "Password is required"
                          : null,
                    ),
                    const SizedBox(height: 20),
                    AppTextField(
                      controller: _confirmCtrl,
                      hint: "Confirm Password",
                      prefixIcon: Icons.lock_outlined,
                      obscureText: _obscureConfirm,
                      suffixIcon: IconButton(
                        icon: Icon(
                          _obscureConfirm
                              ? Icons.visibility_off_outlined
                              : Icons.visibility_outlined,
                          color: Colors.grey,
                        ),
                        onPressed: () =>
                            setState(() => _obscureConfirm = !_obscureConfirm),
                      ),
                      validator: (v) {
                        if (v == null || v.trim().isEmpty) {
                          return "Confirm password is required";
                        }
                        if (v != _pwdCtrl.text) {
                          return "Passwords do not match";
                        }
                        return null;
                      },
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 16),

              // ── Remember me ──
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(
                    height: 24,
                    width: 24,
                    child: Checkbox(
                      value: _rememberMe,
                      onChanged: (v) =>
                          setState(() => _rememberMe = v ?? false),
                      side: const BorderSide(color: _orange, width: 2),
                      activeColor: _orange,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(4),
                      ),
                    ),
                  ),
                  const SizedBox(width: 8),
                  Text(
                    "Remember me",
                    style: GoogleFonts.poppins(fontSize: 14, color: _dark),
                  ),
                ],
              ),

              const SizedBox(height: 24),

              // ── Continue button ──
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      _showSuccessDialog();
                    }
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: _orange,
                    foregroundColor: Colors.white,
                    elevation: 0,
                    padding: const EdgeInsets.symmetric(vertical: 17),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(14),
                    ),
                  ),
                  child: Text(
                    "Continue",
                    style: GoogleFonts.poppins(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ),

              const SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }

  void _showSuccessDialog() {
    showDialog<void>(
      context: context,
      barrierDismissible: false,
      barrierColor: Colors.black54,
      builder: (_) => const _SuccessDialog(),
    );

    Future.delayed(const Duration(seconds: 5), () {
      if (!mounted) return;
      Navigator.of(context).pop();
      Navigator.of(context).pushAndRemoveUntil(
        MaterialPageRoute(builder: (_) => const SignInForm()),
        (route) => false,
      );
    });
  }
}

// ──────────────────────────────────────────────
//  Illustration: phone with orange checkmark
// ──────────────────────────────────────────────

class _PhoneIllustration extends StatelessWidget {
  const _PhoneIllustration();

  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      size: const Size(220, 180),
      painter: _PhoneIllustrationPainter(),
    );
  }
}

class _PhoneIllustrationPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final w = size.width;
    final h = size.height;
    final paint = Paint()..style = PaintingStyle.fill;

    // ── Decorative circles ──
    paint.color = const Color(0xFFFFF3E0);
    canvas.drawCircle(Offset(w * 0.12, h * 0.22), 20, paint);
    canvas.drawCircle(Offset(w * 0.88, h * 0.30), 14, paint);
    paint.color = const Color(0xFFFFE0B2);
    canvas.drawCircle(Offset(w * 0.85, h * 0.72), 18, paint);

    // ── Phone body ──
    paint.color = const Color(0xFF1A1A2E);
    final phoneRect = RRect.fromRectAndRadius(
      Rect.fromCenter(
        center: Offset(w * 0.5, h * 0.5),
        width: w * 0.38,
        height: h * 0.82,
      ),
      const Radius.circular(18),
    );
    canvas.drawRRect(phoneRect, paint);

    // ── Screen ──
    paint.color = Colors.white;
    final screenRect = RRect.fromRectAndRadius(
      Rect.fromCenter(
        center: Offset(w * 0.5, h * 0.5),
        width: w * 0.31,
        height: h * 0.70,
      ),
      const Radius.circular(12),
    );
    canvas.drawRRect(screenRect, paint);

    // ── Orange checkmark circle ──
    paint.color = const Color(0xFFFF9800);
    canvas.drawCircle(Offset(w * 0.5, h * 0.5), 22, paint);

    // White check mark
    final check = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = 4.5
      ..strokeCap = StrokeCap.round
      ..color = Colors.white;
    final path = Path()
      ..moveTo(w * 0.44, h * 0.5)
      ..lineTo(w * 0.485, h * 0.55)
      ..lineTo(w * 0.565, h * 0.45);
    canvas.drawPath(path, check);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

// ──────────────────────────────────────────────
//  Success dialog
// ──────────────────────────────────────────────

class _SuccessDialog extends StatelessWidget {
  const _SuccessDialog();

  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: Colors.transparent,
      insetPadding: const EdgeInsets.symmetric(horizontal: 32),
      child: Container(
        padding: const EdgeInsets.fromLTRB(24, 32, 24, 24),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(24),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const _SuccessBadge(),
            const SizedBox(height: 24),
            Text(
              "Congratulations!",
              style: GoogleFonts.poppins(
                fontSize: 20,
                fontWeight: FontWeight.w700,
                color: const Color(0xFF1A1A2E),
              ),
            ),
            const SizedBox(height: 12),
            Text(
              "Your account is ready to use. You will be redirected to the Home page in a few seconds..",
              textAlign: TextAlign.center,
              style: GoogleFonts.poppins(
                fontSize: 14,
                color: Colors.grey,
                height: 1.5,
              ),
            ),
            const SizedBox(height: 24),
            const SizedBox(
              width: 36,
              height: 36,
              child: CircularProgressIndicator(
                strokeWidth: 3.5,
                color: Color(0xFFFF9800),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _SuccessBadge extends StatelessWidget {
  const _SuccessBadge();

  @override
  Widget build(BuildContext context) {
    return Stack(
      clipBehavior: Clip.none,
      alignment: Alignment.center,
      children: [
        Container(
          width: 120,
          height: 120,
          decoration: BoxDecoration(
            color: const Color(0xFFFFF3E0),
            borderRadius: BorderRadius.circular(28),
          ),
        ),
        const Positioned(top: -6, right: 16, child: _Dot(size: 10)),
        const Positioned(bottom: 18, left: -8, child: _Dot(size: 7)),
        const Positioned(top: 24, left: -12, child: _Dot(size: 6)),
        const Positioned(bottom: -6, right: -8, child: _Dot(size: 8)),
        Container(
          width: 76,
          height: 76,
          decoration: const BoxDecoration(
            color: Color(0xFFFF9800),
            shape: BoxShape.circle,
          ),
          child: const Icon(Icons.check, color: Colors.white, size: 44),
        ),
      ],
    );
  }
}

class _Dot extends StatelessWidget {
  final double size;

  const _Dot({required this.size});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: size,
      height: size,
      decoration: const BoxDecoration(
        color: Color(0xFFFF9800),
        shape: BoxShape.circle,
      ),
    );
  }
}
