import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:barber_shops/widgets/shop_card.dart';

const Color _bookmarkOrange = Color(0xFFFF9800);
const Color _bookmarkInk = Color(0xFF1A1A2E);

class BookmarkScreen extends StatefulWidget {
  const BookmarkScreen({
    super.key,
    required this.shops,
    required this.bookmarkedIds,
    required this.onBookmarksChanged,
  });

  final List<ShopCardData> shops;
  final Set<String> bookmarkedIds;
  final ValueChanged<Set<String>> onBookmarksChanged;

  @override
  State<BookmarkScreen> createState() => _BookmarkScreenState();
}

class _BookmarkScreenState extends State<BookmarkScreen> {
  static const List<String> _filters = [
    'All',
    'Haircuts',
    'Make up',
    'Manicure',
  ];

  int _selectedFilter = 0;

  @override
  Widget build(BuildContext context) {
    final visibleShops = widget.shops.where((shop) {
      final matchesFilter =
          _selectedFilter == 0 || shop.category == _filters[_selectedFilter];
      return matchesFilter && widget.bookmarkedIds.contains(shop.id);
    }).toList();

    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: ListView(
          padding: const EdgeInsets.fromLTRB(20, 16, 0, 24),
          children: [
            Padding(
              padding: const EdgeInsets.only(right: 20),
              child: Row(
                children: [
                  IconButton(
                    padding: EdgeInsets.zero,
                    constraints: const BoxConstraints(),
                    icon: const Icon(Icons.arrow_back, size: 24),
                    onPressed: () => Navigator.maybePop(context),
                  ),
                  const SizedBox(width: 16),
                  Text(
                    'My Bookmark',
                    style: GoogleFonts.poppins(
                      fontSize: 20,
                      fontWeight: FontWeight.w700,
                      color: _bookmarkInk,
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
                      child: Icon(Icons.more_horiz, size: 14),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 24),
            SizedBox(
              height: 34,
              child: ListView.separated(
                scrollDirection: Axis.horizontal,
                itemCount: _filters.length,
                separatorBuilder: (_, _) => const SizedBox(width: 10),
                itemBuilder: (context, index) {
                  final selected = index == _selectedFilter;
                  return GestureDetector(
                    onTap: () => setState(() => _selectedFilter = index),
                    child: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                        color: selected ? _bookmarkOrange : Colors.white,
                        border: Border.all(
                          color: _bookmarkOrange,
                          width: selected ? 0 : 1.5,
                        ),
                        borderRadius: BorderRadius.circular(18),
                      ),
                      child: Text(
                        _filters[index],
                        style: GoogleFonts.poppins(
                          fontSize: 12,
                          fontWeight: FontWeight.w500,
                          color: selected ? Colors.white : _bookmarkOrange,
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
            const SizedBox(height: 28),
            for (final shop in visibleShops) ...[
              Padding(
                padding: const EdgeInsets.only(right: 20),
                child: _buildShopCard(shop),
              ),
              const SizedBox(height: 14),
            ],
          ],
        ),
      ),
    );
  }

  Widget _buildShopCard(ShopCardData shop) {
    return ShopCard(
      shop: shop,
      isBookmarked: true,
      onBookmarkPressed: () {
        setState(() => widget.bookmarkedIds.remove(shop.id));
        widget.onBookmarksChanged({...widget.bookmarkedIds});
      },
    );
  }
}
