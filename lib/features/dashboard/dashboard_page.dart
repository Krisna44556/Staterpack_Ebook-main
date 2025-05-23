import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../auth/domain/book_provider.dart';
import '../../models/book_model.dart';

class DashboardPage extends ConsumerStatefulWidget {
  const DashboardPage({super.key});

  @override
  ConsumerState<DashboardPage> createState() => _DashboardPageState();
}

class _DashboardPageState extends ConsumerState<DashboardPage> {
  int _selectedIndex = 0;

  @override
  void initState() {
    super.initState();
    // Fetch buku pertama kali saat masuk dashboard
    Future.microtask(() {
      ref.read(bookProvider.notifier).fetchAllBooks();
    });
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
    // Jika tab buku dipilih, fetch buku dari database
    if (index == 1) {
      ref.read(bookProvider.notifier).fetchAllBooks();
    }
  }

  Widget _buildPage() {
    switch (_selectedIndex) {
      case 0:
        return _buildHome();
      case 1:
        return _buildBookList();
      case 2:
        return _buildBorrowing();
      case 3:
        return _buildHistory();
      default:
        return const Center(child: Text('Halaman tidak ditemukan'));
    }
  }

  Widget _buildHome() {
    return const Center(
      child: Text('Selamat datang di Dashboard!', style: TextStyle(fontSize: 20)),
    );
  }

  Widget _buildBookList() {
    final books = ref.watch(bookProvider);

    if (books.isEmpty) {
      return const Center(child: CircularProgressIndicator());
    }

    return ListView.builder(
      itemCount: books.length,
      itemBuilder: (context, index) {
        final BookModel book = books[index];
        return Card(
          margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
          child: ListTile(
            leading: book.coverUrl.startsWith('http')
                ? Image.network(book.coverUrl, width: 50, height: 70, fit: BoxFit.cover)
                : Image.asset(book.coverUrl, width: 50, height: 70, fit: BoxFit.cover),
            title: Text(book.title),
            subtitle: Text('Penulis: ${book.author}'),
            trailing: Chip(
              label: Text(
                book.isAvailable ? 'Tersedia' : 'Dipinjam',
                style: const TextStyle(color: Colors.white),
              ),
              backgroundColor: book.isAvailable ? Colors.green : Colors.red,
            ),
          ),
        );
      },
    );
  }

  Widget _buildBorrowing() {
    return const Center(
      child: Text('📥 Daftar Peminjaman Anda', style: TextStyle(fontSize: 20)),
    );
  }

  Widget _buildHistory() {
    return const Center(
      child: Text('📜 Riwayat Peminjaman', style: TextStyle(fontSize: 20)),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(['Home', 'Buku', 'Peminjaman', 'Riwayat'][_selectedIndex]),
        backgroundColor: Colors.teal,
        foregroundColor: Colors.white,
      ),
      body: _buildPage(),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
        selectedItemColor: Colors.teal,
        unselectedItemColor: Colors.grey,
        type: BottomNavigationBarType.fixed,
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
          BottomNavigationBarItem(icon: Icon(Icons.book), label: 'Buku'),
          BottomNavigationBarItem(icon: Icon(Icons.library_books), label: 'Pinjam'),
          BottomNavigationBarItem(icon: Icon(Icons.history), label: 'Riwayat'),
        ],
      ),
    );
  }
}