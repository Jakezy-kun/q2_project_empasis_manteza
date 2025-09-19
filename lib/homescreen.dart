import 'package:flutter/material.dart';
import 'searchscreen.dart';
import 'sellscreen.dart';
import 'chatscreen.dart';
import 'profilescreen.dart';
import 'notificationscreen.dart';
import 'screens/product_detail_screen.dart';
import 'models/product.dart';

class HomeScreen extends StatefulWidget {
  final Function toggleTheme;
  final bool isDarkMode;

  const HomeScreen({
    super.key,
    required this.toggleTheme,
    required this.isDarkMode,
  });

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _currentIndex = 0;
  final List<Product> _featuredProducts = Product.sampleProducts();

  @override
  Widget build(BuildContext context) {
    final List<Widget> _screens = [
      HomeContent(
        toggleTheme: widget.toggleTheme,
        isDarkMode: widget.isDarkMode,
        featuredProducts: _featuredProducts,
      ),
      const SearchScreen(),
      const SellScreen(),
      const ChatScreen(),
      const ProfileScreen(),
    ];

    return Scaffold(
      body: _screens[_currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        onTap: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
        type: BottomNavigationBarType.fixed,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.search),
            label: 'Search',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.sell),
            label: 'Sell',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.chat),
            label: 'Chat',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'Profile',
          ),
        ],
      ),
    );
  }
}

class HomeContent extends StatefulWidget {
  final Function toggleTheme;
  final bool isDarkMode;
  final List<Product> featuredProducts;

  const HomeContent({
    super.key,
    required this.toggleTheme,
    required this.isDarkMode,
    required this.featuredProducts,
  });

  @override
  State<HomeContent> createState() => _HomeContentState();
}

class _HomeContentState extends State<HomeContent> {
  final List<String> categories = ['Phones', 'Laptops', 'Tablets', 'Accessories'];
  String selectedCategory = 'Phones';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('ReBooted'),
        actions: [
          IconButton(
            icon: Icon(widget.isDarkMode ? Icons.light_mode : Icons.dark_mode),
            onPressed: () => widget.toggleTheme(),
            tooltip: widget.isDarkMode ? 'Switch to light mode' : 'Switch to dark mode',
          ),
          IconButton(
            icon: const Icon(Icons.notifications),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const NotificationScreen()),
              );
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Search Bar
            Container(
              decoration: BoxDecoration(
                color: Theme.of(context).brightness == Brightness.dark
                    ? Colors.grey[800]
                    : Colors.grey[200],
                borderRadius: BorderRadius.circular(25),
              ),
              child: const TextField(
                decoration: InputDecoration(
                  hintText: 'Search devices...',
                  border: InputBorder.none,
                  prefixIcon: Icon(Icons.search),
                  contentPadding: EdgeInsets.symmetric(vertical: 15),
                ),
              ),
            ),
            const SizedBox(height: 20),

            // Category Selector
            const Text(
              'Categories',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            SizedBox(
              height: 50,
              child: ListView(
                scrollDirection: Axis.horizontal,
                children: categories.map((category) {
                  return Padding(
                    padding: const EdgeInsets.only(right: 8),
                    child: ChoiceChip(
                      label: Text(category),
                      selected: selectedCategory == category,
                      onSelected: (selected) {
                        setState(() {
                          selectedCategory = category;
                        });
                      },
                    ),
                  );
                }).toList(),
              ),
            ),
            const SizedBox(height: 20),

            // Featured Devices
            const Text(
              'Featured Devices',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            ...widget.featuredProducts.map((product) {
              return Column(
                children: [
                  _buildFeaturedDevice(product),
                  const SizedBox(height: 16),
                ],
              );
            }).toList(),

            const SizedBox(height: 20),

            // Near You
            const Text(
              'Near You',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            _buildNearYouDevice(
              'iPhone 14 2nd hand',
              'P749',
              'Downtown - 0.5 mi',
              'assets/images/iphone14.jpg',
            ),
            const SizedBox(height: 10),
            _buildNearYouDevice(
              'MacBook Pro',
              'P1,199',
              'Uptown - 1.2 mi',
              'assets/images/macbook.jpg',
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildFeaturedDevice(Product product) {
    return MouseRegion(
      cursor: SystemMouseCursors.click,
      child: GestureDetector(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => ProductDetailScreen(product: product),
            ),
          );
        },
        child: TweenAnimationBuilder<double>(
          duration: const Duration(milliseconds: 200),
          tween: Tween(begin: 1.0, end: 1.0),
          builder: (context, value, child) {
            return Transform.scale(
              scale: value,
              child: child,
            );
          },
          child: Card(
            elevation: 4,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  height: 150,
                  child: Image.asset(
                    product.imageUrls.first,
                    fit: BoxFit.cover,
                    errorBuilder: (context, error, stackTrace) {
                      return Container(
                        color: Colors.grey[300],
                        child: const Icon(Icons.photo, size: 50, color: Colors.grey),
                      );
                    },
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        product.title,
                        style: const TextStyle(fontWeight: FontWeight.bold),
                      ),
                      Text(
                        '₱${product.price.toStringAsFixed(2)}',
                        style: const TextStyle(
                          color: Colors.green,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Row(
                        children: [
                          const Icon(Icons.location_on, size: 12, color: Colors.grey),
                          const SizedBox(width: 4),
                          Text(
                            product.location,
                            style: const TextStyle(fontSize: 12, color: Colors.grey),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildNearYouDevice(String name, String price, String location, String imagePath) {
    return MouseRegion(
      cursor: SystemMouseCursors.click,
      child: GestureDetector(
        onTap: () {
          // Find the product by name and navigate to detail
          final product = widget.featuredProducts.firstWhere(
                (p) => p.title == name,
            orElse: () => Product.sampleProducts().first,
          );
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => ProductDetailScreen(product: product),
            ),
          );
        },
        child: TweenAnimationBuilder<double>(
          duration: const Duration(milliseconds: 200),
          tween: Tween(begin: 1.0, end: 1.0),
          builder: (context, value, child) {
            return Transform.scale(
              scale: value,
              child: child,
            );
          },
          child: Card(
            elevation: 4,
            child: Row(
              children: [
                Container(
                  width: 100,
                  height: 100,
                  child: Image.asset(
                    imagePath,
                    fit: BoxFit.cover,
                    errorBuilder: (context, error, stackTrace) {
                      return Container(
                        color: Colors.grey[300],
                        child: const Icon(Icons.photo, size: 40, color: Colors.grey),
                      );
                    },
                  ),
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        name,
                        style: const TextStyle(fontWeight: FontWeight.bold),
                      ),
                      Text(
                        price,
                        style: const TextStyle(
                          color: Colors.green,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        location,
                        style: const TextStyle(fontSize: 12, color: Colors.grey),
                      ),
                    ],
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