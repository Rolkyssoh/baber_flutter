import 'package:barber_shops/layouts/more_screen_layout.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

const Color _orange = Color(0xFFFF9800);
const Color _ink = Color(0xFF1F1F1F);
const Color _muted = Color(0xFF8F8F8F);

class ShopServiceList extends StatefulWidget {
  const ShopServiceList({super.key});

  @override
  State<ShopServiceList> createState() => _ServiceListState();
}

class _ServiceListState extends State<ShopServiceList> {
  String selectedGender = 'Man';
  int selectedServiceIndex = 1;

  final List<_ServiceItem> services = const [
    _ServiceItem(
      name: 'Undercut',
      booked: '728 booked',
      price: '\$6.50',
      image: 'assets/images/haircut.jpg',
    ),
    _ServiceItem(
      name: 'Quiff',
      booked: '629 booked',
      price: '\$6.00',
      image: 'assets/images/haircut2.jpg',
    ),
    _ServiceItem(
      name: 'Crew Cut',
      booked: '922 booked',
      price: '\$5.50',
      image: 'assets/images/haircut3.jpg',
    ),
    _ServiceItem(
      name: 'Regular Cut',
      booked: '1029 booked',
      price: '\$5.00',
      image: 'assets/images/haircut.jpg',
    ),
    _ServiceItem(
      name: 'Temple Fade',
      booked: '2000 booked',
      price: '\$6.00',
      image: 'assets/images/haircut2.jpg',
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return MoreScreenLayout(
      title: 'Haircut',
      btnText: 'Apply',
      onBtnPressed: () {},
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Container(
            height: 76,
            padding: const EdgeInsets.all(6),
            decoration: BoxDecoration(
              color: const Color(0xFFF2F2F2),
              borderRadius: BorderRadius.circular(32),
            ),
            child: Row(
              children: [
                _buildGenderTab(
                  'Man',
                  selectedGender == 'Man',
                  () => setState(() => selectedGender = 'Man'),
                ),
                const SizedBox(width: 8),
                _buildGenderTab(
                  'Woman',
                  selectedGender == 'Woman',
                  () => setState(() => selectedGender = 'Woman'),
                ),
              ],
            ),
          ),
          const SizedBox(height: 18),
          ...List.generate(services.length, (index) {
            final item = services[index];
            final isSelected = selectedServiceIndex == index;

            return Padding(
              padding: const EdgeInsets.only(bottom: 14),
              child: GestureDetector(
                onTap: () => setState(() => selectedServiceIndex = index),
                child: AnimatedContainer(
                  duration: const Duration(milliseconds: 180),
                  height: 110,
                  padding: const EdgeInsets.symmetric(
                    horizontal: 12,
                    vertical: 10,
                  ),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    border: Border.all(
                      color: isSelected ? _orange : const Color(0xFFE6E0D8),
                      width: isSelected ? 2.2 : 1.6,
                    ),
                    borderRadius: BorderRadius.circular(26),
                  ),
                  child: Row(
                    children: [
                      ClipRRect(
                        borderRadius: BorderRadius.circular(18),
                        child: Image.asset(
                          item.image,
                          width: 80,
                          height: 80,
                          fit: BoxFit.cover,
                        ),
                      ),
                      const SizedBox(width: 18),
                      Expanded(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              item.name,
                              style: GoogleFonts.autourOne(
                                color: _ink,
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            const SizedBox(height: 4),
                            Text(
                              item.booked,
                              style: GoogleFonts.autourOne(
                                color: _muted,
                                fontSize: 15,
                              ),
                            ),
                            const SizedBox(height: 3),
                            Text(
                              item.price,
                              style: GoogleFonts.autourOne(
                                color: _orange,
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                      ),
                      Container(
                        width: 28,
                        height: 28,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          border: Border.all(
                            color: isSelected
                                ? _orange
                                : const Color(0xFFEBB964),
                            width: 2.5,
                          ),
                          color: isSelected ? _orange : Colors.white,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            );
          }),
          const SizedBox(height: 18),
        ],
      ),
    );
  }

  Widget _buildGenderTab(String label, bool selected, VoidCallback onTap) {
    return Expanded(
      child: GestureDetector(
        onTap: onTap,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 170),
          decoration: BoxDecoration(
            color: selected ? _orange : Colors.white,
            borderRadius: BorderRadius.circular(30),
            border: Border.all(color: _orange, width: 2.0),
          ),
          child: Center(
            child: Text(
              label,
              style: GoogleFonts.autourOne(
                color: selected ? Colors.white : _orange,
                fontSize: 22,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class _ServiceItem {
  const _ServiceItem({
    required this.name,
    required this.booked,
    required this.price,
    required this.image,
  });

  final String name;
  final String booked;
  final String price;
  final String image;
}
