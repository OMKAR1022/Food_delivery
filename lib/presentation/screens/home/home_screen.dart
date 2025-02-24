import 'package:flutter/material.dart';

import 'package:shared_preferences/shared_preferences.dart';
import '../auth/login_screen.dart';
import '../search/search_screen.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  Future<void> _handleLogout(BuildContext context) async {
    try {
      final prefs = await SharedPreferences.getInstance();
      await prefs.setBool('isLoggedIn', false);

      if (context.mounted) {
        Navigator.of(context).pushAndRemoveUntil(
          MaterialPageRoute(builder: (context) => const LoginScreen()),
              (route) => false,
        );
      }
    } catch (e) {
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Error logging out. Please try again.'),
            backgroundColor: Colors.red,
          ),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            // Header
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      IconButton(
                        icon: const Icon(Icons.menu),
                        onPressed: () {
                          // TODO: Implement menu
                        },
                      ),
                      const Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'DELIVER TO',
                              style: TextStyle(
                                color: Colors.deepOrange,
                                fontSize: 12,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                            Row(
                              children: [
                                Text(
                                  'Halal Lab office',
                                  style: TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                                Icon(
                                  Icons.keyboard_arrow_down,
                                  size: 20,
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                      Stack(
                        children: [
                          IconButton(
                            icon: const Icon(Icons.shopping_bag_outlined),
                            onPressed: () {
                              // TODO: Navigate to cart
                            },
                          ),
                          Positioned(
                            right: 8,
                            top: 8,
                            child: Container(
                              padding: const EdgeInsets.all(4),
                              decoration: const BoxDecoration(
                                color: Colors.deepOrange,
                                shape: BoxShape.circle,
                              ),
                              child: const Text(
                                '2',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 12,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),
                  const Text(
                    'Hey Halal, Good Afternoon!',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 16),
                  TextField(
                    readOnly: true, // Make it non-editable
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const SearchScreen(),
                        ),
                      );
                    },
                    decoration: InputDecoration(
                      hintText: 'Search dishes, restaurants',
                      hintStyle: TextStyle(color: Colors.grey[400]),
                      prefixIcon: const Icon(Icons.search),
                      filled: true,
                      fillColor: Colors.grey[100],
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                        borderSide: BorderSide.none,
                      ),
                    ),
                  ),
                ],
              ),
            ),

            // Categories
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    'All Categories',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  TextButton(
                    onPressed: () {
                      // TODO: Navigate to all categories
                    },
                    child: const Text(
                      'See All',
                      style: TextStyle(
                        color: Colors.deepOrange,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 160,
              child: ListView(
                scrollDirection: Axis.horizontal,
                padding: const EdgeInsets.symmetric(horizontal: 16),
                children: const [
                  _CategoryCard(
                    image: 'assets/images/pizza.jpg',
                    name: 'Pizza',
                    price: 70,
                  ),
                  SizedBox(width: 16),
                  _CategoryCard(
                    image: 'assets/images/burger1.png',
                    name: 'Burger',
                    price: 50,
                  ),
                  SizedBox(width: 16),
                  _CategoryCard(
                    image: 'assets/images/pride1.png',
                    name: 'Pide',
                    price: 60,
                  ),
                  _CategoryCard(
                    image: 'assets/images/pizza.jpg',
                    name: 'Pizza',
                    price: 70,
                  ),
                ],
              ),
            ),

            // Restaurants
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    'Open Restaurants',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  TextButton(
                    onPressed: () {
                      // TODO: Navigate to all restaurants
                    },
                    child: const Text(
                      'See All',
                      style: TextStyle(
                        color: Colors.deepOrange,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
              child: ListView(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                children: const [
                  _RestaurantCard(
                    image: 'assets/images/grid_1.png',
                    name: 'Rose Garden Restaurant',
                    categories: 'Burger - Chiken - Riche - Wings',
                    rating: 4.7,
                    deliveryTime: '20 min',
                    isFreeDelivery: true,
                  ),
                  SizedBox(height: 16),
                  _RestaurantCard(
                    image: 'assets/images/grid_1.png',
                    name: 'Rose Garden Restaurant',
                    categories: 'Burger - Chiken - Riche - Wings',
                    rating: 4.7,
                    deliveryTime: '20 min',
                    isFreeDelivery: true,
                  ),
                  // Add more restaurant cards here
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _CategoryCard extends StatelessWidget {
  final String image;
  final String name;
  final int price;

  const _CategoryCard({
    required this.image,
    required this.name,
    required this.price,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          width: 100,
          height: 100,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: Colors.grey[100],
          ),
          child: ClipOval(
            child: Image.asset(
              image,
              fit: BoxFit.cover,
            ),
          ),
        ),
        const SizedBox(height: 8),
        Text(
          name,
          style: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w500,
          ),
        ),
        Text(
          'Starting \$$price',
          style: TextStyle(
            fontSize: 14,
            color: Colors.grey[600],
          ),
        ),
      ],
    );
  }
}

class _RestaurantCard extends StatelessWidget {
  final String image;
  final String name;
  final String categories;
  final double rating;
  final String deliveryTime;
  final bool isFreeDelivery;

  const _RestaurantCard({
    required this.image,
    required this.name,
    required this.categories,
    required this.rating,
    required this.deliveryTime,
    required this.isFreeDelivery,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ClipRRect(
            borderRadius: const BorderRadius.vertical(top: Radius.circular(12)),
            child: Image.asset(
              image,
              height: 150,
              width: double.infinity,
              fit: BoxFit.cover,
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(12),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  name,
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  categories,
                  style: TextStyle(
                    fontSize: 14,
                    color: Colors.grey[600],
                  ),
                ),
                const SizedBox(height: 8),
                Row(
                  children: [
                    const Icon(
                      Icons.star,
                      color: Colors.amber,
                      size: 20,
                    ),
                    const SizedBox(width: 4),
                    Text(
                      rating.toString(),
                      style: const TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    const SizedBox(width: 16),
                    if (isFreeDelivery) ...[
                      const Icon(
                        Icons.delivery_dining,
                        color: Colors.deepOrange,
                        size: 20,
                      ),
                      const SizedBox(width: 4),
                      const Text(
                        'Free',
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w500,
                          color: Colors.deepOrange,
                        ),
                      ),
                    ],
                    const SizedBox(width: 16),
                    const Icon(
                      Icons.access_time,
                      color: Colors.grey,
                      size: 20,
                    ),
                    const SizedBox(width: 4),
                    Text(
                      deliveryTime,
                      style: const TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

