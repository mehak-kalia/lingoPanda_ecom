import 'package:lingo_panda_ecom/models/review_model.dart';

class Product {
  final int id; // Unique identifier for the product
  final String title; // Title of the product
  final String description; // Description of the product
  final double price; // Original price of the product
  final double discountPercentage; // Discount percentage applied to the product
  final String thumbnail; // URL of the product's thumbnail image
  final String category; // Category under which the product falls
  final List<Review> reviews; // List of reviews for the product

  Product({
    required this.id,
    required this.title,
    required this.description,
    required this.price,
    required this.discountPercentage,
    required this.thumbnail,
    required this.category,
    required this.reviews, // Include reviews in constructor
  });

  /// Factory method to create a Product instance from JSON
  factory Product.fromJson(Map<String, dynamic> json) {
    // Ensure the 'reviews' key exists and is a List before parsing
    var reviewsJson = json['reviews'] is List ? json['reviews'] as List : [];

    // Map the JSON list to a list of Review objects
    List<Review> reviewsList = reviewsJson.map((review) => Review.fromJson(review)).toList();

    return Product(
      id: json['id'], // Unique identifier
      title: json['title'], // Product title
      description: json['description'], // Product description
      price: json['price']?.toDouble() ?? 0.0, // Original price, default to 0.0 if null
      discountPercentage: json['discountPercentage']?.toDouble() ?? 0.0, // Discount percentage, default to 0.0 if null
      thumbnail: json['thumbnail'], // Thumbnail URL
      category: json['category'], // Product category
      reviews: reviewsList, // Assign the parsed reviews list
    );
  }

  /// Calculate the discounted price of the product
  double get discountedPrice {
    return price - (price * (discountPercentage / 100));
  }
}
