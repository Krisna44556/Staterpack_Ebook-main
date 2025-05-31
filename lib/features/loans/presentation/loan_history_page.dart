import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../domain/loan_provider.dart';
import '../../../models/loan_model.dart';

class LoanHistoryPage extends ConsumerWidget {
  const LoanHistoryPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final loanHistoryAsync = ref.watch(loanHistoryProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Loan History'),
      ),
      body: loanHistoryAsync.when(
        data: (loans) {
          if (loans.isEmpty) {
            return const Center(child: Text('No loan history found'));
          }
          return ListView.builder(
            itemCount: loans.length,
            itemBuilder: (context, index) {
              final loan = loans[index];
              return ListTile(
                title: Text('Book ID: ${loan.bookId}'),
                subtitle: Text('Borrowed: ${loan.borrowedAt.toLocal()} \nReturned: ${loan.returnedAt?.toLocal() ?? 'Not returned'}'),
                trailing: Text(loan.status),
              );
            },
          );
        },
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (e, _) => Center(child: Text('Error: $e')),
      ),
    );
  }
}
