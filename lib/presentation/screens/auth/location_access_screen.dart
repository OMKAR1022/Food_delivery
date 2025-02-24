import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import '../home/home_screen.dart';

class LocationAccessScreen extends StatelessWidget {
  const LocationAccessScreen({super.key});

  Future<void> _handleLocationAccess(BuildContext context) async {
    try {
      // First check if location services are enabled
      bool serviceEnabled = await Geolocator.isLocationServiceEnabled();
      if (!serviceEnabled) {
        if (context.mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text(
                'Error accessing location: Location services are not enabled',
                style: TextStyle(color: Colors.white),
              ),
              backgroundColor: Color(0xFFFF4343), // Red color from error message
            ),
          );
        }
        return;
      }

      // Check if we already have permission
      LocationPermission permission = await Geolocator.checkPermission();

      if (permission == LocationPermission.denied) {
        // Request permission
        permission = await Geolocator.requestPermission();

        if (permission == LocationPermission.denied) {
          if (context.mounted) {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                content: Text(
                  'Error accessing location: Location permission denied',
                  style: TextStyle(color: Colors.white),
                ),
                backgroundColor: Color(0xFFFF4343),
              ),
            );
          }
          return;
        }
      }

      if (permission == LocationPermission.deniedForever) {
        if (context.mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text(
                'Error accessing location: Location permissions are permanently denied',
                style: TextStyle(color: Colors.white),
              ),
              backgroundColor: Color(0xFFFF4343),
            ),
          );
        }
        return;
      }

      // Permission granted, navigate to home screen
      if (context.mounted) {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => const HomeScreen()),
        );
      }
    } catch (e) {
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(
              'Error accessing location: ${e.toString()}',
              style: const TextStyle(color: Colors.white),
            ),
            backgroundColor: const Color(0xFFFF4343),
          ),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async => false,
      child: Scaffold(
        backgroundColor: Colors.white,
        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // Star/compass illustration
                Container(
                  width: 200,
                  height: 200,
                  decoration: BoxDecoration(
                    color: Colors.grey[50],
                    shape: BoxShape.circle,
                  ),

                ),
                const SizedBox(height: 40),
                SizedBox(
                  width: double.infinity,
                  height: 56,
                  child: ElevatedButton.icon(
                    onPressed: () => _handleLocationAccess(context),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFFFF5722), // Deep Orange
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(16),
                      ),
                      elevation: 0,
                    ),
                    icon: const Icon(
                      Icons.location_on_outlined,
                      color: Colors.white,
                    ),
                    label: const Text(
                      'ACCESS LOCATION',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                        letterSpacing: 1,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 16),
                Text(
                  'DFOOD WILL ACCESS YOUR LOCATION\nONLY WHILE USING THE APP',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 12,
                    color: Colors.grey[600],
                    height: 1.5,
                    letterSpacing: 0.5,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}


