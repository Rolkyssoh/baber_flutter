import 'package:barber_shops/model_service/shop_model.dart';
import 'package:barber_shops/views-model/shop_view_model.dart';
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

  int _nearbyFilter = 0;
  int _popularFilter = 0;
  int _navIndex = 0;
  bool _showOnlyFavorites = false;
  final Set<String> _bookmarkedShopIds = {};

  @override
  void initState() {
    debugPrint('HomeScreen initState called');
    super.initState();
    viewModel.addListener(_onShopViewModelChanged);
    viewModel.fetchShopData();
  }

  void _onShopViewModelChanged() {
    if (mounted) {
      setState(() {});
    }
  }

  @override
  void dispose() {
    viewModel.removeListener(_onShopViewModelChanged);
    viewModel.dispose();
    super.dispose();
  }

  static const List<String> _filters = [
    'All',
    'Haircuts',
    'Make up',
    'Manicure',
  ];

  // static final List<_Shop> _nearbyShops = viewModel.shop.map((shop) {
  //   return _Shop(
  //     name: shop.name,
  //     address: shop.address,
  //     distance: '1.2 km', // Placeholder value
  //     rating: '4.8', // Placeholder value
  //     category: "shop.category",
  //     image: 'assets/images/haircut.jpg', // Placeholder value
  //   );
  // }).toList();

  // static const List<_Shop> _nearbyShops = [
  //   _Shop(
  //     name: 'Belle Curls',
  //     address: '0993 Novick Parkway',
  //     distance: '1.2 km',
  //     rating: '4.8',
  //     category: 'Haircuts',
  //     image: 'assets/images/haircut.jpg',
  //   ),
  //   _Shop(
  //     name: 'Pretty Parlor',
  //     address: '42 Fordem Avenue',
  //     distance: '1.4 km',
  //     rating: '4.9',
  //     category: 'Make up',
  //     image: 'assets/images/haircut2.jpg',
  //   ),
  //   _Shop(
  //     name: 'Mia Bella',
  //     address: '57 Superior Trail',
  //     distance: '1.7 km',
  //     rating: '4.1',
  //     category: 'Manicure',
  //     image: 'assets/images/haircut3.jpg',
  //   ),
  // ];

  static const List<_Shop> _popularShops = [
    _Shop(
      id: 'popular-hair-force',
      name: 'Hair Force',
      address: '813 Village Drive',
      distance: '3.4 km',
      rating: '4.6',
      category: 'Haircuts',
      image: 'assets/images/haircut2.jpg',
    ),
    _Shop(
      id: 'popular-serenity-salon',
      name: 'Serenity Salon',
      address: '88 Commercial Plaza',
      distance: '4.2 km',
      rating: '4.0',
      category: 'Make up',
      image: 'assets/images/haircut3.jpg',
    ),
    _Shop(
      id: 'popular-razors-edge',
      name: "The Razor's Edge",
      address: '54 Artisan Avenue',
      distance: '4.5 km',
      rating: '4.6',
      category: 'Haircuts',
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
              category: 'Haircuts',
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
            _buildCategories(),
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
          print("Pour les notif");
        }),
        const SizedBox(width: 6),
        _iconButton(
          _showOnlyFavorites ? Icons.bookmark : Icons.bookmark_border,
          _showOnlyFavorites
              ? 'Afficher tous les shops'
              : 'Filtrer par favoris',
          () {
            setState(() {
              _showOnlyFavorites = !_showOnlyFavorites;
            });
          },
        ),
      ],
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
  Widget _buildCategories() {
    const categories = [
      (Icons.content_cut, 'Haircuts'),
      (Icons.face_retouching_natural, 'Make up'),
      (Icons.spa, 'Manicure'),
      (Icons.self_improvement, 'Massage'),
    ];

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: categories
          .map(
            (c) => Column(
              children: [
                Container(
                  width: 62,
                  height: 62,
                  decoration: BoxDecoration(
                    color: const Color(0xFFFFF3E0),
                    shape: BoxShape.circle,
                  ),
                  child: Icon(c.$1, color: _primary, size: 26),
                ),
                const SizedBox(height: 8),
                Text(
                  c.$2,
                  style: GoogleFonts.poppins(
                    fontSize: 12,
                    fontWeight: FontWeight.w500,
                    color: _ink,
                  ),
                ),
              ],
            ),
          )
          .toList(),
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
        separatorBuilder: (_, __) => const SizedBox(width: 8),
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
    final imageUrl = shop.image.startsWith('/')
        ? 'http://10.0.2.2:4200${shop.image}'
        : shop.image;
    final isBookmarked = _bookmarkedShopIds.contains(shop.id);

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
                    errorBuilder: (context, error, stackTrace) => Container(
                      width: 64,
                      height: 64,
                      color: Colors.grey[200],
                      child: const Icon(Icons.image, color: Colors.grey),
                    ),
                  )
                : Image.asset(
                    imageUrl,
                    width: 64,
                    height: 64,
                    fit: BoxFit.cover,
                    errorBuilder: (context, error, stackTrace) => Container(
                      width: 64,
                      height: 64,
                      color: Colors.grey[200],
                      child: const Icon(Icons.image, color: Colors.grey),
                    ),
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
                    color: _ink,
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
                      color: _primary,
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
                        color: _ink,
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
            onPressed: () {
              setState(() {
                if (isBookmarked) {
                  _bookmarkedShopIds.remove(shop.id);
                } else {
                  _bookmarkedShopIds.add(shop.id);
                }
              });
            },
            icon: Icon(
              isBookmarked ? Icons.bookmark : Icons.bookmark_border,
              color: isBookmarked ? _primary : _ink,
              size: 22,
            ),
          ),
        ],
      ),
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
    return shops.where((s) => s.category == filter).toList();
  }

  List<_Shop> _filterVisibleShops(List<_Shop> shops, int filterIndex) {
    var filteredShops = _filterShops(shops, filterIndex);

    if (_showOnlyFavorites) {
      filteredShops = filteredShops
          .where((shop) => _bookmarkedShopIds.contains(shop.id))
          .toList();
    }

    return filteredShops;
  }
}

class _Shop {
  final String id;
  final String name;
  final String address;
  final String distance;
  final String rating;
  final String category;
  final String image;

  const _Shop({
    required this.id,
    required this.name,
    required this.address,
    required this.distance,
    required this.rating,
    required this.category,
    required this.image,
  });
}
