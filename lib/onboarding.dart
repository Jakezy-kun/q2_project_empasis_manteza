import 'dart:async';
import 'package:flutter/material.dart';
import 'loginscreen.dart';

class OnboardingScreen extends StatefulWidget {
  final Function toggleTheme;
  final bool isDarkMode;

  const OnboardingScreen({
    super.key,
    required this.toggleTheme,
    required this.isDarkMode,
  });

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  final PageController _pageController = PageController();
  int _currentPage = 0;
  Timer? _navigationTimer;


  static const Color _backgroundColor = Color(0xFFF8F9FA);
  static const Color _primaryTextColor = Color(0xFF212529);
  static const Color _secondaryTextColor = Color(0xFF6C757D);
  static const Color _accentColorTeal = Color(0xFF00897B);
  static const Color _accentColorOrange = Color(0xFFFFA000);

  @override
  void initState() {
    super.initState();
    _pageController.addListener(() {

      int nextPage = _pageController.page!.ceil();
      if (_currentPage != nextPage) {
        setState(() {
          _currentPage = nextPage;
        });
        _handleAutoNavigation();
      }
    });
  }


  void _handleAutoNavigation() {
    _navigationTimer?.cancel();
    if (_currentPage == 1) {
      _navigationTimer = Timer(const Duration(seconds: 3), () {
        if (mounted) {
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(
              builder: (context) => LoginScreen(
                toggleTheme: widget.toggleTheme,
                isDarkMode: widget.isDarkMode,
              ),
            ),
          );
        }
      });
    }
  }

  @override
  void dispose() {
    _pageController.dispose();
    _navigationTimer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: _backgroundColor,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        actions: const [],
      ),
      body: PageView(
        controller: _pageController,
        children: [
          _buildOnboarding1(),
          _buildOnboarding2(),
        ],
      ),
    );
  }


  Widget _buildOnboarding1() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24.0),
      child: Column(
        children: [
          const Spacer(flex: 1),
          // Placeholder for the main illustration
          Container(
            height: 250,
            decoration: BoxDecoration(
              color: const Color(0xFFFFFBEA),
              borderRadius: BorderRadius.circular(30),
            ),
            child: const Center(
              child: Icon(Icons.people_alt_outlined, size: 80, color: Color(0xFFFFF3C4)),
            ),
          ),
          const SizedBox(height: 48),
          const Text(
            'Join Reboot',
            style: TextStyle(
              fontSize: 28,
              fontWeight: FontWeight.bold,
              color: _primaryTextColor,
            ),
          ),
          const SizedBox(height: 16),
          const Text(
            'Buy smart. Trade back. Together, we\nbuild a greener future.',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 16,
              color: _secondaryTextColor,
              height: 1.5,
            ),
          ),
          const SizedBox(height: 32),
          const Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              _FeatureIcon(
                icon: Icons.shopping_cart_outlined,
                label: 'Smart Buy',
              ),
              _FeatureIcon(
                icon: Icons.repeat,
                label: 'Trade Back',
              ),
              _FeatureIcon(
                icon: Icons.people_outline,
                label: 'Community',
              ),
            ],
          ),
          const Spacer(flex: 2),
          _buildGetStartedButton(),
          const SizedBox(height: 24),
          const _Footer(),
          const SizedBox(height: 24),
        ],
      ),
    );
  }


  Widget _buildGetStartedButton() {
    return GestureDetector(
      onTap: () {
        _pageController.nextPage(
          duration: const Duration(milliseconds: 400),
          curve: Curves.easeInOut,
        );
      },
      child: Container(
        height: 56,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(28),
          gradient: const LinearGradient(
            colors: [Color(0xFF26A69A), Color(0xFF00897B)],
            begin: Alignment.centerLeft,
            end: Alignment.centerRight,
          ),
          boxShadow: [
            BoxShadow(
              color: const Color(0xFF26A69A).withOpacity(0.3),
              blurRadius: 10,
              offset: const Offset(0, 5),
            ),
          ],
        ),
        child: const Center(
          child: Text(
            'Get Started',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
        ),
      ),
    );
  }


  Widget _buildOnboarding2() {
    return Stack(
      children: [
        // Decorative background shapes
        Positioned(
          top: 100,
          right: -50,
          child: _buildDecorativeCircle(150, Colors.yellow.withOpacity(0.08)),
        ),
        Positioned(
          bottom: 200,
          left: -60,
          child: _buildDecorativeCircle(180, Colors.teal.withOpacity(0.08)),
        ),
        Positioned(
            top: 320,
            right: 40,
            child: Container(
              height: 60,
              width: 60,
              decoration: BoxDecoration(
                color: Colors.teal.withOpacity(0.1),
                shape: BoxShape.circle,
              ),
              child: Icon(Icons.sync_alt, color: Colors.teal.withOpacity(0.4), size: 30),
            )
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Spacer(flex: 2),
              // Central card with logo and name
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 48),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(25),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.1),
                      spreadRadius: 5,
                      blurRadius: 20,
                    )
                  ],
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Container(
                      padding: const EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        color: _accentColorTeal,
                        borderRadius: BorderRadius.circular(18),
                      ),
                      child: const Icon(Icons.sync, color: Colors.white, size: 32),
                    ),
                    const SizedBox(height: 24),
                    const Text(
                      'Reboot',
                      style: TextStyle(
                        fontSize: 36,
                        fontWeight: FontWeight.bold,
                        color: _primaryTextColor,
                      ),
                    ),
                    const SizedBox(height: 8),
                    const Text(
                      'buy smart. trade back.',
                      style: TextStyle(
                        fontSize: 16,
                        color: _accentColorOrange,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 48),
              Text(
                'Loading your sustainable marketplace...',
                style: TextStyle(fontSize: 16, color: _secondaryTextColor),
              ),
              const Spacer(flex: 3),
              _buildPageIndicator(),
              const SizedBox(height: 24),
              const _Footer(),
              const SizedBox(height: 24),
            ],
          ),
        ),
      ],
    );
  }


  Widget _buildDecorativeCircle(double size, Color color) {
    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        color: color,
        shape: BoxShape.circle,
      ),
    );
  }


  Widget _buildPageIndicator() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: List.generate(2, (index) {
        bool isActive = _currentPage == index;
        return AnimatedContainer(
          duration: const Duration(milliseconds: 300),
          margin: const EdgeInsets.symmetric(horizontal: 4.0),
          height: 8,
          width: isActive ? 24 : 8,
          decoration: BoxDecoration(
            color: isActive ? _accentColorTeal : _accentColorTeal.withOpacity(0.3),
            borderRadius: BorderRadius.circular(12),
          ),
        );
      }),
    );
  }
}


class _FeatureIcon extends StatelessWidget {
  final IconData icon;
  final String label;

  const _FeatureIcon({required this.icon, required this.label});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: const Color(0xFFE0F2F1),
            borderRadius: BorderRadius.circular(20),
          ),
          child: Icon(icon, color: const Color(0xFF00897B), size: 28),
        ),
        const SizedBox(height: 12),
        Text(
          label,
          style: const TextStyle(
            color: Color(0xFF6C757D),
            fontWeight: FontWeight.w500,
          ),
        ),
      ],
    );
  }
}


class _Footer extends StatelessWidget {
  const _Footer();

  @override
  Widget build(BuildContext context) {
    return const Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Icon(Icons.eco, color: Color(0xFF26A69A), size: 18),
        SizedBox(width: 8),
        Text(
          'Sustainable • Smart • Simple',
          style: TextStyle(
            color: Color(0xFF6C757D),
            fontWeight: FontWeight.w500,
          ),
        ),
      ],
    );
  }
}

