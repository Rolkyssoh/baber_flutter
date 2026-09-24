import 'package:barber_shops/widgets/section_details.dart';
import 'package:flutter/material.dart';

const galleryImages = [
  'assets/images/haircut2.jpg',
  'assets/images/haircut.jpg',
  'assets/images/haircut3.jpg',
  'assets/images/haircut3.jpg',
  'assets/images/haircut2.jpg',
  'assets/images/haircut.jpg',
  'assets/images/haircut2.jpg',
  'assets/images/haircut3.jpg',
  'assets/images/haircut.jpg',
  'assets/images/haircut.jpg',
  'assets/images/haircut3.jpg',
  'assets/images/haircut2.jpg',
  'assets/images/haircut3.jpg',
  'assets/images/haircut.jpg',
  'assets/images/haircut2.jpg',
  'assets/images/haircut2.jpg',
  'assets/images/haircut3.jpg',
  'assets/images/haircut.jpg',
];

class GalleryDetailsTab extends StatelessWidget {
  const GalleryDetailsTab({super.key});

  @override
  Widget build(BuildContext context) {
    return SectionDetails(
      title: 'Our Gallery',
      action: 'See All',
      child: GridView.builder(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        itemCount: galleryImages.length,
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 3,
          crossAxisSpacing: 8,
          mainAxisSpacing: 8,
          childAspectRatio: 1,
        ),
        itemBuilder: (context, index) {
          return ClipRRect(
            borderRadius: BorderRadius.circular(9),
            child: Image.asset(galleryImages[index], fit: BoxFit.cover),
          );
        },
      ),
    );
  }
}
