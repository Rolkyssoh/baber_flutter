import 'dart:async';

import 'package:barber_shops/screens/authentication/create_new_password.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';

class OtpVerify extends StatefulWidget {
  final String destination;

  const OtpVerify({super.key, required this.destination});

  @override
  State<OtpVerify> createState() => _OtpVerifyState();
}

class _OtpVerifyState extends State<OtpVerify> {
  static const _orange = Color(0xFFFF9800);
  static const _dark = Color(0xFF1A1A2E);

  final List<TextEditingController> _controllers = List.generate(
    4,
    (_) => TextEditingController(),
  );
  final List<FocusNode> _focusNodes = List.generate(4, (_) => FocusNode());

  Timer? _timer;
  int _secondsLeft = 53;

  @override
  void initState() {
    super.initState();
    _startTimer();
  }

  void _startTimer() {
    _timer?.cancel();
    _secondsLeft = 53;
    _timer = Timer.periodic(const Duration(seconds: 1), (t) {
      if (_secondsLeft <= 0) {
        t.cancel();
        setState(() {});
      } else {
        setState(() => _secondsLeft--);
      }
    });
  }

  @override
  void dispose() {
    _timer?.cancel();
    for (final c in _controllers) {
      c.dispose();
    }
    for (final f in _focusNodes) {
      f.dispose();
    }
    super.dispose();
  }

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

              // ── Confirmation message ──
              Text(
                "Code has been send to ${widget.destination}",
                style: GoogleFonts.poppins(
                  fontSize: 15,
                  color: Colors.black,
                  height: 1.5,
                ),
              ),

              const SizedBox(height: 32),

              // ── 4 OTP input boxes ──
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: List.generate(4, (i) => _buildOtpBox(i)),
              ),

              const SizedBox(height: 28),

              // ── Resend timer ──
              Center(
                child: _secondsLeft > 0
                    ? Text(
                        "Resend code in $_secondsLeft s",
                        style: GoogleFonts.poppins(
                          fontSize: 14,
                          color: _orange,
                          fontWeight: FontWeight.w500,
                        ),
                      )
                    : GestureDetector(
                        onTap: _startTimer,
                        child: Text(
                          "Resend code",
                          style: GoogleFonts.poppins(
                            fontSize: 14,
                            color: _orange,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
              ),

              const Spacer(),

              // ── Verify button ──
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => const CreateNewPassword(),
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
                    "Verify",
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

  Widget _buildOtpBox(int index) {
    return SizedBox(
      width: 64,
      height: 64,
      child: TextField(
        controller: _controllers[index],
        focusNode: _focusNodes[index],
        textAlign: TextAlign.center,
        keyboardType: TextInputType.number,
        maxLength: 1,
        inputFormatters: [FilteringTextInputFormatter.digitsOnly],
        style: GoogleFonts.poppins(
          fontSize: 24,
          fontWeight: FontWeight.w600,
          color: _dark,
        ),
        onChanged: (v) {
          if (v.isNotEmpty && index < 3) {
            _focusNodes[index + 1].requestFocus();
          }
          setState(() {});
        },
        decoration: InputDecoration(
          counterText: '',
          filled: true,
          fillColor: const Color(0xFFF2F2F2),
          contentPadding: EdgeInsets.zero,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: BorderSide.none,
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: BorderSide.none,
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: const BorderSide(color: _orange, width: 1.5),
          ),
        ),
      ),
    );
  }
}
