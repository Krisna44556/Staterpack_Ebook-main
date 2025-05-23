import 'package:flutter_riverpod/flutter_riverpod.dart';

// Model pinjaman (dummy)
class Loan {
  final String bookId;
  final String status;
  final String borrowedAt;

  Loan({
    required this.bookId,
    required this.status,
    required this.borrowedAt,
  });
}

// Fungsi simulasi ambil data dari backend atau database
Future<List<Loan>> fetchLoanHistory(String userId) async {
  await Future.delayed(const Duration(seconds: 1));
  return [
   Loan(bookId: '1', status: 'Dipinjam', borrowedAt: '2025-05-10'),
   Loan(bookId: '2', status: 'Dikembalikan', borrowedAt: '2025-05-15'),
  ];
}

// Provider menggunakan Riverpod FutureProvider.family
final loanHistoryProvider =
    FutureProvider.family<List<Loan>, String>((ref, userId) async {
  return fetchLoanHistory(userId);
});
