import 'package:barber_shops/screens/authentication/auth_dashboard.dart';
import 'package:barber_shops/screens/authentication/forget_pwd.dart';
import 'package:barber_shops/screens/authentication/sign_up_form.dart';
import 'package:barber_shops/screens/hom_screen.dart';
import 'package:barber_shops/utils/app_text_field.dart';
import 'package:barber_shops/utils/social_icons.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class SignInForm extends StatefulWidget {
  const SignInForm({super.key});

  @override
  State<SignInForm> createState() => _SignInFormState();
}

class _SignInFormState extends State<SignInForm> {
  final _formKey = GlobalKey<FormState>();

  final emailCtrl = TextEditingController();
  final pwdCtrl = TextEditingController();
  bool _rememberMe = false;
  bool _obscurePassword = true;

  @override
  void dispose() {
    emailCtrl.dispose();
    pwdCtrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 24),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // ── Back arrow ──
                Align(
                  alignment: Alignment.centerLeft,
                  child: IconButton(
                    icon: const Icon(Icons.arrow_back_ios, size: 22),
                    onPressed: () {
                      if (Navigator.canPop(context)) {
                        Navigator.pop(context);
                      } else {
                        Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                            builder: (_) => const AuthDashboard(),
                          ),
                        );
                      }
                    },
                  ),
                ),

                const SizedBox(height: 58),

                // ── Title ──
                Text(
                  "Login to your Account",
                  style: GoogleFonts.poppins(
                    fontSize: 30,
                    fontWeight: FontWeight.w700,
                    color: const Color(0xFF1A1A2E),
                  ),
                ),

                const SizedBox(height: 28),

                // ── Email ──
                AppTextField(
                  controller: emailCtrl,
                  hint: "Email",
                  prefixIcon: Icons.email_outlined,
                  keyboardType: TextInputType.emailAddress,
                  validator: (v) {
                    if (v == null || v.trim().isEmpty) {
                      return "Email is required";
                    }
                    if (!RegExp(
                      r'^[^@\s]+@[^@\s]+\.[^@\s]+$',
                    ).hasMatch(v.trim())) {
                      return "Enter a valid email";
                    }
                    return null;
                  },
                ),

                const SizedBox(height: 20),

                // ── Password ──
                AppTextField(
                  controller: pwdCtrl,
                  hint: "Password",
                  prefixIcon: Icons.lock_outlined,
                  obscureText: _obscurePassword,
                  suffixIcon: IconButton(
                    icon: Icon(
                      _obscurePassword
                          ? Icons.visibility_off_outlined
                          : Icons.visibility_outlined,
                      color: Colors.grey,
                    ),
                    onPressed: () => setState(() {
                      _obscurePassword = !_obscurePassword;
                    }),
                  ),
                  validator: (v) => v == null || v.trim().isEmpty
                      ? "Password is required"
                      : null,
                ),

                const SizedBox(height: 12),

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
                        side: const BorderSide(
                          color: Color(0xFFFF9800),
                          width: 2,
                        ),
                        activeColor: const Color(0xFFFF9800),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(4),
                        ),
                      ),
                    ),
                    const SizedBox(width: 8),
                    Text(
                      "Remember me",
                      style: GoogleFonts.poppins(
                        fontSize: 14,
                        color: const Color(0xFF1A1A2E),
                      ),
                    ),
                  ],
                ),

                const SizedBox(height: 24),

                // ── Sign in button ──
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: () {
                      if (_formKey.currentState!.validate()) {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (_) => HomeScreen()),
                        );
                      }
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
                      "Sign in",
                      style: GoogleFonts.poppins(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ),

                const SizedBox(height: 20),

                // ── Forgot password? ──
                Center(
                  child: GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (_) => ForgetPwd()),
                      );
                    },
                    child: Text(
                      'Forgot the password?',
                      style: GoogleFonts.poppins(
                        fontSize: 14,
                        color: const Color(0xFFFF9800),
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ),

                const SizedBox(height: 28),

                // ── "or continue with" divider ──
                Row(
                  children: [
                    const Expanded(child: Divider(color: Color(0xFFE8E8E8))),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 12),
                      child: Text(
                        "or continue with",
                        style: GoogleFonts.poppins(
                          fontSize: 13,
                          color: Colors.grey,
                        ),
                      ),
                    ),
                    const Expanded(child: Divider(color: Color(0xFFE8E8E8))),
                  ],
                ),

                const SizedBox(height: 20),

                // ── Social icons ──
                Row(
                  children: [
                    _buildSocialBox(FacebookIcon()),
                    const SizedBox(width: 12),
                    _buildSocialBox(GoogleIcon()),
                    const SizedBox(width: 12),
                    _buildSocialBox(AppleIcon(iconColor: Colors.black)),
                  ],
                ),

                const SizedBox(height: 28),

                // ── Footer: Sign up ──
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
      ),
    );
  }

  Widget _buildSocialBox(Widget icon) {
    return Expanded(
      child: Container(
        height: 50,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: const Color(0xFFE8E8E8), width: 1.2),
        ),
        child: IconButton(onPressed: () {}, icon: icon),
      ),
    );
  }
}
