import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../features/auth/domain/book_provider.dart';
import '../../../models/book_model.dart';

// import 'package:flutter/material.dart';
// import 'package:flutter_riverpod/flutter_riverpod.dart';
// import '../../../models/book_model.dart';
// import '../domain/book_provider.dart';

class BookListPage extends ConsumerStatefulWidget {
  const BookListPage({super.key});

  @override
  ConsumerState<BookListPage> createState() => _BookListPageState();
}

class _BookListPageState extends ConsumerState<BookListPage> {
  @override
  void initState() {
    super.initState();
    // 👇 Panggil fetch data pertama kali
    Future.microtask(() {
      ref.read(bookProvider.notifier).fetchByCategory('novel');
    });
  }

  @override
  Widget build(BuildContext context) {
    final books = ref.watch(bookProvider);
    final controller = ref.read(bookProvider.notifier);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Daftar Buku'),
        actions: [
          IconButton(
            icon: const Icon(Icons.refresh),
            onPressed: () => controller.fetchByCategory('novel'),
          ),
        ],
      ),
      body: books.isEmpty
          ? const Center(child: CircularProgressIndicator())
          : ListView.builder(
              itemCount: books.length,
              itemBuilder: (context, index) {
                final book = books[index];
                print('Book loaded: ${book.title}');
                return Card(
                  margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                  child: ListTile(
                    title: Text(book.title),
                    subtitle: Text('Penulis: ${book.author}'),
                    trailing: Chip(
                      label: Text(
                        book.isAvailable ? 'Tersedia' : 'Dipinjam',
                        style: const TextStyle(color: Colors.white),
                      ),
                      backgroundColor:
                          book.isAvailable ? Colors.green : Colors.red,
                    ),
                  ),
                );
              },
            ),
          );
        }
      }
