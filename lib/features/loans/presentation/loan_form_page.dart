import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../models/book_model.dart';
import '../domain/loan_provider.dart';

class LoanFormPage extends ConsumerStatefulWidget {
  final BookModel book;

  const LoanFormPage({super.key, required this.book});

  @override
  ConsumerState<LoanFormPage> createState() => _LoanFormPageState();
}

class _LoanFormPageState extends ConsumerState<LoanFormPage> {
  bool _isLoading = false;
  String? _error;

  Future<void> _borrowBook() async {
    setState(() {
      _isLoading = true;
      _error = null;
    });

    final repo = ref.read(loanRepositoryProvider);

    try {
      await repo.borrowBook(widget.book.id);
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Book borrowed successfully')),
        );
        Navigator.pop(context, true);
      }
    } catch (e) {
      setState(() {
        _error = e.toString();
      });
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Borrow Book'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            Text('Do you want to borrow this book?'),
            const SizedBox(height: 16),
            Text(widget.book.title, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
            const SizedBox(height: 16),
            if (_error != null)
              Text(_error!, style: const TextStyle(color: Colors.red)),
            ElevatedButton(
              onPressed: _isLoading ? null : _borrowBook,
              child: _isLoading
                  ? const CircularProgressIndicator(color: Colors.white)
                  : const Text('Confirm Borrow'),
            ),
          ],
        ),
      ),
    );
  }
}
