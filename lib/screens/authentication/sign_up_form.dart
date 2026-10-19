import 'package:barber_shops/dto/auth.dto.dart';
import 'package:barber_shops/model_service/auth.model.dart';
import 'package:barber_shops/screens/authentication/sign_in_form.dart';
import 'package:barber_shops/utils/app_text_field.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class SignUpForm extends StatefulWidget {
  const SignUpForm({super.key});

  @override
  State<SignUpForm> createState() => _SignUpFormState();
}

class _SignUpFormState extends State<SignUpForm> {
  final _formKey = GlobalKey<FormState>();

  final _firstNameCtrl = TextEditingController();
  final _lastNameCtrl = TextEditingController();
  final _emailCtrl = TextEditingController();
  final _phoneCtrl = TextEditingController();
  final _addressCtrl = TextEditingController();
  final _passwordCtrl = TextEditingController();
  final _authModel = AuthModel();

  String _selectedCountry = 'US';
  bool _obscurePassword = true;
  bool _isSubmitting = false;

  final List<Map<String, String>> _countries = [
    {'code': 'US', 'name': 'United States', 'flag': '🇺🇸', 'dial': '+1'},
    {'code': 'FR', 'name': 'France', 'flag': '🇫🇷', 'dial': '+33'},
    {'code': 'GB', 'name': 'United Kingdom', 'flag': '🇬🇧', 'dial': '+44'},
    {'code': 'CA', 'name': 'Canada', 'flag': '🇨🇦', 'dial': '+1'},
    {'code': 'DE', 'name': 'Germany', 'flag': '🇩🇪', 'dial': '+49'},
    {'code': 'IT', 'name': 'Italy', 'flag': '🇮🇹', 'dial': '+39'},
    {'code': 'ES', 'name': 'Spain', 'flag': '🇪🇸', 'dial': '+34'},
    {'code': 'BR', 'name': 'Brazil', 'flag': '🇧🇷', 'dial': '+55'},
    {'code': 'JP', 'name': 'Japan', 'flag': '🇯🇵', 'dial': '+81'},
    {'code': 'CN', 'name': 'China', 'flag': '🇨🇳', 'dial': '+86'},
    {'code': 'IN', 'name': 'India', 'flag': '🇮🇳', 'dial': '+91'},
    {'code': 'SN', 'name': 'Senegal', 'flag': '🇸🇳', 'dial': '+221'},
    {'code': 'CI', 'name': "Côte d'Ivoire", 'flag': '🇨🇮', 'dial': '+225'},
    {'code': 'CM', 'name': 'Cameroon', 'flag': '🇨🇲', 'dial': '+237'},
    {'code': 'MA', 'name': 'Morocco', 'flag': '🇲🇦', 'dial': '+212'},
    {'code': 'DZ', 'name': 'Algeria', 'flag': '🇩🇿', 'dial': '+213'},
    {'code': 'TN', 'name': 'Tunisia', 'flag': '🇹🇳', 'dial': '+216'},
    {'code': 'ZA', 'name': 'South Africa', 'flag': '🇿🇦', 'dial': '+27'},
    {'code': 'NG', 'name': 'Nigeria', 'flag': '🇳🇬', 'dial': '+234'},
    {'code': 'KE', 'name': 'Kenya', 'flag': '🇰🇪', 'dial': '+254'},
  ];

  Map<String, String> get _selectedCountryData =>
      _countries.firstWhere((c) => c['code'] == _selectedCountry);

