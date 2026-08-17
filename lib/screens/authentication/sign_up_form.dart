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

  final _fullNameCtrl = TextEditingController();
  final _nicknameCtrl = TextEditingController();
  final _dobCtrl = TextEditingController();
  final _emailCtrl = TextEditingController();
  final _phoneCtrl = TextEditingController();
  final _genderCtrl = TextEditingController();

  String _selectedCountry = 'US';
  String _selectedGender = '';

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

  Future<void> _pickDate() async {
    final now = DateTime.now();
    final picked = await showDatePicker(
      context: context,
      initialDate: DateTime(2000, 1, 1),
      firstDate: DateTime(1950),
      lastDate: now,
      builder: (context, child) {
        return Theme(
          data: Theme.of(context).copyWith(
            colorScheme: const ColorScheme.light(primary: Color(0xFFFF9800)),
          ),
          child: child!,
        );
      },
    );
    if (picked != null) {
      setState(() {
        _dobCtrl.text =
            '${picked.day.toString().padLeft(2, '0')}/'
            '${picked.month.toString().padLeft(2, '0')}/'
            '${picked.year}';
      });
    }
  }

  void _pickGender() {
    showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (_) {
        return Padding(
          padding: const EdgeInsets.symmetric(vertical: 20),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                'Select Gender',
                style: GoogleFonts.poppins(
                  fontSize: 18,
                  fontWeight: FontWeight.w600,
                ),
              ),
              const SizedBox(height: 16),
              ...['Male', 'Female', 'Other'].map(
                (gender) => ListTile(
                  leading: Icon(
                    gender == 'Male'
                        ? Icons.male
                        : gender == 'Female'
                        ? Icons.female
                        : Icons.transgender,
                    color: const Color(0xFFFF9800),
                  ),
                  title: Text(gender, style: GoogleFonts.poppins(fontSize: 16)),
                  trailing: _selectedGender == gender
                      ? const Icon(Icons.check, color: Color(0xFFFF9800))
                      : null,
                  onTap: () {
                    setState(() {
                      _selectedGender = gender;
                      _genderCtrl.text = gender;
                    });
                    Navigator.pop(context);
                  },
                ),
              ),
              const SizedBox(height: 8),
            ],
          ),
        );
      },
    );
  }

  void _onContinue() {
    if (_formKey.currentState!.validate()) {
      // TODO: proceed to next step
    }
  }

  @override
  void dispose() {
    _fullNameCtrl.dispose();
    _nicknameCtrl.dispose();
    _dobCtrl.dispose();
    _emailCtrl.dispose();
    _phoneCtrl.dispose();
    _genderCtrl.dispose();
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

                // ── Full Name ──
                _buildLabel('Full Name'),
                const SizedBox(height: 8),
                AppTextField(
                  controller: _fullNameCtrl,
                  hint: 'Enter your full name',
                  prefixIcon: Icons.person_outline,
                  validator: (v) => v == null || v.trim().isEmpty
                      ? 'Full name is required'
                      : null,
                ),
                const SizedBox(height: 20),

                // ── Nickname ──
                _buildLabel('Nickname'),
                const SizedBox(height: 8),
                AppTextField(
                  controller: _nicknameCtrl,
                  hint: 'Enter your nickname',
                  prefixIcon: Icons.badge_outlined,
                  validator: (v) => v == null || v.trim().isEmpty
                      ? 'Nickname is required'
                      : null,
                ),
                const SizedBox(height: 20),

                // ── Date of Birth ──
                _buildLabel('Date of Birth'),
                const SizedBox(height: 8),
                AppTextField(
                  controller: _dobCtrl,
                  hint: 'DD/MM/YYYY',
                  prefixIcon: Icons.calendar_today_outlined,
                  readOnly: true,
                  onTap: _pickDate,
                  validator: (v) => v == null || v.trim().isEmpty
                      ? 'Date of birth is required'
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
                    if (v == null || v.trim().isEmpty)
                      return 'Email is required';
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
                        validator: (v) => v == null || v.trim().isEmpty
                            ? 'Phone number is required'
                            : null,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 20),

                // ── Gender ──
                _buildLabel('Gender'),
                const SizedBox(height: 8),
                AppTextField(
                  controller: _genderCtrl,
                  hint: 'Select your gender',
                  prefixIcon: Icons.people_outline,
                  readOnly: true,
                  onTap: _pickGender,
                  validator: (v) => v == null || v.trim().isEmpty
                      ? 'Gender is required'
                      : null,
                ),
                const SizedBox(height: 36),

                // ── Continue button ──
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: _onContinue,
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
                      'Continue',
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

  Widget _buildTextField({
    required TextEditingController controller,
    required String hint,
    IconData? prefixIcon,
    bool readOnly = false,
    VoidCallback? onTap,
    TextInputType keyboardType = TextInputType.text,
    String? Function(String?)? validator,
  }) {
    return TextFormField(
      controller: controller,
      readOnly: readOnly,
      onTap: onTap,
      keyboardType: keyboardType,
      validator: validator,
      style: GoogleFonts.poppins(fontSize: 14, color: const Color(0xFF1A1A2E)),
      decoration: InputDecoration(
        hintText: hint,
        hintStyle: GoogleFonts.poppins(fontSize: 14, color: Colors.grey[400]),
        prefixIcon: prefixIcon != null
            ? Icon(prefixIcon, color: const Color(0xFFFF9800), size: 22)
            : null,
        filled: true,
        fillColor: Colors.grey[50],
        contentPadding: const EdgeInsets.symmetric(
          vertical: 16,
          horizontal: 16,
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: Color(0xFFE8E8E8)),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: Color(0xFFE8E8E8)),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: Color(0xFFFF9800), width: 1.5),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: Colors.redAccent),
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: Colors.redAccent, width: 1.5),
        ),
      ),
    );
  }
}
