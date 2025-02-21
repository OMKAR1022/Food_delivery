import 'package:flutter/material.dart';

class OnboardingSecond extends StatelessWidget {
  const OnboardingSecond({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Stack(
          alignment: Alignment.center,
          children: [
            Container(
              width: 280,
              height: 280,
              decoration: BoxDecoration(
                color: Colors.orange.shade50,
                shape: BoxShape.circle,
              ),
            ),
            Image.network(
              'https://hebbkx1anhila5yf.public.blob.vercel-storage.com/Onboarding_03-PhMMLh4ZjyHRQueIA206Xp2xqYtU55.png',
              width: 240,
              height: 240,
              fit: BoxFit.contain,
            ),
          ],
        ),
        const SizedBox(height: 40),
        const Text(
          'Order from chosen chef',
          style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
            color: Colors.black87,
          ),
        ),
        const SizedBox(height: 16),
        const Text(
          'Get all your loved foods in one once place,\nyou just place the order we do the rest',
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: 16,
            color: Colors.grey,
            height: 1.5,
          ),
        ),
      ],
    );
  }
}

