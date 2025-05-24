import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../auth/domain/loan_provider.dart';



class LoanHistoryPage extends ConsumerWidget {
  final int userId;
  const LoanHistoryPage({super.key, required this.userId});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final loanAsync = ref.watch(loanHistoryProvider(userId.toString()));

    return Scaffold(
      appBar: AppBar(title: const Text('Riwayat Peminjaman')),
      body: loanAsync.when(
        data: (loans) {
          if (loans.isEmpty) {
            return const Center(child: Text('Belum ada peminjaman'));
          }
          return ListView.builder(
            itemCount: loans.length,
            itemBuilder: (context, index) {
              final loan = loans[index];
              return ListTile(
                title: Text('ID Buku: ${loan.bookId}'),
                subtitle: Text('Status: ${loan.status}'),
                trailing: Text('Tgl Pinjam: ${loan.borrowedAt}'),
              );
            },
          );
        },
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (err, _) => Center(child: Text('Error: $err')),
      ),
    );
  }
}