  Future<void> _onContinue() async {
    if (!_formKey.currentState!.validate()) {
      return;
    }

    setState(() => _isSubmitting = true);
    try {
      final phone = _phoneCtrl.text.trim();
      await _authModel.registerUser(
        RegisterDto(
          firstName: _firstNameCtrl.text.trim(),
          lastName: _lastNameCtrl.text.trim(),
          email: _emailCtrl.text.trim(),
          password: _passwordCtrl.text,
          phone: phone.isEmpty
              ? null
              : '${_selectedCountryData['dial']} $phone',
          address: _addressCtrl.text.trim().isEmpty
              ? null
              : _addressCtrl.text.trim(),
        ),
      );

      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Inscription réussie. Connectez-vous.')),
      );
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (_) => const SignInForm()),
      );
    } catch (error) {
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Échec de l’inscription : $error')),
      );
    } finally {
      if (mounted) {
        setState(() => _isSubmitting = false);
      }
    }
  }

  @override
  void dispose() {
    _firstNameCtrl.dispose();
    _lastNameCtrl.dispose();
    _emailCtrl.dispose();
    _phoneCtrl.dispose();
    _addressCtrl.dispose();
    _passwordCtrl.dispose();
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
                // ── Header: back arrow + title ──
                Row(
                  children: [
                    IconButton(
                      icon: const Icon(Icons.arrow_back_ios, size: 22),
                      onPressed: () => Navigator.pop(context),
                    ),
                    const SizedBox(width: 8),
                    Text(
                      'Fill Your Profile',
                      style: GoogleFonts.poppins(
                        fontSize: 22,
                        fontWeight: FontWeight.w700,
                        color: const Color(0xFF1A1A2E),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 12),

                // ── Profile photo ──
                Center(
                  child: Stack(
                    children: [
                      Container(
                        width: 110,
                        height: 110,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: Colors.grey[100],
                          border: Border.all(
                            color: const Color(0xFFE8E8E8),
                            width: 2,
                          ),
                        ),
                        child: const Icon(
                          Icons.person,
                          size: 60,
                          color: Color(0xFFBDBDBD),
                        ),
                      ),
                      Positioned(
                        bottom: 0,
                        right: 0,
                        child: Container(
                          width: 36,
                          height: 36,
                          decoration: const BoxDecoration(
                            shape: BoxShape.circle,
                            color: Color(0xFFFF9800),
                          ),
                          child: const Icon(
                            Icons.camera_alt,
                            color: Colors.white,
                            size: 18,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 32),

                // ── First Name ──
                _buildLabel('First Name'),
                const SizedBox(height: 8),
                AppTextField(
                  controller: _firstNameCtrl,
                  hint: 'Enter your first name',
                  prefixIcon: Icons.person_outline,
                  validator: (v) => v == null || v.trim().isEmpty
                      ? 'First name is required'
                      : null,
                ),
                const SizedBox(height: 20),

                // ── Last Name ──
                _buildLabel('Last Name'),
                const SizedBox(height: 8),
                AppTextField(
                  controller: _lastNameCtrl,
                  hint: 'Enter your last name',
                  prefixIcon: Icons.badge_outlined,
                  validator: (v) => v == null || v.trim().isEmpty
                      ? 'Last name is required'
                      : null,
                ),
                const SizedBox(height: 20),

                // ── Email ──
                _buildLabel('Email'),
                const SizedBox(height: 8),
                AppTextField(
                  controller: _emailCtrl,
                  hint: 'Enter your email',
                  prefixIcon: Icons.email_outlined,
                  keyboardType: TextInputType.emailAddress,
                  validator: (v) {
                    if (v == null || v.trim().isEmpty) {
                      return 'Email is required';
                    }
                    if (!RegExp(
                      r'^[^@\s]+@[^@\s]+\.[^@\s]+$',
                    ).hasMatch(v.trim())) {
                      return 'Enter a valid email';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 20),

                // ── Phone Number ──
                _buildLabel('Phone Number'),
                const SizedBox(height: 8),
                Row(
                  children: [
                    // Country dropdown
                    Container(
                      height: 54,
                      decoration: BoxDecoration(
                        border: Border.all(color: const Color(0xFFE8E8E8)),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: PopupMenuButton<String>(
                        offset: const Offset(0, 54),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                        onSelected: (code) {
                          setState(() => _selectedCountry = code);
                        },
                        itemBuilder: (_) => _countries
                            .map(
                              (c) => PopupMenuItem<String>(
                                value: c['code'],
                                child: Row(
                                  children: [
                                    Text(
                                      c['flag']!,
                                      style: const TextStyle(fontSize: 20),
                                    ),
                                    const SizedBox(width: 10),
                                    Text(
                                      c['name']!,
                                      style: GoogleFonts.poppins(fontSize: 14),
                                    ),
                                    const Spacer(),
                                    Text(
                                      c['dial']!,
                                      style: GoogleFonts.poppins(
                                        fontSize: 13,
                                        color: Colors.grey,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            )
                            .toList(),
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 14),
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Text(
                                _selectedCountryData['flag']!,
                                style: const TextStyle(fontSize: 22),
                              ),
                              const SizedBox(width: 6),
                              Text(
                                _selectedCountryData['dial']!,
                                style: GoogleFonts.poppins(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                              const Icon(
                                Icons.arrow_drop_down,
                                color: Colors.grey,
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(width: 10),
                    // Phone input
                    Expanded(
                      child: AppTextField(
                        controller: _phoneCtrl,
                        hint: 'Phone number',
                        keyboardType: TextInputType.phone,
                        validator: (_) => null,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 20),

                // ── Address ──
                _buildLabel('Address (optional)'),
                const SizedBox(height: 8),
                AppTextField(
                  controller: _addressCtrl,
                  hint: 'Enter your address',
                  prefixIcon: Icons.location_on_outlined,
                  validator: (_) => null,
                ),
                const SizedBox(height: 20),

                // ── Password ──
                _buildLabel('Password'),
                const SizedBox(height: 8),
                AppTextField(
                  controller: _passwordCtrl,
                  hint: 'At least 6 characters',
                  prefixIcon: Icons.lock_outline,
                  obscureText: _obscurePassword,
                  suffixIcon: IconButton(
                    icon: Icon(
                      _obscurePassword
                          ? Icons.visibility_off_outlined
                          : Icons.visibility_outlined,
                      color: Colors.grey,
                    ),
                    onPressed: () =>
                        setState(() => _obscurePassword = !_obscurePassword),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Password is required';
                    }
                    if (value.length < 6) {
                      return 'Password must contain at least 6 characters';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 36),

                // ── Continue button ──
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: _isSubmitting ? null : _onContinue,
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
                      _isSubmitting ? 'Creating account...' : 'Continue',
                      style: GoogleFonts.poppins(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 32),
              ],
            ),
          ),
        ),
      ),
    );
  }

  // ── Helpers ──

  Widget _buildLabel(String text) {
    return Text(
      text,
      style: GoogleFonts.poppins(
        fontSize: 14,
        fontWeight: FontWeight.w600,
        color: const Color(0xFF1A1A2E),
      ),
    );
  }
}
