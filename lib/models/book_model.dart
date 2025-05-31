import 'category_model.dart';

class BookModel {
  final int id;
  final String title;
  final String author;
  final String description;
  final String coverUrl;
  final int categoryId;
  final CategoryModel? category;

  BookModel({
    required this.id,
    required this.title,
    required this.author,
    required this.description,
    required this.coverUrl,
    required this.categoryId,
    this.category,
  });

  factory BookModel.fromJson(Map<String, dynamic> json) {
    return BookModel(
      id: json['id'],
      title: json['title'] ?? '',
      author: json['author'] ?? '',
      description: json['description'] ?? '',
      coverUrl: json['cover_url'] ?? '',
      categoryId: json['category_id'],
      category: json['category'] != null
          ? CategoryModel.fromJson(json['category'])
          : null,
    );
  }

  Map<String, dynamic> toJson() => {
        'id': id,
        'title': title,
        'author': author,
        'description': description,
        'cover_url': coverUrl,
        'category_id': categoryId,
        'category': category?.toJson(),
      };

  // Getter untuk nama kategori
  String get categoryName => category?.name ?? '-';
}
