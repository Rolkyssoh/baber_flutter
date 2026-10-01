import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

const Color _orange = Color(0xFFFF9800);
const Color _bookmarkInk = Color(0xFF1A1A2E);

class MoreScreenLayout extends StatelessWidget {
  const MoreScreenLayout({
    super.key,
    required this.title,
    required this.body,
    this.onBtnPressed,
    this.btnText,
  });

  final String title;
  final Widget body;
  final VoidCallback? onBtnPressed;
  final String? btnText;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: ListView(
          padding: EdgeInsets.all(10),
          children: [
            Padding(
              padding: const EdgeInsets.all(2),
              child: Row(
                children: [
                  IconButton(
                    onPressed: () => Navigator.maybePop(context),
                    icon: const Icon(Icons.arrow_back, size: 24),
                  ),
                  const SizedBox(width: 15),
                  Text(
                    title,
                    style: GoogleFonts.autourOne(
                      fontSize: 12,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  const Spacer(),
                  Container(
                    width: 20,
                    height: 20,
                    decoration: BoxDecoration(
                      border: Border.all(color: _bookmarkInk, width: 1.2),
                      shape: BoxShape.circle,
                    ),
                    child: const Center(
                      child: Icon(Icons.more_horiz, size: 15),
                    ),
                  ),
                ],
              ),
            ),
            Padding(padding: const EdgeInsets.only(top: 2), child: body),
          ],
        ),
      ),
      bottomNavigationBar: SafeArea(
        top: false,
        child: Container(
          padding: const EdgeInsets.fromLTRB(14, 10, 14, 14),
          decoration: const BoxDecoration(
            color: Colors.white,
            border: Border(top: BorderSide(color: _orange)),
          ),
          child: SizedBox(
            height: 45,
            child: FilledButton(
              onPressed: onBtnPressed,
              style: ButtonStyle(
                backgroundColor: WidgetStatePropertyAll(_orange),
                foregroundColor: WidgetStatePropertyAll(Colors.white),
                shape: WidgetStatePropertyAll(
                  RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(24),
                  ),
                ),
              ),
              child: Text(
                btnText ?? '',
                style: GoogleFonts.autourOne(
                  fontSize: 12,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
