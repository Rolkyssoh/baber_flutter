import 'package:barber_shops/widgets/section_details.dart';
import 'package:barber_shops/widgets/shop_details_tabs/about_details_tab.dart';
import 'package:barber_shops/widgets/shop_details_tabs/gallery_details_tab.dart';
import 'package:barber_shops/widgets/shop_details_tabs/package_details_tab.dart';
import 'package:barber_shops/widgets/shop_details_tabs/review_details_tab.dart';
import 'package:barber_shops/widgets/shop_details_tabs/services_details_tab.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

const Color _orange = Color(0xFFFF9800);
const Color _ink = Color(0xFF252525);
const Color _muted = Color(0xFF777777);

class ShopDetailsScreen extends StatefulWidget {
  const ShopDetailsScreen({super.key});

  @override
  State<ShopDetailsScreen> createState() => _ShopDetailsScreenState();
}

class _ShopDetailsScreenState extends State<ShopDetailsScreen> {
  static const _heroImages = [
    'assets/images/haircut.jpg',
    'assets/images/haircut2.jpg',
    'assets/images/haircut3.jpg',
  ];

  int _selectedTab = 0;
  int _heroPage = 0;

  @override
  Widget build(BuildContext context) {  
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        bottom: false,
        child: CustomScrollView(
          slivers: [
            SliverToBoxAdapter(child: _buildHero(context)),
            SliverToBoxAdapter(child: _buildShopSummary()),
            SliverToBoxAdapter(child: _buildQuickActions()),
            SliverToBoxAdapter(child: _buildSpecialists()),
            SliverToBoxAdapter(child: _buildTabs()),
            SliverToBoxAdapter(child: _buildSelectedTabContent()),
            const SliverToBoxAdapter(child: SizedBox(height: 96)),
          ],
        ),
      ),
      bottomNavigationBar: SafeArea(
        top: false,
        child: Container(
          padding: const EdgeInsets.fromLTRB(14, 10, 14, 14),
          decoration: const BoxDecoration(
            color: Colors.white,
            border: Border(top: BorderSide(color: Color(0xFFF0F0F0))),
          ),
          child: SizedBox(
            height: 46,
            child: FilledButton(
              onPressed: () {},
              style: FilledButton.styleFrom(
                backgroundColor: _orange,
                foregroundColor: Colors.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(24),
                ),
              ),
              child: Text(
                'Book Now',
                style: GoogleFonts.poppins(
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

  Widget _buildHero(BuildContext context) {
    return SizedBox(
      height: 180,
      child: Stack(
        fit: StackFit.expand,
        children: [
          PageView.builder(
            itemCount: _heroImages.length,
            onPageChanged: (page) => setState(() => _heroPage = page),
            itemBuilder: (context, index) =>
                Image.asset(_heroImages[index], fit: BoxFit.cover),
          ),
          DecoratedBox(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  Colors.black.withValues(alpha: 0.32),
                  Colors.transparent,
                  Colors.black.withValues(alpha: 0.12),
                ],
              ),
            ),
          ),
          Positioned(
            top: 8,
            left: 8,
            child: _heroIcon(
              Icons.arrow_back,
              'Back',
              () => Navigator.maybePop(context),
            ),
          ),
          Positioned(
            top: 8,
            right: 8,
            child: _heroIcon(Icons.favorite_border, 'Favorite', () {}),
          ),
          Positioned(
            bottom: 9,
            left: 0,
            right: 0,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: List.generate(
                _heroImages.length,
                (index) => Container(
                  width: index == _heroPage ? 18 : 5,
                  height: 4,
                  margin: const EdgeInsets.symmetric(horizontal: 3),
                  decoration: BoxDecoration(
                    color: index == _heroPage ? _orange : Colors.white70,
                    borderRadius: BorderRadius.circular(4),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _heroIcon(IconData icon, String label, VoidCallback onPressed) {
    return Material(
      color: Colors.black.withValues(alpha: 0.2),
      shape: const CircleBorder(),
      child: IconButton(
        tooltip: label,
        onPressed: onPressed,
        icon: Icon(icon, color: Colors.white, size: 19),
        constraints: const BoxConstraints.tightFor(width: 34, height: 34),
        padding: EdgeInsets.zero,
      ),
    );
  }

  Widget _buildShopSummary() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(14, 12, 14, 4),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Barbarella Inova',
                  style: GoogleFonts.poppins(
                    fontSize: 17,
                    fontWeight: FontWeight.w700,
                    color: _ink,
                  ),
                ),
                const SizedBox(height: 4),
                _detailLine(
                  Icons.location_on,
                  '6993 Meadow Valley Terrace, New York',
                ),
                const SizedBox(height: 2),
                _detailLine(Icons.star, '4.8 (3,279 reviews)', star: true),
              ],
            ),
          ),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
            decoration: BoxDecoration(
              color: _orange,
              borderRadius: BorderRadius.circular(15),
            ),
            child: Text(
              'Open',
              style: GoogleFonts.poppins(
                color: Colors.white,
                fontSize: 10,
                fontWeight: FontWeight.w600,
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

  Widget _buildQuickActions() {
    const actions = [
      (Icons.language, 'Website'),
      (Icons.chat_bubble, 'Message'),
      (Icons.phone, 'Call'),
      (Icons.location_on, 'Direction'),
      (Icons.send, 'Share'),
    ];

    return Padding(
      padding: const EdgeInsets.fromLTRB(10, 12, 10, 13),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: actions
            .map(
              (action) => Column(
                children: [
                  Container(
                    width: 36,
                    height: 36,
                    decoration: const BoxDecoration(
                      color: Color(0xFFFFF4E2),
                      shape: BoxShape.circle,
                    ),
                    child: Icon(action.$1, size: 16, color: _orange),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    action.$2,
                    style: GoogleFonts.poppins(
                      fontSize: 8.5,
                      color: _ink,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ),
            )
            .toList(),
      ),
    );
  }

  Widget _buildSpecialists() {
    const specialists = [
      ('assets/images/haircut.jpg', 'Nathan', 'Sr. Barber'),
      ('assets/images/haircut2.jpg', 'Jenny', 'Hair Stylist'),
      ('assets/images/haircut3.jpg', 'Sarah', 'Makeup Artist'),
      ('assets/images/haircut.jpg', 'Mike', 'Sr. Barber'),
    ];

    return SectionDetails(
      title: 'Our Specialist',
      action: 'See All',
      child: SizedBox(
        height: 83,
        child: ListView.separated(
          scrollDirection: Axis.horizontal,
          itemCount: specialists.length,
          separatorBuilder: (_, _) => const SizedBox(width: 10),
          itemBuilder: (context, index) {
            final specialist = specialists[index];
            return SizedBox(
              width: 54,
              child: Column(
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(11),
                    child: Image.asset(
                      specialist.$1,
                      width: 47,
                      height: 47,
                      fit: BoxFit.cover,
                    ),
                  ),
                  const SizedBox(height: 3),
                  Text(
                    specialist.$2,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: GoogleFonts.poppins(fontSize: 8, color: _ink),
                  ),
                  Text(
                    specialist.$3,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: GoogleFonts.poppins(fontSize: 6.5, color: _muted),
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }

  Widget _buildTabs() {
    const tabs = ['About us', 'Services', 'Package', 'Gallery', 'Review'];
    return Padding(
      padding: const EdgeInsets.fromLTRB(14, 11, 14, 10),
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Row(
          children: tabs.asMap().entries.map((entry) {
            final selected = _selectedTab == entry.key;
            return Padding(
              padding: const EdgeInsets.only(right: 7),
              child: OutlinedButton(
                onPressed: () => setState(() => _selectedTab = entry.key),
                style: OutlinedButton.styleFrom(
                  minimumSize: const Size(0, 28),
                  padding: const EdgeInsets.symmetric(horizontal: 11),
                  side: BorderSide(color: _orange, width: selected ? 0 : 1),
                  backgroundColor: selected ? _orange : Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15),
                  ),
                ),
                child: Text(
                  entry.value,
                  style: GoogleFonts.poppins(
                    color: selected ? Colors.white : _orange,
                    fontSize: 9,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            );
          }).toList(),
        ),
      ),
    );
  }

  Widget _buildSelectedTabContent() {
    if (_selectedTab == 1) {
      return ServicesDetailsTab();
    }
    if (_selectedTab == 2) {
      return PackageDetailsTab();
    }
    if (_selectedTab == 3) {
      return GalleryDetailsTab();
    }
    if (_selectedTab == 4) {
      return ReviewDetailsTab();
    }

    return AboutUsDetailsTab();
  }
}
