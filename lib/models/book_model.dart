class BookModel {
  final int id;
  final String title;
  final String author;
  final String? publisher;
  final int? publishedYear;
  final String? description;
  final int quantity;
  final int borrowedCount;
  final String? imageUrl;
  final String? category;
  final DateTime createdAt;
  final DateTime updatedAt;

  BookModel({
    required this.id,
    required this.title,
    required this.author,
    this.publisher,
    this.publishedYear,
    this.description,
    required this.quantity,
    required this.borrowedCount,
    this.imageUrl,
    this.category,
    required this.createdAt,
    required this.updatedAt,
  });

  /// Getter tambahan sesuai kebutuhan frontend
  bool get isAvailable => quantity > borrowedCount;

  factory BookModel.fromJson(Map<String, dynamic> json) {
    return BookModel(
      id: json['id'] as int? ?? 0,
      title: json['title'] as String? ?? 'No Title',
      author: json['author'] as String? ?? 'Unknown Author',
      publisher: json['publisher'] as String?,
      publishedYear: json['published_year'] as int?,
      description: json['description'] as String?,
      quantity: json['quantity'] as int? ?? 0,
      borrowedCount: json['borrowed_count'] as int? ?? 0,
      imageUrl: json['image_url'] as String?,
      category: json['category'] as String?,
      createdAt: json['created_at'] != null
          ? DateTime.parse(json['created_at'])
          : DateTime.now(),
      updatedAt: json['updated_at'] != null
          ? DateTime.parse(json['updated_at'])
          : DateTime.now(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'author': author,
      'publisher': publisher,
      'published_year': publishedYear,
      'description': description,
      'quantity': quantity,
      'borrowed_count': borrowedCount,
      'image_url': imageUrl,
      'category': category,
      'created_at': createdAt.toIso8601String(),
      'updated_at': updatedAt.toIso8601String(),
    };
  }
}
