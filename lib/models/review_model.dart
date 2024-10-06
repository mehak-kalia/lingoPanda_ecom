class Review {
  final int rating; // Rating given by the reviewer
  final String comment; // Review comment
  final String date; // Date of the review
  final String reviewerName; // Name of the reviewer
  final String reviewerEmail; // Email of the reviewer

  Review({
    required this.rating,
    required this.comment,
    required this.date,
    required this.reviewerName,
    required this.reviewerEmail,
  });

  /// Factory method to create a Review instance from JSON
  factory Review.fromJson(Map<String, dynamic> json) {
    return Review(
      rating: json['rating'] is int ? json['rating'] : 0, // Default to 0 if not an int
      comment: json['comment'] ?? '', // Default to empty string if null
      date: json['date'] ?? '', // Default to empty string if null
      reviewerName: json['reviewerName'] ?? 'Anonymous', // Default to 'Anonymous' if null
      reviewerEmail: json['reviewerEmail'] ?? '', // Default to empty string if null
    );
  }
}
