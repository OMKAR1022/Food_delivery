import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../auth/login_screen.dart';
import '../onboarding/onboarding_screen.dart';
import '../home/home_screen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    _checkAppState();
  }

  Future<void> _checkAppState() async {
    try {
      final prefs = await SharedPreferences.getInstance();

      // Check if user has seen onboarding
      final hasSeenOnboarding = prefs.getBool('hasSeenOnboarding') ?? false;

      // Check if user is logged in
      final isLoggedIn = prefs.getBool('isLoggedIn') ?? false;

      // Short delay for splash screen animation
      await Future.delayed(const Duration(milliseconds: 1000));

      if (!mounted) return;

      if (isLoggedIn) {
        // User is logged in, go directly to home
        Navigator.of(context).pushAndRemoveUntil(
          MaterialPageRoute(builder: (context) => const HomeScreen()),
              (route) => false,
        );
      } else if (!hasSeenOnboarding) {
        // First time user, show onboarding
        await prefs.setBool('hasSeenOnboarding', true);
        if (!mounted) return;
        Navigator.of(context).pushAndRemoveUntil(
          MaterialPageRoute(builder: (context) => const OnboardingScreen()),
              (route) => false,
        );
      } else {
        // Returning user but not logged in
        Navigator.of(context).pushAndRemoveUntil(
          MaterialPageRoute(builder: (context) => const LoginScreen()),
              (route) => false,
        );
      }
    } catch (e) {
      // If there's an error, default to login screen
      if (mounted) {
        Navigator.of(context).pushAndRemoveUntil(
          MaterialPageRoute(builder: (context) => const LoginScreen()),
              (route) => false,
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'F',
              style: TextStyle(
                fontSize: 32,
                fontWeight: FontWeight.bold,
                color: Colors.black.withOpacity(0.8),
              ),
            ),
            Stack(
              alignment: Alignment.center,
              children: [
                Container(
                  width: 32,
                  height: 32,
                  decoration: BoxDecoration(
                    color: Colors.orange,
                    borderRadius: BorderRadius.circular(16),
                  ),
                ),
                Container(
                  width: 20,
                  height: 10,
                  decoration: const BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.vertical(
                      top: Radius.circular(10),
                    ),
                  ),
                ),
              ],
            ),
            Text(
              'od',
              style: TextStyle(
                fontSize: 32,
                fontWeight: FontWeight.bold,
                color: Colors.black.withOpacity(0.8),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

