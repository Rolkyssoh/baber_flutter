import 'package:barber_shops/widgets/custom_map_painter.dart';
import 'package:barber_shops/widgets/section_details.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

const Color _muted = Color(0xFF777777);
const Color _ink = Color(0xFF252525);
const Color _orange = Color(0xFFFF9800);

class AboutUsDetailsTab extends StatelessWidget {
  const AboutUsDetailsTab({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        _buildAbout(),
        _buildWorkingHours(),
        _buildContact(),
        _buildAddress(),
      ],
    );
  }

  Widget _buildAbout() {
    return SectionDetails(
      title: 'About us',
      child: Text.rich(
        TextSpan(
          text:
              'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip. ',
          style: GoogleFonts.poppins(fontSize: 9, height: 1.35, color: _muted),
          children: [
            TextSpan(
              text: 'Read more...',
              style: GoogleFonts.poppins(
                color: _orange,
                fontSize: 9,
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        ),
      ),
    );
  }

  TextStyle _smallText({Color color = _muted}) =>
      GoogleFonts.poppins(fontSize: 9, color: color);

  Widget _hoursRow(String day, String hours) {
    return Row(
      children: [
        Expanded(child: Text(day, style: _smallText())),
        Text(':', style: _smallText()),
        const SizedBox(width: 7),
        Text(hours, style: _smallText(color: _ink)),
      ],
    );
  }

  Widget _buildWorkingHours() {
    return SectionDetails(
      title: 'Working Hours',
      child: Column(
        children: [
          _hoursRow('Monday - Friday', '08:00 AM - 21:00 PM'),
          const SizedBox(height: 5),
          _hoursRow('Saturday - Sunday', '10:00 AM - 20:00 PM'),
        ],
      ),
    );
  }

  Widget _buildContact() {
    return SectionDetails(
      title: 'Contact us',
      child: Text(
        '(406) 555-0120',
        style: GoogleFonts.poppins(
          color: _orange,
          fontSize: 10,
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }

  Widget _buildAddress() {
    return SectionDetails(
      title: 'Our Address',
      action: 'See on Maps',
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _detailLine(
            Icons.location_on,
            '6993 Meadow Valley Terrace, New York',
          ),
          const SizedBox(height: 10),
          ClipRRect(
            borderRadius: BorderRadius.circular(8),
            child: SizedBox(
              height: 130,
              width: double.infinity,
              child: CustomPaint(
                painter: MapPainter(),
                child: const Center(
                  child: DecoratedBox(
                    decoration: BoxDecoration(
                      color: _orange,
                      shape: BoxShape.circle,
                    ),
                    child: Padding(
                      padding: EdgeInsets.all(8),
                      child: Icon(
                        Icons.location_on,
                        color: Colors.white,
                        size: 20,
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _detailLine(IconData icon, String text, {bool star = false}) {
    return Row(
      children: [
        Icon(icon, size: 13, color: _orange),
        const SizedBox(width: 4),
        Expanded(
          child: Text(
            text,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: GoogleFonts.poppins(fontSize: 9.5, color: _muted),
          ),
        ),
      ],
    );
  }
}
