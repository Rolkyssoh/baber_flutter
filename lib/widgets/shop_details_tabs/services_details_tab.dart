import 'package:barber_shops/widgets/section_details.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

const services = [
  ('Hair Cut', '44 types'),
  ('Hair Coloring', '12 types'),
  ('Hair Wash', '8 types'),
  ('Shaving', '22 types'),
  ('Skin Care', '12 types'),
  ('Hair Dryer', '4 types'),
  ('Face Make up', '18 types'),
];

const Color _muted = Color(0xFF777777);
const Color _ink = Color(0xFF252525);
const Color _orange = Color(0xFFFF9800);

class ServicesDetailsTab extends StatelessWidget {
  const ServicesDetailsTab({super.key});

  @override
  Widget build(BuildContext context) {
    return SectionDetails(
      title: 'Our Services',
      action: 'See All',
      child: Column(
        children: services
            .map(
              (service) => Padding(
                padding: const EdgeInsets.only(bottom: 8),
                child: Container(
                  height: 48,
                  padding: const EdgeInsets.symmetric(horizontal: 14),
                  decoration: BoxDecoration(
                    color: const Color(0xFFFDFDFD),
                    borderRadius: BorderRadius.circular(8),
                    boxShadow: const [
                      BoxShadow(
                        color: Color(0x08000000),
                        blurRadius: 7,
                        offset: Offset(0, 2),
                      ),
                    ],
                  ),
                  child: Row(
                    children: [
                      Expanded(
                        child: Text(
                          service.$1,
                          style: GoogleFonts.poppins(
                            fontSize: 9,
                            color: _muted,
                          ),
                        ),
                      ),
                      Text(
                        service.$2,
                        style: GoogleFonts.poppins(
                          fontSize: 9,
                          fontWeight: FontWeight.w600,
                          color: _ink,
                        ),
                      ),
                      const SizedBox(width: 10),
                      const Icon(
                        Icons.arrow_forward_ios,
                        size: 10,
                        color: _orange,
                      ),
                    ],
                  ),
                ),
              ),
            )
            .toList(),
      ),
    );
  }
}
