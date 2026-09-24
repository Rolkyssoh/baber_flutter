import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

const reviews = [
  (
    'assets/images/haircut2.jpg',
    'Marielle Wington',
    '5',
    'The people who work here are very friendly and professional, I really like it! 👍👏',
    '992',
    '1 months ago',
  ),
  (
    'assets/images/haircut.jpg',
    'Annabel Rohan',
    '4',
    'This is my first time trying the service here, but the results are very satisfying! love it! ❤️❤️❤️',
    '748',
    '1 months ago',
  ),
  (
    'assets/images/haircut3.jpg',
    'Rayford Chenail',
    '4',
    'I just found out that this salon is near my house. I think I’ll be visiting it more often! 😊',
    '572',
    '2 months ago',
  ),
  (
    'assets/images/haircut2.jpg',
    'Tynish Obey',
    '5',
    'Professional service and satisfying results! I highly recommend this to my friends! 👍👏🔥',
    '493',
    '3 months ago',
  ),
  (
    'assets/images/haircut3.jpg',
    'Willard Purnell',
    '4',
    'This is my first time trying the service here, but the results are very satisfying! love it! ❤️❤️❤️',
    '391',
    '3 months ago',
  ),
];

const Color _muted = Color(0xFF777777);
const Color _ink = Color(0xFF252525);
const Color _orange = Color(0xFFFF9800);

class ReviewDetailsTab extends StatelessWidget {
  const ReviewDetailsTab({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(14, 0, 14, 12),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              const Icon(Icons.star, size: 14, color: _orange),
              const SizedBox(width: 5),
              Text(
                '4.8 (3,279 reviews)',
                style: GoogleFonts.poppins(
                  fontSize: 10,
                  fontWeight: FontWeight.w600,
                  color: _ink,
                ),
              ),
              const Spacer(),
              Text(
                'See All',
                style: GoogleFonts.poppins(
                  color: _orange,
                  fontSize: 9,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
          const SizedBox(height: 11),
          ...reviews.map(_buildReviewCard),
        ],
      ),
    );
  }

  Widget _buildReviewCard(
    (String, String, String, String, String, String) review,
  ) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 13),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ClipOval(
            child: Image.asset(
              review.$1,
              width: 25,
              height: 25,
              fit: BoxFit.cover,
            ),
          ),
          const SizedBox(width: 8),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Expanded(
                      child: Text(
                        review.$2,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: GoogleFonts.poppins(
                          fontSize: 9,
                          fontWeight: FontWeight.w600,
                          color: _ink,
                        ),
                      ),
                    ),
                    Container(
                      height: 19,
                      padding: const EdgeInsets.symmetric(horizontal: 7),
                      decoration: BoxDecoration(
                        border: Border.all(color: _orange),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Row(
                        children: [
                          const Icon(Icons.star, size: 9, color: _orange),
                          const SizedBox(width: 2),
                          Text(
                            review.$3,
                            style: GoogleFonts.poppins(
                              fontSize: 8,
                              fontWeight: FontWeight.w600,
                              color: _orange,
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(width: 8),
                    const Icon(Icons.more_horiz, size: 16, color: _muted),
                  ],
                ),
                const SizedBox(height: 3),
                Text(
                  review.$4,
                  style: GoogleFonts.poppins(
                    fontSize: 7.5,
                    height: 1.3,
                    color: _muted,
                  ),
                ),
                const SizedBox(height: 5),
                Row(
                  children: [
                    const Icon(Icons.favorite, size: 11, color: Colors.pink),
                    const SizedBox(width: 3),
                    Text(review.$5, style: _smallText()),
                    const SizedBox(width: 10),
                    Text(review.$6, style: _smallText()),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  TextStyle _smallText({Color color = _muted}) =>
      GoogleFonts.poppins(fontSize: 9, color: color);
}
