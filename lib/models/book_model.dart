
// ignore_for_file: non_constant_identifier_names

class BookModel {
  final int id;
  final String title;
  final String author;
  final String publisher;
  final String year;
  final String category;
  final String description;
  final String stok;
  // ignore: duplicate_ignore
  // ignore: non_constant_identifier_names
  final String borrowed_count;
  final String coverUrl;
  final bool isAvailable;
  final DateTime createdAt;
  final DateTime updatedAt;

  BookModel({
    required this.id,
    required this.title,
    required this.author,
    required this.publisher,
    required this.year,
    required this.category,
    required this.description,
    required this.stok,
    required this.borrowed_count,
    required this.coverUrl,
    required this.isAvailable,
    required this.createdAt,
    required this.updatedAt,
  });

  factory BookModel.fromJson(Map<String, dynamic> json) {
    return BookModel(
      id: json['id'],
      title: json['title'],
      author: json['author'],
      publisher: json['publisher'],
      year: json['year'],
      category: json['category'],
      description: json['description'],
      stok: json['stok'],
      borrowed_count: json['borrowed_count'],
      coverUrl: json['cover_url'],
      isAvailable: json['is_available'],
      createdAt: DateTime.parse(json['created_at']),
      updatedAt: DateTime.parse(json['updated_at']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'author': author,
      'publisher': publisher,
      'year': year,
      'category': category,
      'description': description,
      'stok': stok,
      'borrowed_count': borrowed_count,
      'cover_url': coverUrl,
      'is_available': isAvailable,
      'created_at': createdAt.toIso8601String(),
      'updated_at': updatedAt.toIso8601String(),
    };
  }
}
