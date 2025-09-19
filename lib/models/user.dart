class User {
  final String id;
  final String name;
  final String email;
  final String? profileImageUrl;
  final String location;
  final DateTime joinDate;
  final int itemsSold;
  final int itemsBought;
  final double rating;

  User({
    required this.id,
    required this.name,
    required this.email,
    this.profileImageUrl,
    required this.location,
    required this.joinDate,
    this.itemsSold = 0,
    this.itemsBought = 0,
    this.rating = 0.0,
  });
}