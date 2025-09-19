class Device {
  final String id;
  final String name;
  final double price;
  final String description;
  final String category;
  final String condition;
  final List<String> imageUrls;
  final String sellerId;
  final DateTime listedDate;
  final String location;

  Device({
    required this.id,
    required this.name,
    required this.price,
    required this.description,
    required this.category,
    required this.condition,
    required this.imageUrls,
    required this.sellerId,
    required this.listedDate,
    required this.location,
  });
}