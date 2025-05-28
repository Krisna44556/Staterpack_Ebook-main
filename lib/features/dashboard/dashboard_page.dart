import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../auth/domain/book_provider.dart';
import 'dart:async';



class DashboardPage extends ConsumerStatefulWidget {
  const DashboardPage({super.key});

  @override
  ConsumerState<DashboardPage> createState() => _DashboardPageState();
}

class _DashboardPageState extends ConsumerState<DashboardPage> {
  int _selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          ['Home', 'Buku', 'Peminjaman', 'Riwayat', 'Profil'][_selectedIndex],
          style: const TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 20,
          ),
        ),
        backgroundColor: Colors.teal,
        foregroundColor: Colors.white,
        elevation: 4,
      ),
      body: _buildPage(),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex,
        onTap: (index) {
          setState(() => _selectedIndex = index);
          if (index == 1) {
            ref.read(bookProvider.notifier).fetchAllBooks();
          }
        },
        selectedItemColor: Colors.teal,
        unselectedItemColor: Colors.grey,
        selectedLabelStyle: const TextStyle(fontWeight: FontWeight.w500),
        type: BottomNavigationBarType.fixed,
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
          BottomNavigationBarItem(icon: Icon(Icons.book), label: 'Buku'),
          BottomNavigationBarItem(icon: Icon(Icons.library_books),label: 'Pinjam'),
          BottomNavigationBarItem(icon: Icon(Icons.history), label: 'Riwayat'),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Profil'),
        ],
      ),
    );
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
      case 4:
        return _buildProfil();
      default:
        return const Center(child: Text('Halaman tidak ditemukan'));
    }
  }

  // halaman home

  Widget _buildHome() {
  final PageController _pageController = PageController(viewportFraction: 0.85);
  int _currentPage = 0;

  // Timer auto scroll
  Timer.periodic(const Duration(seconds: 3), (Timer timer) {
    if (_pageController.hasClients) {
      _currentPage++;
      if (_currentPage >= 3) {
        _currentPage = 0;
      }
      _pageController.animateToPage(
        _currentPage,
        duration: const Duration(milliseconds: 500),
        curve: Curves.easeInOut,
      );
    }
  });

  final List<Map<String, dynamic>> _carouselItems = [
    {
      'icon': Icons.explore,
      'title': 'Eksplor Buku',
      'desc': 'Jelajahi Buku Terbaru Yang Kamu Mau',
    },
    {
      'icon': Icons.event,
      'title': 'Author',
      'desc': 'Cek jadwal Author Yang Terkenal',
    },
    {
      'icon': Icons.star,
      'title': 'Info Buku Hits',
      'desc': 'Lihat Buku Yang Paling Hits',
    },
  ];

  return SingleChildScrollView(
    child: Column(
      children: [
        const SizedBox(height: 30),
        const Icon(Icons.home, size: 60, color: Colors.teal),
        const SizedBox(height: 20),
        const Text(
          'Selamat datang di Dashboard!',
          style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 10),
        const Text(
          'Temukan fitur menarik di sini',
          style: TextStyle(fontSize: 16, color: Colors.grey),
        ),
        const SizedBox(height: 30),

        // Carousel
        SizedBox(
          height: 220,
          child: PageView.builder(
            controller: _pageController,
            itemCount: _carouselItems.length,
            itemBuilder: (context, index) {
              final item = _carouselItems[index];
              return Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8),
                child: Card(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20)),
                  elevation: 5,
                  color: Colors.teal.shade50,
                  child: Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(item['icon'], size: 50, color: Colors.teal),
                        const SizedBox(height: 10),
                        Text(item['title'],
                            style: const TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                                color: Colors.teal)),
                        const SizedBox(height: 5),
                        Text(item['desc'],
                            style: const TextStyle(fontSize: 14)),
                      ],
                    ),
                  ),
                ),
              );
            },
          ),
        ),

        const SizedBox(height: 30),
      ],
    ),
  );
}


// BOOKS LIST

  Widget _buildBookList() {
    final booksState = ref.watch(bookProvider);

    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: booksState.when(
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (error, stack) => Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(Icons.error_outline, size: 50, color: Colors.red),
              const SizedBox(height: 16),
              Text(
                'Error: $error',
                style: const TextStyle(fontSize: 16),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 20),
              ElevatedButton.icon(
                icon: const Icon(Icons.refresh),
                label: const Text('Coba Lagi'),
                onPressed: () =>
                    ref.read(bookProvider.notifier).fetchAllBooks(),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.teal,
                  foregroundColor: Colors.white,
                  padding:
                      const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                ),
              ),
            ],
          ),
        ),
        data: (books) => books.isEmpty
            ? const Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.book, size: 50, color: Colors.grey),
                    SizedBox(height: 16),
                    Text(
                      'Tidak ada buku tersedia',
                      style: TextStyle(fontSize: 18, color: Colors.grey),
                    ),
                  ],
                ),
              )
            : GridView.builder(
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  childAspectRatio: 0.7,
                  crossAxisSpacing: 10,
                  mainAxisSpacing: 10,
                ),
                itemCount: books.length,
                itemBuilder: (context, index) {
                  final book = books[index];
                  return Card(
                    elevation: 3,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        Expanded(
                          child: ClipRRect(
                            borderRadius: const BorderRadius.vertical(
                              top: Radius.circular(12),
                            ),
                            child: (book.imageUrl!= null &&
                                    book.imageUrl!.startsWith('http'))
                                ? Image.network(
                                    book.imageUrl!,
                                    fit: BoxFit.cover,
                                    errorBuilder:
                                        (context, error, stackTrace) =>
                                            const Icon(Icons.broken_image,
                                                size: 50),
                                  )
                                : Image.asset(
                                    book.imageUrl
 ??
                                        'assets/placeholder_book.png',
                                    fit: BoxFit.cover,
                                    errorBuilder:
                                        (context, error, stackTrace) =>
                                            const Icon(Icons.broken_image,
                                                size: 50),
                                  ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                book.title,
                                style: const TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 16,
                                ),
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                              ),
                              const SizedBox(height: 4),
                              Text(
                                'Penulis: ${book.author}',
                                style: const TextStyle(
                                  fontSize: 14,
                                  color: Colors.grey,
                                ),
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                              ),
                              const SizedBox(height: 8),
                              Container(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 8,
                                  vertical: 4,
                                ),
                                decoration: BoxDecoration(
                                  color: book.isAvailable
                                      ? Colors.green.withOpacity(0.2)
                                      : Colors.red.withOpacity(0.2),
                                  borderRadius: BorderRadius.circular(12),
                                ),
                                child: Text(
                                  book.isAvailable ? 'Tersedia' : 'Dipinjam',
                                  style: TextStyle(
                                    color: book.isAvailable
                                        ? Colors.green.shade800
                                        : Colors.red.shade800,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  );
                },
              ),
            ),
          );
        }



  Widget _buildBorrowing() {
    return const Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.library_books, size: 60, color: Colors.teal),
          SizedBox(height: 20),
          Text(
            'Daftar Peminjaman Anda',
            style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
          ),
        ],
      ),
    );
  }

  Widget _buildHistory() {
    return const Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.history, size: 60, color: Colors.teal),
          SizedBox(height: 20),
          Text(
            'Riwayat Peminjaman',
            style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
          ),
        ],
      ),
    );
  }

  Widget _buildProfil() {
    return const Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.person, size: 60, color: Colors.teal),
          SizedBox(height: 20),
          Text(
            'Halaman Profil',
            style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
          ),
        ],
      ),
    );
  }
}
