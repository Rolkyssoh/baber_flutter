import 'package:barber_shops/dto/sho.dart';
import 'package:barber_shops/model_service/shop_model.dart';
import 'package:barber_shops/model_service/shop_provided_services.model.dart';
import 'package:barber_shops/screens/bookmark_screen.dart';
import 'package:barber_shops/screens/notification_screen.dart';
import 'package:barber_shops/views-model/shop_provided_services.view-model.dart';
import 'package:barber_shops/views-model/shop_view_model.dart';
import 'package:barber_shops/widgets/shop_card.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

// ──────────────────────────────────────────────
//  Palette
// ──────────────────────────────────────────────
const Color _primary = Color(0xFFFF9800);
const Color _primaryDark = Color(0xFFFF6F00);
const Color _ink = Color(0xFF1A1A2E);

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final ShopViewModel viewModel = ShopViewModel(ShopModel());
  final ShopProvidedServicesViewModel servicesViewModel =
      ShopProvidedServicesViewModel(ShopProvidedServicesModel());

  int _nearbyFilter = 0;
  int _popularFilter = 0;
  int _navIndex = 0;
  final Set<String> _bookmarkedShopIds = {};

  @override
  void initState() {
    debugPrint('HomeScreen initState called');
    super.initState();
    viewModel.addListener(_onViewModelChanged);
    viewModel.fetchShopData();
    servicesViewModel.addListener(_onViewModelChanged);
    servicesViewModel.fetchPrincipalServices();
  }

  void _onViewModelChanged() {
    if (mounted) {
      setState(() {});
    }
  }

  @override
  void dispose() {
    viewModel.removeListener(_onViewModelChanged);
    viewModel.dispose();
    servicesViewModel.dispose();
    super.dispose();
  }

  List<String> get _filters => [
    'All',
    ...servicesViewModel.services.map((service) => service.label),
  ];

  static const List<_Shop> _popularShops = [
    _Shop(
      id: 'popular-hair-force',
      name: 'Hair Force',
      address: '813 Village Drive',
      distance: '3.4 km',
      rating: '4.6',
      categories: ['Coiffure'],
      image: 'assets/images/haircut2.jpg',
    ),
    _Shop(
      id: 'popular-serenity-salon',
      name: 'Serenity Salon',
      address: '88 Commercial Plaza',
      distance: '4.2 km',
      rating: '4.0',
      categories: ['Esthétique'],
      image: 'assets/images/haircut3.jpg',
    ),
    _Shop(
      id: 'popular-razors-edge',
      name: "The Razor's Edge",
      address: '54 Artisan Avenue',
      distance: '4.5 km',
      rating: '4.6',
      categories: ['Onglerie'],
      image: 'assets/images/haircut.jpg',
    ),
  ];

  @override
  Widget build(BuildContext context) {
    final nearbyShops = _filterVisibleShops(
      viewModel.shop
          .map(
            (shop) => _Shop(
              id: shop.id,
              name: shop.name,
              address: shop.address,
              distance: '1.2 km',
              rating: '4.8',
              categories: shop.barber_shop_service
                  .map((service) => service.label)
                  .toList(),
              image: shop.profileImage,
            ),
          )
          .toList(),
      _nearbyFilter,
    );

    final popularShops = _filterVisibleShops(_popularShops, _popularFilter);

    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: ListView(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          children: [
            const SizedBox(height: 8),
            _buildHeader(),
            const SizedBox(height: 20),
            _buildGreeting(),
            const SizedBox(height: 18),
            _buildSearchBar(),
            const SizedBox(height: 18),
            _buildBanner(),
            const SizedBox(height: 22),
            _buildCategories(
              servicesViewModel.services
                  .map((service) => service.label)
                  .toList(),
            ),
            const SizedBox(height: 24),
            _buildSectionTitle('Nearby Your Location'),
            const SizedBox(height: 14),
            _buildFilterChips(
              selectedIndex: _nearbyFilter,
              onSelected: (i) => setState(() => _nearbyFilter = i),
            ),
            const SizedBox(height: 16),
            ...nearbyShops.map(
              (shop) => Padding(
                padding: const EdgeInsets.only(bottom: 14),
                child: _buildShopCard(shop),
              ),
            ),
            const SizedBox(height: 10),
            _buildSectionTitle('Most Popular'),
            const SizedBox(height: 14),
            _buildFilterChips(
              selectedIndex: _popularFilter,
              onSelected: (i) => setState(() => _popularFilter = i),
            ),
            const SizedBox(height: 16),
            ...popularShops.map(
              (shop) => Padding(
                padding: const EdgeInsets.only(bottom: 14),
                child: _buildShopCard(shop),
              ),
            ),
            const SizedBox(height: 20),
          ],
        ),
      ),
      bottomNavigationBar: _buildBottomNav(),
    );
  }

  // ── Header: logo + actions ──────────────────────────────
  Widget _buildHeader() {
    return Row(
      children: [
        Container(
          width: 40,
          height: 40,
          decoration: const BoxDecoration(
            color: _primary,
            shape: BoxShape.circle,
          ),
          child: Center(
            child: Text(
              'C',
              style: GoogleFonts.poppins(
                fontSize: 22,
                fontWeight: FontWeight.w800,
                color: Colors.white,
              ),
            ),
          ),
        ),
        const SizedBox(width: 10),
        Text(
          'Casca',
          style: GoogleFonts.poppins(
            fontSize: 22,
            fontWeight: FontWeight.w700,
            color: _ink,
          ),
        ),
        const Spacer(),
        _iconButton(Icons.notifications_none, 'Voir notifications', () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (_) => const NotificationScreen()),
          );
        }),
        const SizedBox(width: 6),
        _iconButton(Icons.bookmark_border, 'Voir mes favoris', _openBookmarks),
      ],
    );
  }

  void _openBookmarks() {
    final shopsById = <String, ShopCardData>{
      for (final shop in viewModel.shop.map(_shopFromApi)) shop.id: shop,
      for (final shop in _popularShops.map(_shopFromLocal)) shop.id: shop,
    };

    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => BookmarkScreen(
          shops: shopsById.values.toList(),
          bookmarkedIds: _bookmarkedShopIds,
          categories: _filters,
          onBookmarksChanged: (bookmarkedIds) {
            setState(() {
              _bookmarkedShopIds
                ..clear()
                ..addAll(bookmarkedIds);
            });
          },
        ),
      ),
    );
  }

  ShopCardData _shopFromApi(Shop shop) {
    return ShopCardData(
      id: shop.id,
      name: shop.name,
      address: shop.address,
      distance: '1.2 km',
      rating: '4.8',
      categories: shop.barber_shop_service
          .map((service) => service.label)
          .toList(),
      image: shop.profileImage,
    );
  }

  ShopCardData _shopFromLocal(_Shop shop) {
    return ShopCardData(
      id: shop.id,
      name: shop.name,
      address: shop.address,
      distance: shop.distance,
      rating: shop.rating,
      categories: shop.categories,
      image: shop.image,
    );
  }

  Widget _iconButton(IconData icon, String tooltip, VoidCallback pressed) {
    return Container(
      width: 42,
      height: 42,
      decoration: BoxDecoration(
        color: Colors.grey[100],
        shape: BoxShape.circle,
      ),
      // child: Icon(icon, color: _ink, size: 22),
      child: IconButton(
        tooltip: tooltip,
        onPressed: pressed,
        icon: Icon(icon, color: _ink, size: 22),
      ),
    );
  }

  // ── Greeting ────────────────────────────────────────────
  Widget _buildGreeting() {
    return Text(
      'Morning, Daniel 👋',
      style: GoogleFonts.poppins(
        fontSize: 22,
        fontWeight: FontWeight.w700,
        color: _ink,
      ),
    );
  }

  // ── Search bar ──────────────────────────────────────────
  Widget _buildSearchBar() {
    return Container(
      height: 52,
      padding: const EdgeInsets.symmetric(horizontal: 16),
      decoration: BoxDecoration(
        color: const Color(0xFFF5F5F5),
        borderRadius: BorderRadius.circular(14),
      ),
      child: Row(
        children: [
          const Icon(Icons.search, color: Colors.grey, size: 22),
          const SizedBox(width: 10),
          Expanded(
            child: Text(
              'Search',
              style: GoogleFonts.poppins(fontSize: 14, color: Colors.grey[500]),
            ),
          ),
          Container(
            width: 38,
            height: 38,
            decoration: BoxDecoration(
              color: _primary,
              borderRadius: BorderRadius.circular(10),
            ),
            child: const Icon(Icons.tune, color: Colors.white, size: 20),
          ),
        ],
      ),
    );
  }

  // ── Banner ──────────────────────────────────────────────
  Widget _buildBanner() {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [_primaryDark, _primary],
        ),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 10,
                        vertical: 4,
                      ),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Text(
                        '30% OFF',
                        style: GoogleFonts.poppins(
                          fontSize: 12,
                          fontWeight: FontWeight.w700,
                          color: _primaryDark,
                        ),
                      ),
                    ),
                    const SizedBox(height: 10),
                    Text(
                      "Today's Special",
                      style: GoogleFonts.poppins(
                        fontSize: 20,
                        fontWeight: FontWeight.w700,
                        color: Colors.white,
                      ),
                    ),
                    const SizedBox(height: 6),
                    Text(
                      'Get a discount for every service order!',
                      style: GoogleFonts.poppins(
                        fontSize: 12,
                        color: Colors.white.withValues(alpha: 0.9),
                      ),
                    ),
                    const SizedBox(height: 12),
                    Text(
                      'Only valid for today!',
                      style: GoogleFonts.poppins(
                        fontSize: 12,
                        fontWeight: FontWeight.w600,
                        color: Colors.white,
                      ),
                    ),
                  ],
                ),
              ),
              Text(
                '30%',
                style: GoogleFonts.poppins(
                  fontSize: 34,
                  fontWeight: FontWeight.w800,
                  color: Colors.white,
                  height: 1.0,
                ),
              ),
            ],
          ),
          const SizedBox(height: 18),
          Row(
            children: [
              _dots(),
              const Spacer(),
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 14,
                  vertical: 8,
                ),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      'Book Now',
                      style: GoogleFonts.poppins(
                        fontSize: 12,
                        fontWeight: FontWeight.w600,
                        color: _primaryDark,
                      ),
                    ),
                    const SizedBox(width: 6),
                    const Icon(
                      Icons.arrow_forward,
                      size: 14,
                      color: _primaryDark,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _dots() {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: List.generate(
        3,
        (i) => Container(
          width: 6,
          height: 6,
          margin: const EdgeInsets.only(right: 5),
          decoration: BoxDecoration(
            color: i == 0 ? Colors.white : Colors.white.withValues(alpha: 0.5),
            shape: BoxShape.circle,
          ),
        ),
      ),
    );
  }

  // ── Categories ──────────────────────────────────────────
  Widget _buildCategories(List<String> categoriesList) {
    const categoryIcons = <String, IconData>{
      'coiffure': Icons.content_cut,
      'onglerie': Icons.brush,
      'massage & spa': Icons.spa,
      'esthetique': Icons.face_retouching_natural,
      'cils & sourcils': Icons.visibility,
      'maquillage': Icons.face,
      'soins capillaires': Icons.face_retouching_natural,
      'beauté du regard': Icons.style,
      'tatouage & piercing': Icons.draw,
      'Bien-être': Icons.self_improvement,
      // 'soins du visage': Icons.face_retouching_natural,
      // 'massage': Icons.self_improvement,
    };

    return SizedBox(
      height: 106,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        itemCount: categoriesList.length,
        separatorBuilder: (_, _) => const SizedBox(width: 12),
        itemBuilder: (context, index) {
          final category = categoriesList[index];
          return SizedBox(
            width: 76,
            child: Column(
              children: [
                Container(
                  width: 62,
                  height: 62,
                  decoration: BoxDecoration(
                    color: const Color(0xFFFFF3E0),
                    shape: BoxShape.circle,
                  ),
                  child: Icon(
                    categoryIcons[category.trim().toLowerCase()] ??
                        Icons.category_outlined,
                    color: _primary,
                    size: 26,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  category,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  textAlign: TextAlign.center,
                  style: GoogleFonts.poppins(
                    fontSize: 12,
                    fontWeight: FontWeight.w500,
                    color: _ink,
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  // ── Section title ───────────────────────────────────────
  Widget _buildSectionTitle(String title) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          title,
          style: GoogleFonts.poppins(
            fontSize: 17,
            fontWeight: FontWeight.w700,
            color: _ink,
          ),
        ),
        Text(
          'See All',
          style: GoogleFonts.poppins(
            fontSize: 13,
            fontWeight: FontWeight.w600,
            color: _primary,
          ),
        ),
      ],
    );
  }

  // ── Filter chips ────────────────────────────────────────
  Widget _buildFilterChips({
    required int selectedIndex,
    required void Function(int) onSelected,
  }) {
    return SizedBox(
      height: 36,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        itemCount: _filters.length,
        separatorBuilder: (_, _) => const SizedBox(width: 8),
        itemBuilder: (context, index) {
          final selected = selectedIndex == index;
          return GestureDetector(
            onTap: () => onSelected(index),
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 200),
              padding: const EdgeInsets.symmetric(horizontal: 18),
              alignment: Alignment.center,
              decoration: BoxDecoration(
                color: selected ? _primary : Colors.grey[100],
                borderRadius: BorderRadius.circular(18),
              ),
              child: Text(
                _filters[index],
                style: GoogleFonts.poppins(
                  fontSize: 13,
                  fontWeight: FontWeight.w500,
                  color: selected ? Colors.white : Colors.grey[600],
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  // ── Shop card ───────────────────────────────────────────
  Widget _buildShopCard(_Shop shop) {
    final isBookmarked = _bookmarkedShopIds.contains(shop.id);

    return ShopCard(
      shop: ShopCardData(
        id: shop.id,
        name: shop.name,
        address: shop.address,
        distance: shop.distance,
        rating: shop.rating,
        categories: shop.categories,
        image: shop.image,
      ),
      isBookmarked: isBookmarked,
      onBookmarkPressed: () {
        setState(() {
          if (isBookmarked) {
            _bookmarkedShopIds.remove(shop.id);
          } else {
            _bookmarkedShopIds.add(shop.id);
          }
        });
      },
    );
  }

  // ── Bottom navigation ───────────────────────────────────
  Widget _buildBottomNav() {
    const items = [
      (Icons.home, 'Home'),
      (Icons.explore_outlined, 'Explore'),
      (Icons.calendar_month_outlined, 'My Booking'),
      (Icons.inbox_outlined, 'Inbox'),
      (Icons.person_outline, 'Profile'),
    ];

    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.06),
            blurRadius: 16,
            offset: const Offset(0, -4),
          ),
        ],
      ),
      child: SafeArea(
        top: false,
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 8),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: List.generate(
              items.length,
              (i) => GestureDetector(
                onTap: () => setState(() => _navIndex = i),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(
                      items[i].$1,
                      size: 24,
                      color: _navIndex == i ? _primary : Colors.grey[400],
                    ),
                    const SizedBox(height: 4),
                    Text(
                      items[i].$2,
                      style: GoogleFonts.poppins(
                        fontSize: 10,
                        fontWeight: FontWeight.w500,
                        color: _navIndex == i ? _primary : Colors.grey[400],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  List<_Shop> _filterShops(List<_Shop> shops, int filterIndex) {
    final filter = _filters[filterIndex];
    if (filter == 'All') return shops;
    return shops.where((s) => s.categories.contains(filter)).toList();
  }

  List<_Shop> _filterVisibleShops(List<_Shop> shops, int filterIndex) {
    return _filterShops(shops, filterIndex);
  }
}

class _Shop {
  final String id;
  final String name;
  final String address;
  final String distance;
  final String rating;
  final String image;
  final List<String> categories;

  const _Shop({
    required this.id,
    required this.name,
    required this.address,
    required this.distance,
    required this.rating,
    required this.image,
    required this.categories,
  });
}
