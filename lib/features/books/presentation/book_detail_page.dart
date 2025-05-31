import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../models/book_model.dart';
import '../domain/book_provider.dart';

class BookDetailPage extends ConsumerWidget {
  final int bookId;

  const BookDetailPage({super.key, required this.bookId});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final bookAsync = ref.watch(bookDetailProvider(bookId));

    return Scaffold(
      appBar: AppBar(title: const Text('Detail Buku')),
      body: bookAsync.when(
        data: (book) => SingleChildScrollView(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                child: book.coverUrl.isNotEmpty
                    ? Image.network(book.coverUrl, height: 200)
                    : const Icon(Icons.book, size: 100),
              ),
              const SizedBox(height: 16),
              Text(
                book.title,
                style: Theme.of(context).textTheme.headline6,
              ),
              const SizedBox(height: 8),
              Text('Penulis: ${book.author}'),
              Text('Kategori: ${book.categoryName}'),
              const SizedBox(height: 16),
              Text(book.description),
            ],
          ),
        ),
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (err, stack) => Center(child: Text('Gagal memuat detail: $err')),
      ),
    );
  }
}
