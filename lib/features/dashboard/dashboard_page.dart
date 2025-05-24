import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../auth/domain/auth_provider.dart';

class DashboardPage extends StatefulWidget {
  const DashboardPage({super.key});

  @override
  State<DashboardPage> createState() => _DashboardPageState();
}

class _DashboardPageState extends State<DashboardPage> {
  int _selectedIndex = 0;

  final List<Map<String, String>> books = [
    {
      'title': 'Pemrograman Dart',
      'author': 'Budi Santoso',
      'image': 'assets/images/img.png'
    },
    {
      'title': 'Belajar Flutter',
      'author': 'Ani Wijaya',
      'image': 'https://raw.githubusercontent.com/dicodingacademy/assets/main/flutter_dicoding/flutter.png'
    },
    {
      'title': 'Pemrograman Web',
      'author': 'Siti Aminah',
      'image': 'https://cdn-icons-png.flaticon.com/512/2306/2306154.png'
    },
    {
      'title': 'UI/UX Modern',
      'author': 'Tono Rahman',
      'image': 'https://cdn-icons-png.flaticon.com/512/3135/3135715.png'
    },
    {
      'title': 'Database NoSQL',
      'author': 'Dina Kartika',
      'image': 'https://cdn-icons-png.flaticon.com/512/2921/2921222.png'
    },
    {
      'title': 'AI & Machine Learning',
      'author': 'Rizal Hakim',
      'image': 'https://cdn-icons-png.flaticon.com/512/2857/2857757.png'
    },
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  Widget _buildPage() {
    switch (_selectedIndex) {
      case 0:
        return _buildHome();
      case 1:
        return _buildBook();
      case 2:
        return _buildBorrowing();
      case 3:
        return _buildHistory();
      default:
        return const Center(child: Text('Halaman tidak ditemukan'));
    }
  }

  Widget _buildHome() {
    return GridView.builder(
      padding: const EdgeInsets.all(12),
      itemCount: books.length,
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        mainAxisSpacing: 12,
        crossAxisSpacing: 12,
        childAspectRatio: 0.65,
      ),
      itemBuilder: (context, index) {
        final book = books[index];
        return Card(
          elevation: 4,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              ClipRRect(
                borderRadius: const BorderRadius.vertical(top: Radius.circular(12)),
                child: Image.network(
                  book['image']!,
                  height: 140,
                  fit: BoxFit.cover,
                  errorBuilder: (context, error, stackTrace) =>
                      const Icon(Icons.broken_image, size: 80),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      book['title']!,
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 14,
                      ),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                    const SizedBox(height: 4),
                    Text(
                      'by ${book['author']}',
                      style: const TextStyle(fontSize: 12, color: Colors.grey),
                    ),
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _buildBook() {
    return const Center(
      child: Text('📥 Daftar Buku yang mau di pinjam', style: TextStyle(fontSize: 20)),
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
        title: Text(['Home','buku', 'Peminjaman', 'Riwayat'][_selectedIndex]),
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
          BottomNavigationBarItem(icon: Icon(Icons.book), label: 'buku'),
          BottomNavigationBarItem(icon: Icon(Icons.library_books), label: 'Pinjam'),
          BottomNavigationBarItem(icon: Icon(Icons.history), label: 'Riwayat'),
        ],
      ),
    );
  }
}
