import 'package:flutter/material.dart';

import 'package:shared_preferences/shared_preferences.dart';

class SearchScreen extends StatefulWidget {
  final String? initialQuery;

  const SearchScreen({
    super.key,
    this.initialQuery,
  });

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  final TextEditingController _searchController = TextEditingController();
  List<String> _recentKeywords = [];

  @override
  void initState() {
    super.initState();
    _searchController.text = widget.initialQuery ?? '';
    _loadRecentKeywords();
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  Future<void> _loadRecentKeywords() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      setState(() {
        _recentKeywords = prefs.getStringList('recentSearches') ?? [
          'Burger',
          'Sandwich',
          'Pizza',
          'Sanwich',
        ];
      });
    } catch (e) {
      debugPrint('Error loading recent searches: $e');
    }
  }

  Future<void> _saveKeyword(String keyword) async {
    if (keyword.isEmpty) return;

    try {
      final prefs = await SharedPreferences.getInstance();
      final searches = prefs.getStringList('recentSearches') ?? [];

      // Remove if exists and add to front
      searches.remove(keyword);
      searches.insert(0, keyword);

      // Keep only last 10 searches
      if (searches.length > 10) {
        searches.removeLast();
      }

      await prefs.setStringList('recentSearches', searches);
      setState(() {
        _recentKeywords = searches;
      });
    } catch (e) {
      debugPrint('Error saving search: $e');
    }
  }

  void _handleSearch(String query) {
    if (query.isNotEmpty) {
      _saveKeyword(query);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Header
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Row(
                children: [
                  InkWell(
                    onTap: () => Navigator.pop(context),
                    borderRadius: BorderRadius.circular(50),
                    child: Container(
                      padding: const EdgeInsets.all(8),
                      decoration: BoxDecoration(
                        color: Colors.grey[100],
                        shape: BoxShape.circle,
                      ),
                      child: const Icon(
                        Icons.arrow_back,
                        size: 24,
                      ),
                    ),
                  ),
                  const SizedBox(width: 16),
                  const Text(
                    'Search',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const Spacer(),
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
            ),

            // Search Bar
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: TextField(
                controller: _searchController,
                onSubmitted: _handleSearch,
                decoration: InputDecoration(
                  hintText: 'Search dishes, restaurants',
                  hintStyle: TextStyle(color: Colors.grey[400]),
                  prefixIcon: const Icon(Icons.search),
                  suffixIcon: _searchController.text.isNotEmpty
                      ? IconButton(
                    icon: const Icon(Icons.close),
                    onPressed: () {
                      _searchController.clear();
                      setState(() {});
                    },
                  )
                      : null,
                  filled: true,
                  fillColor: Colors.grey[100],
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: BorderSide.none,
                  ),
                ),
              ),
            ),

            // Recent Keywords
            const Padding(
              padding: EdgeInsets.all(16.0),
              child: Text(
                'Recent Keywords',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            SizedBox(
              height: 40,
              child: ListView.separated(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                scrollDirection: Axis.horizontal,
                itemCount: _recentKeywords.length,
                separatorBuilder: (context, index) => const SizedBox(width: 8),
                itemBuilder: (context, index) {
                  return ActionChip(
                    label: Text(_recentKeywords[index]),
                    backgroundColor: Colors.grey[100],
                    onPressed: () {
                      _searchController.text = _recentKeywords[index];
                      _handleSearch(_recentKeywords[index]);
                    },
                  );
                },
              ),
            ),

            // Suggested Restaurants
            const Padding(
              padding: EdgeInsets.all(16.0),
              child: Text(
                'Suggested Restaurants',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Column(
                children: const [
                  _SuggestedRestaurantItem(
                    image: 'assets/images/burger1.png',
                    name: 'Pansi Restaurant',
                    rating: 4.7,
                  ),
                  SizedBox(height: 16),
                  _SuggestedRestaurantItem(
                    image: 'assets/images/grid_1.png',
                    name: 'American Spicy Burger Shop',
                    rating: 4.3,
                  ),
                  SizedBox(height: 16),
                  _SuggestedRestaurantItem(
                    image: 'assets/images/pizza.jpg',
                    name: 'Cafenio Coffee Club',
                    rating: 4.0,
                  ),
                ],
              ),
            ),

            // Popular Fast Food
            const Padding(
              padding: EdgeInsets.all(16.0),
              child: Text(
                'Popular Fast Food',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Row(
                children: const [
                  Expanded(
                    child: _PopularFoodItem(
                      image: 'assets/images/pizza.jpg',
                      name: 'European Pizza',
                      restaurant: 'Pizza House',
                    ),
                  ),
                  SizedBox(width: 16),
                  Expanded(
                    child: _PopularFoodItem(
                      image: 'assets/images/burger1.png',
                      name: 'Buffalo Pizza',
                      restaurant: 'Cafenio Coffee Club',
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _SuggestedRestaurantItem extends StatelessWidget {
  final String image;
  final String name;
  final double rating;

  const _SuggestedRestaurantItem({
    required this.image,
    required this.name,
    required this.rating,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        // TODO: Navigate to restaurant details
      },
      child: Row(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(8),
            child: Image.asset(
              image,
              width: 60,
              height: 60,
              fit: BoxFit.cover,
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  name,
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                const SizedBox(height: 4),
                Row(
                  children: [
                    const Icon(
                      Icons.star,
                      color: Colors.amber,
                      size: 16,
                    ),
                    const SizedBox(width: 4),
                    Text(
                      rating.toString(),
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

class _PopularFoodItem extends StatelessWidget {
  final String image;
  final String name;
  final String restaurant;

  const _PopularFoodItem({
    required this.image,
    required this.name,
    required this.restaurant,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        // TODO: Navigate to food details
      },
      child: Column(
        children: [
          ClipOval(
            child: Image.asset(
              image,
              width: 120,
              height: 120,
              fit: BoxFit.cover,
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
            restaurant,
            style: TextStyle(
              fontSize: 14,
              color: Colors.grey[600],
            ),
          ),
        ],
      ),
    );
  }
}

