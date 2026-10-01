import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

const Color _ink = Color(0xFF252525);
const Color _orange = Color(0xFFFF9800);

class SectionDetails extends StatelessWidget {
  const SectionDetails({
    super.key,
    required this.title,
    required this.child,
    this.action,
    this.onTxtBtnPressed
  });

  final String title;
  final Widget child;
  final String? action;
  final VoidCallback? onTxtBtnPressed;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(14, 0, 14, 12),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Text(
                title,
                style: GoogleFonts.poppins(
                  fontSize: 11,
                  fontWeight: FontWeight.w600,
                  color: _ink,
                ),
              ),
              const Spacer(),
              if (action != null)
                TextButton(
                  onPressed: onTxtBtnPressed,
                  child: Text(
                    action ?? '',
                    style: GoogleFonts.poppins(
                      color: _orange,
                      fontSize: 9,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
            ],
          ),
          const SizedBox(height: 8),
          child,
        ],
      ),
    );
  }
}
