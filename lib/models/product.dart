class Product {
  final String id;
  final String title;
  final double price;
  final String condition;
  final String description;
  final List<String> imageUrls;
  final String sellerId;
  final String sellerName;
  final double sellerRating;
  final String location;
  final DateTime postedDate;
  final String category;

  Product({
    required this.id,
    required this.title,
    required this.price,
    required this.condition,
    required this.description,
    required this.imageUrls,
    required this.sellerId,
    required this.sellerName,
    required this.sellerRating,
    required this.location,
    required this.postedDate,
    required this.category,
  });

  static List<Product> sampleProducts() {
    return [
      Product(
        id: '1',
        title: 'iPhone 15 Pro 2nd hand',
        price: 899.00,
        condition: 'Like New',
        description: 'iPhone 15 Pro in excellent condition. No scratches, battery health 98%. Comes with original box and charger. Perfect for those looking for premium quality at a fraction of the price.',
        imageUrls: ['assets/images/iphone15pro.jpg', 'assets/images/iphone15pro_2.jpg', 'assets/images/iphone15pro_3.jpg'],
        sellerId: 'seller1',
        sellerName: 'TechGuru Davao',
        sellerRating: 4.8,
        location: 'Downtown Davao',
        postedDate: DateTime.now().subtract(const Duration(days: 2)),
        category: 'Phones',
      ),
      Product(
        id: '2',
        title: 'MacBook Pro M2',
        price: 1199.00,
        condition: 'Excellent',
        description: 'MacBook Pro with M2 chip, 16GB RAM, 512GB SSD. Perfect for work and creative projects. Includes original charger and protective case.',
        imageUrls: ['assets/images/macbook.jpg', 'assets/images/macbook_2.jpg'],
        sellerId: 'seller2',
        sellerName: 'AppleFan Davao',
        sellerRating: 4.5,
        location: 'Ecoland Davao',
        postedDate: DateTime.now().subtract(const Duration(days: 5)),
        category: 'Laptops',
      ),
      Product(
        id: '3',
        title: 'iPhone 14 2nd hand',
        price: 749.00,
        condition: 'Good',
        description: 'iPhone 14 with 128GB storage. Minor scratches on screen but fully functional. Battery health at 87%. Great value for money.',
        imageUrls: ['assets/images/iphone14.jpg'],
        sellerId: 'seller3',
        sellerName: 'MobileSavvy',
        sellerRating: 4.2,
        location: 'Bajada Davao',
        postedDate: DateTime.now().subtract(const Duration(days: 1)),
        category: 'Phones',
      ),
    ];
  }
}