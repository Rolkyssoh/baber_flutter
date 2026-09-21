import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

const Color _shopCardOrange = Color(0xFFFF9800);
const Color _shopCardInk = Color(0xFF1A1A2E);

class ShopCardData {
  const ShopCardData({
    required this.id,
    required this.name,
    required this.address,
    required this.distance,
    required this.rating,
    required this.category,
    required this.image,
  });

  final String id;
  final String name;
  final String address;
  final String distance;
  final String rating;
  final String category;
  final String image;
}

class ShopCard extends StatelessWidget {
  const ShopCard({
    super.key,
    required this.shop,
    required this.isBookmarked,
    required this.onBookmarkPressed,
  });

  final ShopCardData shop;
  final bool isBookmarked;
  final VoidCallback onBookmarkPressed;

  @override
  Widget build(BuildContext context) {
    final imageUrl = shop.image.startsWith('/')
        ? 'http://10.0.2.2:4200${shop.image}'
        : shop.image;

    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.05),
            blurRadius: 12,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Row(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(12),
            child: imageUrl.startsWith('http')
                ? Image.network(
                    imageUrl,
                    width: 64,
                    height: 64,
                    fit: BoxFit.cover,
                    errorBuilder: (context, error, stackTrace) =>
                        _imagePlaceholder(),
                  )
                : Image.asset(
                    imageUrl,
                    width: 64,
                    height: 64,
                    fit: BoxFit.cover,
                    errorBuilder: (context, error, stackTrace) =>
                        _imagePlaceholder(),
                  ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  shop.name,
                  style: GoogleFonts.poppins(
                    fontSize: 15,
                    fontWeight: FontWeight.w600,
                    color: _shopCardInk,
                  ),
                ),
                const SizedBox(height: 2),
                Text(
                  shop.address,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: GoogleFonts.poppins(
                    fontSize: 12,
                    color: Colors.grey[500],
                  ),
                ),
                const SizedBox(height: 6),
                Row(
                  children: [
                    const Icon(
                      Icons.location_on_outlined,
                      size: 14,
                      color: _shopCardOrange,
                    ),
                    const SizedBox(width: 3),
                    Text(
                      shop.distance,
                      style: GoogleFonts.poppins(
                        fontSize: 12,
                        color: Colors.grey[600],
                      ),
                    ),
                    const SizedBox(width: 10),
                    const Icon(Icons.star, size: 14, color: Color(0xFFFFC107)),
                    const SizedBox(width: 3),
                    Text(
                      shop.rating,
                      style: GoogleFonts.poppins(
                        fontSize: 12,
                        fontWeight: FontWeight.w600,
                        color: _shopCardInk,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          IconButton(
            tooltip: isBookmarked
                ? 'Retirer des favoris'
                : 'Ajouter aux favoris',
            onPressed: onBookmarkPressed,
            icon: Icon(
              isBookmarked ? Icons.bookmark : Icons.bookmark_border,
              color: isBookmarked ? _shopCardOrange : _shopCardInk,
              size: 22,
            ),
          ),
        ],
      ),
    );
  }

  Widget _imagePlaceholder() {
    return Container(
      width: 64,
      height: 64,
      color: Colors.grey[200],
      child: const Icon(Icons.image, color: Colors.grey),
    );
  }
}
