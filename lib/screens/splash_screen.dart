import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../model_service/session_storage.dart';
import 'hom_screen.dart';
import 'welcom_screen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;

  @override
  void initState() {
    super.initState();

    // Barre de statut sombre (icônes noires) sur fond blanc
    SystemChrome.setSystemUIOverlayStyle(
      const SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
        statusBarIconBrightness: Brightness.dark,
      ),
    );

    // Animation de rotation pour le spinner
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 1),
    )..repeat();

    _redirectAfterSplash();
  }

  Future<void> _redirectAfterSplash() async {
    await Future.delayed(const Duration(seconds: 3));
    final accessToken = await SessionStorage().getAccessToken();

    if (!mounted) return;

    final destination = accessToken != null && accessToken.isNotEmpty
        ? HomeScreen()
        : const WelcomScreen();

    Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(builder: (_) => destination),
      (_) => false,
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Grand "C" orange en cursive
            Text(
              'THE HAIR',
              style: TextStyle(
                fontSize: 70,
                fontWeight: FontWeight.w300,
                fontStyle: FontStyle.italic,
                color: Color(0xFFFF6F00), // Orange
                fontFamily: 'Serif',
              ),
            ),
            SizedBox(height: 40),
            // Spinner orange
            SizedBox(
              width: 36,
              height: 36,
              child: CircularProgressIndicator(
                strokeWidth: 3,
                valueColor: AlwaysStoppedAnimation<Color>(Color(0xFFFF6F00)),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
