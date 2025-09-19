import 'package:flutter/material.dart';
import '../models/product.dart';

class ProductDetailScreen extends StatefulWidget {
  final Product product;

  const ProductDetailScreen({super.key, required this.product});

  @override
  State<ProductDetailScreen> createState() => _ProductDetailScreenState();
}

class _ProductDetailScreenState extends State<ProductDetailScreen> {
  int _currentImageIndex = 0;
  final PageController _pageController = PageController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Product Details'),
        actions: [
          IconButton(
            icon: const Icon(Icons.favorite_border),
            onPressed: () {},
          ),
          IconButton(
            icon: const Icon(Icons.share),
            onPressed: () {},
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Image Carousel
            _buildImageCarousel(),

            // Product Info Section
            Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Title and Price
                  Text(
                    widget.product.title,
                    style: const TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    '₱${widget.product.price.toStringAsFixed(2)}',
                    style: const TextStyle(
                      fontSize: 28,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF109991),
                    ),
                  ),

                  const SizedBox(height: 16),

                  // Condition and Category
                  Row(
                    children: [
                      _buildInfoChip('Condition: ${widget.product.condition}', Icons.construction),
                      const SizedBox(width: 8),
                      _buildInfoChip(widget.product.category, Icons.category),
                    ],
                  ),

                  const SizedBox(height: 20),

                  // Description
                  const Text(
                    'Description',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    widget.product.description,
                    style: const TextStyle(
                      fontSize: 16,
                      height: 1.5,
                    ),
                  ),

                  const SizedBox(height: 20),

                  // Seller Information
                  const Text(
                    'Seller Information',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 12),
                  _buildSellerInfo(),

                  const SizedBox(height: 20),

                  // Location and Date
                  _buildLocationInfo(),

                  const SizedBox(height: 30),

                  // Action Buttons
                  _buildActionButtons(),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildImageCarousel() {
    return Stack(
      children: [
        // Main Image Carousel
        SizedBox(
          height: 300,
          child: PageView.builder(
            controller: _pageController,
            itemCount: widget.product.imageUrls.length,
            onPageChanged: (index) {
              setState(() {
                _currentImageIndex = index;
              });
            },
            itemBuilder: (context, index) {
              return Image.asset(
                widget.product.imageUrls[index],
                fit: BoxFit.cover,
                errorBuilder: (context, error, stackTrace) {
                  return Container(
                    color: Colors.grey[200],
                    child: const Icon(Icons.photo, size: 100, color: Colors.grey),
                  );
                },
              );
            },
          ),
        ),

        // Image Indicators
        if (widget.product.imageUrls.length > 1)
          Positioned(
            bottom: 16,
            left: 0,
            right: 0,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: widget.product.imageUrls.asMap().entries.map((entry) {
                return Container(
                  width: 8,
                  height: 8,
                  margin: const EdgeInsets.symmetric(horizontal: 4),
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: _currentImageIndex == entry.key
                        ? const Color(0xFF109991)
                        : Colors.white.withOpacity(0.7),
                  ),
                );
              }).toList(),
            ),
          ),
      ],
    );
  }

  Widget _buildInfoChip(String text, IconData icon) {
    return Chip(
      label: Text(text),
      avatar: Icon(icon, size: 16),
      backgroundColor: const Color(0xFF109991).withOpacity(0.1),
    );
  }

  Widget _buildSellerInfo() {
    return Row(
      children: [
        const CircleAvatar(
          radius: 24,
          backgroundColor: Color(0xFF109991),
          child: Icon(Icons.person, color: Colors.white),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                widget.product.sellerName,
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 4),
              Row(
                children: [
                  const Icon(Icons.star, size: 16, color: Colors.amber),
                  const SizedBox(width: 4),
                  Text(
                    widget.product.sellerRating.toString(),
                    style: const TextStyle(fontSize: 14),
                  ),
                  const SizedBox(width: 8),
                  const Icon(Icons.verified, size: 16, color: Colors.green),
                  const SizedBox(width: 4),
                  const Text('Verified', style: TextStyle(fontSize: 12)),
                ],
              ),
            ],
          ),
        ),
        IconButton(
          icon: const Icon(Icons.chat, color: Color(0xFF109991)),
          onPressed: () {
            // Navigate to chat with seller
          },
        ),
      ],
    );
  }

  Widget _buildLocationInfo() {
    return Row(
      children: [
        const Icon(Icons.location_on, size: 20, color: Colors.grey),
        const SizedBox(width: 8),
        Text(
          widget.product.location,
          style: const TextStyle(color: Colors.grey),
        ),
        const Spacer(),
        const Icon(Icons.calendar_today, size: 16, color: Colors.grey),
        const SizedBox(width: 4),
        Text(
          'Posted ${_formatDate(widget.product.postedDate)}',
          style: const TextStyle(fontSize: 12, color: Colors.grey),
        ),
      ],
    );
  }

  Widget _buildActionButtons() {
    return Row(
      children: [
        Expanded(
          child: OutlinedButton.icon(
            onPressed: () {
              // Save to favorites
            },
            icon: const Icon(Icons.favorite_border),
            label: const Text('Save'),
            style: OutlinedButton.styleFrom(
              padding: const EdgeInsets.symmetric(vertical: 16),
            ),
          ),
        ),
        const SizedBox(width: 12),
        Expanded(
          flex: 2,
          child: ElevatedButton.icon(
            onPressed: () {
              // Start chat with seller
            },
            icon: const Icon(Icons.chat),
            label: const Text('Chat with Seller'),
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFF109991),
              foregroundColor: Colors.white,
              padding: const EdgeInsets.symmetric(vertical: 16),
            ),
          ),
        ),
      ],
    );
  }

  String _formatDate(DateTime date) {
    final now = DateTime.now();
    final difference = now.difference(date);

    if (difference.inDays > 0) {
      return '${difference.inDays} days ago';
    } else if (difference.inHours > 0) {
      return '${difference.inHours} hours ago';
    } else {
      return '${difference.inMinutes} minutes ago';
    }
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }
}