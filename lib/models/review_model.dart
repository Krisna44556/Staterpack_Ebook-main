class Review {
  final int id;
  final int userId;
  final int bookId;
  final int rating;
  final String? comment;
  final String createdAt;
  final String updatedAt;
  final String? userName; // Optional: nama user pengulas

  Review({
    required this.id,
    required this.userId,
    required this.bookId,
    required this.rating,
    this.comment,
    required this.createdAt,
    required this.updatedAt,
    this.userName,
  });

  factory Review.fromJson(Map<String, dynamic> json) {
    return Review(
      id: json['id'],
      userId: json['user_id'],
      bookId: json['book_id'],
      rating: json['rating'],
      comment: json['comment'],
      createdAt: json['created_at'],
      updatedAt: json['updated_at'],
      userName: json['user'] != null ? json['user']['name'] : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'user_id': userId,
      'book_id': bookId,
      'rating': rating,
      'comment': comment,
      'created_at': createdAt,
      'updated_at': updatedAt,
    };
  }
}
