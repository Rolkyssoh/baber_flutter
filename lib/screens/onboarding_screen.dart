import 'package:flutter/material.dart';
import 'authentication/auth_dashboard.dart';

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({super.key});

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  final PageController _pageController = PageController();
  int _currentPage = 0;

  static const List<_OnboardingPage> _pages = [
    _OnboardingPage(
      imagePath: 'assets/images/haircut.jpg',
      title: 'Find Barbers and Salons\nEasily in Your Hands',
      description:
          'Discover the best barbers and salons near you. '
          'Book appointments with just a few taps.',
    ),
    _OnboardingPage(
      imagePath: 'assets/images/haircut2.jpg',
      title: 'Book your Favorite Barber and Salon Quickly',
      description:
          'Browse through portfolios, read reviews, '
          'and pick the perfect barber for your style.',
    ),
    _OnboardingPage(
      imagePath: 'assets/images/haircut3.jpg',
      title: 'Come be handsome and beautiful with us right now!',
      description:
          'Schedule your appointment, get reminders, '
          'and walk out looking your absolute best.',
    ),
  ];

  void _onNextPressed() {
    if (_currentPage < _pages.length - 1) {
      _pageController.nextPage(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
    } else {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (_) => const AuthDashboard()),
      );
    }
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          // Zone image (top ~50% of screen)
          Expanded(
            flex: 5,
            child: PageView.builder(
              controller: _pageController,
              itemCount: _pages.length,
              onPageChanged: (index) {
                setState(() => _currentPage = index);
              },
              itemBuilder: (context, index) {
                return Image.asset(
                  _pages[index].imagePath,
                  fit: BoxFit.cover,
                  width: double.infinity,
                  errorBuilder: (context, error, stackTrace) {
                    return Container(
                      color: Colors.grey[300],
                      child: const Center(
                        child: Icon(Icons.image, size: 64, color: Colors.grey),
                      ),
                    );
                  },
                );
              },
            ),
          ),

          // Zone texte + dots + bouton (bottom ~50%)
          Expanded(
            flex: 5,
            child: Container(
              width: double.infinity,
              padding: const EdgeInsets.symmetric(horizontal: 28, vertical: 32),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Titre
                  Text(
                    _pages[_currentPage].title,
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                      fontSize: 26,
                      fontWeight: FontWeight.w800,
                      height: 1.3,
                      color: Color(0xFF1A1A2E),
                    ),
                  ),
                  const SizedBox(height: 16),

                  // Description
                  Text(
                    _pages[_currentPage].description,
                    style: TextStyle(
                      fontSize: 15,
                      color: Colors.grey[600],
                      height: 1.5,
                    ),
                  ),

                  // Spacer pour pousser dots + bouton vers le bas
                  const Spacer(),

                  // Indicateur de position (dots)
                  Center(
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: List.generate(
                        _pages.length,
                        (index) => AnimatedContainer(
                          duration: const Duration(milliseconds: 250),
                          margin: const EdgeInsets.symmetric(horizontal: 5),
                          width: _currentPage == index ? 28 : 10,
                          height: 10,
                          decoration: BoxDecoration(
                            color: _currentPage == index
                                ? const Color(0xFFFF9800)
                                : Colors.grey[300],
                            borderRadius: BorderRadius.circular(5),
                          ),
                        ),
                      ),
                    ),
                  ),

                  const SizedBox(height: 28),

                  // Bouton Next / Get Started
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: _onNextPressed,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFFFF9800),
                        foregroundColor: Colors.white,
                        padding: const EdgeInsets.symmetric(vertical: 16),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                        elevation: 0,
                      ),
                      child: Text(
                        _currentPage == _pages.length - 1
                            ? 'Get Started'
                            : 'Next',
                        style: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _OnboardingPage {
  final String imagePath;
  final String title;
  final String description;

  const _OnboardingPage({
    required this.imagePath,
    required this.title,
    required this.description,
  });
}
