import 'package:flutter/material.dart';
import '../../../models/book_model.dart';

class BookCard extends StatelessWidget {
  final BookModel book;
  final VoidCallback onTap;

  const BookCard({
    Key? key,
    required this.book,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
      child: ListTile(
        leading: book.coverUrl.isNotEmpty
            ? Image.network(
                book.coverUrl,
                width: 50,
                height: 70,
                fit: BoxFit.cover,
              )
            : const SizedBox(
                width: 50,
                height: 70,
                child: Icon(Icons.book),
              ),
        title: Text(book.title),
        subtitle: Text('Penulis: ${book.author}\nKategori: ${book.categoryName}'),
        isThreeLine: true,
        onTap: onTap,
      ),
    );
  }
}
