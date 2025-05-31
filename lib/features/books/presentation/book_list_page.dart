import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../models/book_model.dart';
import '../domain/book_provider.dart';
import '../widgets/book_card.dart';

class BookListPage extends ConsumerWidget {
  const BookListPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final asyncBooks = ref.watch(publicBooksProvider);

    return Scaffold(
      appBar: AppBar(title: const Text('Books')),
      body: asyncBooks.when(
        data: (books) {
          if (books.isEmpty) {
            return const Center(child: Text('No books available'));
          }
          return ListView.builder(
            itemCount: books.length,
            itemBuilder: (context, index) {
              final book = books[index];
              return BookCard(
                book: book,
                onTap: () {
                  // Navigasi ke detail buku, contoh:
                  // Navigator.push(context, MaterialPageRoute(builder: (_) => BookDetailPage(bookId: book.id)));
                },
              );
            },
          );
        },
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (error, stack) => Center(child: Text('Error: $error')),
      ),
    );
  }
}
