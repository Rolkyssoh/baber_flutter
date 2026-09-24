import 'package:barber_shops/widgets/section_details.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

const packages = [
  ('assets/images/haircut.jpg', 'Haircut & Hairstyle', '\$125'),
  ('assets/images/haircut2.jpg', 'Beauty Make up', '\$140'),
  ('assets/images/haircut3.jpg', 'Haircut & Hair Coloring', '\$100'),
  ('assets/images/haircut2.jpg', 'Bridal Make up', '\$160'),
  ('assets/images/haircut3.jpg', 'Hair Wash & Coloring', '\$120'),
];

const Color _muted = Color(0xFF777777);
const Color _ink = Color(0xFF252525);
const Color _orange = Color(0xFFFF9800);

class PackageDetailsTab extends StatelessWidget {
  const PackageDetailsTab({super.key});

  @override
  Widget build(BuildContext context) {
    return SectionDetails(
      title: 'Our Package',
      action: 'See All',
      child: Column(
        children: packages
            .map(
              (package) => Padding(
                padding: const EdgeInsets.only(bottom: 9),
                child: Container(
                  height: 78,
                  padding: const EdgeInsets.all(7),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(13),
                    boxShadow: const [
                      BoxShadow(
                        color: Color(0x0D000000),
                        blurRadius: 9,
                        offset: Offset(0, 2),
                      ),
                    ],
                  ),
                  child: Row(
                    children: [
                      ClipRRect(
                        borderRadius: BorderRadius.circular(10),
                        child: Image.asset(
                          package.$1,
                          width: 56,
                          height: 64,
                          fit: BoxFit.cover,
                        ),
                      ),
                      const SizedBox(width: 8),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              package.$2,
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              style: GoogleFonts.poppins(
                                fontSize: 9.5,
                                fontWeight: FontWeight.w600,
                                color: _ink,
                              ),
                            ),
                            const SizedBox(height: 2),
                            Text(
                              'Special Offers Package, valid\nuntil Dec. 20, 2024',
                              style: GoogleFonts.poppins(
                                fontSize: 7,
                                height: 1.25,
                                color: _muted,
                              ),
                            ),
                            const Spacer(),
                            Row(
                              children: [
                                Text(
                                  package.$3,
                                  style: GoogleFonts.poppins(
                                    fontSize: 9,
                                    fontWeight: FontWeight.w600,
                                    color: _orange,
                                  ),
                                ),
                                const Spacer(),
                                SizedBox(
                                  height: 21,
                                  child: FilledButton(
                                    onPressed: () {},
                                    style: FilledButton.styleFrom(
                                      backgroundColor: _orange,
                                      foregroundColor: Colors.white,
                                      padding: const EdgeInsets.symmetric(
                                        horizontal: 10,
                                      ),
                                      minimumSize: Size.zero,
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(12),
                                      ),
                                    ),
                                    child: Text(
                                      'Book Now',
                                      style: GoogleFonts.poppins(
                                        fontSize: 7,
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
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
