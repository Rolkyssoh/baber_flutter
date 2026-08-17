import 'package:flutter/material.dart';
import 'onboarding_screen.dart';

class WelcomScreen extends StatelessWidget {
  const WelcomScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      body: Stack(
        fit: StackFit.expand,
        children: [
          // 1. Image de fond en plein écran
          Image.asset("assets/images/haircut.jpg", fit: BoxFit.cover),

          // 2. Dégradé sombre en bas pour que le texte reste lisible
          Container(
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  Colors.transparent,
                  Colors.transparent,
                  Colors.black87,
                ],
                stops: [0.0, 0.55, 1.0],
              ),
            ),
          ),

          // 3. Contenu texte + bouton, aligné en bas
          SafeArea(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Row(
                    children: [
                      Text(
                        'Welcome to',
                        style: TextStyle(
                          fontSize: 30,
                          fontWeight: FontWeight.w800,
                          color: Colors.white,
                        ),
                      ),
                    ],
                  ),
                  const Text(
                    'Casca',
                    style: TextStyle(
                      fontSize: 56,
                      fontWeight: FontWeight.w800,
                      height: 1.0,
                      color: Color(0xFFFF9800),
                    ),
                  ),
                  const SizedBox(height: 12),
                  Text(
                    'The best barber & salon app in this century'
                    'for your good looks and beauty.',
                    style: TextStyle(
                      fontSize: 14,
                      color: Colors.white.withValues(),
                      height: 1.4,
                    ),
                  ),
                  const SizedBox(height: 32),
                  // Bouton "Get Started"
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: () {
                        Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                            builder: (_) => const OnboardingScreen(),
                          ),
                        );
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFFFF9800),
                        foregroundColor: Colors.white,
                        padding: const EdgeInsets.symmetric(vertical: 16),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                      child: const Text(
                        'Get Started',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 16),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
