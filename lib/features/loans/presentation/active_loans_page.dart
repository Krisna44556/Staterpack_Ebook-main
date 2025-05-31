import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../domain/loan_provider.dart';
import '../../../models/loan_model.dart';

class ActiveLoansPage extends ConsumerWidget {
  const ActiveLoansPage({super.key});

  Future<void> _returnBook(BuildContext context, WidgetRef ref, int loanId) async {
    try {
      // Panggil repository untuk return buku
      await ref.read(loanRepositoryProvider).returnBook(loanId);
      // Refresh daftar pinjaman aktif setelah pengembalian
      ref.refresh(activeLoansProvider);

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Book returned successfully')),
      );
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Failed to return book: $e')),
      );
    }
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final activeLoansAsync = ref.watch(activeLoansProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Active Loans'),
      ),
      body: activeLoansAsync.when(
        data: (loans) {
          if (loans.isEmpty) {
            return const Center(child: Text('You have no active loans.'));
          }
          return ListView.builder(
            itemCount: loans.length,
            itemBuilder: (context, index) {
              final loan = loans[index];
              return ListTile(
                title: Text('Book ID: ${loan.bookId}'),
                subtitle: Text('Borrowed at: ${loan.borrowedAt.toLocal()}'),
                trailing: ElevatedButton(
                  onPressed: loan.status == 'borrowed'
                      ? () => _returnBook(context, ref, loan.id)
                      : null,
                  child: const Text('Return'),
                ),
              );
            },
          );
        },
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (error, _) => Center(child: Text('Error: $error')),
      ),
    );
  }
}
