class BookModel {
  final int id;
  final String title;
  final String author;
  final String? publisher;
  final int? publishedYear;
  final String category;
  final String? description;
  final int stock;
  final int borrowedCount;
  final String? coverUrl;
  final bool isAvailable;
  final int quantity;
  final DateTime createdAt;
  final DateTime updatedAt;

  BookModel({
    required this.id,
    required this.title,
    required this.author,
    this.publisher,
    this.publishedYear,
    required this.category,
    this.description,
    required this.stock,
    required this.borrowedCount,
    this.coverUrl,
    required this.isAvailable,
    required this.quantity,
    required this.createdAt,
    required this.updatedAt,
  });

  factory BookModel.fromJson(Map<String, dynamic> json) {
    return BookModel(
      id: json['id'] as int? ?? 0,
      title: json['title'] as String? ?? 'No Title',
      author: json['author'] as String? ?? 'Unknown Author',
      publisher: json['publisher'] as String?,
      publishedYear: json['published_year'] as int?,
      category: json['category'] as String? ?? 'Uncategorized',
      description: json['description'] as String?,
      stock: json['stock'] as int? ?? 0,
      borrowedCount: json['borrowed_count'] as int? ?? 0,
      coverUrl: json['cover_url'] as String?,
      isAvailable: (json['is_available'] as int?) == 1, // Convert 1/0 to bool
      quantity: json['quantity'] as int? ?? 1,
      createdAt: json['created_at'] != null
          ? DateTime.parse(json['created_at'] as String)
          : DateTime.now(),
      updatedAt: json['updated_at'] != null
          ? DateTime.parse(json['updated_at'] as String)
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
      'category': category,
      'description': description,
      'stock': stock,
      'borrowed_count': borrowedCount,
      'cover_url': coverUrl,
      'is_available': isAvailable ? 1 : 0, // Convert back to int
      'quantity': quantity,
      'created_at': createdAt.toIso8601String(),
      'updated_at': updatedAt.toIso8601String(),
    };
  }
}
