class Product {
  final String id;
  final String name;
  final String imageUrl;
  final String description;
  final double price;
  final double rating;
  final int reviewCount;

  Product({
    required this.id,
    required this.name,
    required this.imageUrl,
    required this.description,
    required this.price,
    this.rating = 4.5,   
    this.reviewCount = 10,
  });
}
