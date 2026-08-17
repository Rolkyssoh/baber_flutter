import 'package:barber_shops/screens/authentication/otp_verify.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class ForgetPwd extends StatefulWidget {
  const ForgetPwd({super.key});

  @override
  State<ForgetPwd> createState() => _ForgetPwdState();
}

class _ForgetPwdState extends State<ForgetPwd> {
  int _selected = 0; // 0 = SMS, 1 = Email

  static const _orange = Color(0xFFFF9800);
  static const _selectedBlue = Color(0xFF3B82F6);
  static const _dark = Color(0xFF1A1A2E);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Padding(
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
                    "Forgot Password",
                    style: GoogleFonts.poppins(
                      fontSize: 22,
                      fontWeight: FontWeight.w700,
                      color: _dark,
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 20),

              // ── Subtitle ──
              Text(
                "Select which contact details should we use to reset your password",
                style: GoogleFonts.poppins(
                  fontSize: 15,
                  color: Colors.black,
                  height: 1.5,
                ),
              ),

              const SizedBox(height: 28),

              // ── Option 1: SMS (selected) ──
              _buildOption(
                index: 0,
                icon: Icons.sms_outlined,
                label: "via SMS:",
                value: "+1 111 ******99",
              ),

              const SizedBox(height: 16),

              // ── Option 2: Email ──
              _buildOption(
                index: 1,
                icon: Icons.email_outlined,
                label: "via Email:",
                value: "dan***in@yourdomain.com",
              ),

              const Spacer(),

              // ── Continue button ──
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () {
                    final destination = _selected == 0
                        ? "+1 111 ******99"
                        : "dan***in@yourdomain.com";
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => OtpVerify(destination: destination),
                      ),
                    );
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

  Widget _buildOption({
    required int index,
    required IconData icon,
    required String label,
    required String value,
  }) {
    final selected = _selected == index;
    return InkWell(
      onTap: () => setState(() => _selected = index),
      borderRadius: BorderRadius.circular(14),
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: selected ? const Color(0xFFF5F9FF) : Colors.white,
          borderRadius: BorderRadius.circular(14),
          border: Border.all(
            color: selected ? _selectedBlue : const Color(0xFFE8E8E8),
            width: selected ? 2 : 1.2,
          ),
        ),
        child: Row(
          children: [
            // ── Icon in light orange circle ──
            Container(
              width: 46,
              height: 46,
              decoration: const BoxDecoration(
                color: Color(0xFFFFF3E0),
                shape: BoxShape.circle,
              ),
              child: Icon(icon, color: _orange, size: 24),
            ),

            const SizedBox(width: 14),

            // ── Label + masked value ──
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    label,
                    style: GoogleFonts.poppins(
                      fontSize: 13,
                      color: Colors.grey,
                    ),
                  ),
                  const SizedBox(height: 3),
                  Text(
                    value,
                    style: GoogleFonts.poppins(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                      color: _dark,
                    ),
                  ),
                ],
              ),
            ),

            // ── Radio indicator ──
            Icon(
              selected
                  ? Icons.radio_button_checked
                  : Icons.radio_button_unchecked,
              color: selected ? _selectedBlue : const Color(0xFFBDBDBD),
              size: 24,
            ),
          ],
        ),
      ),
    );
  }
}
