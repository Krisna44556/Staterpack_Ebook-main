import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../data/loan_repository.dart';
import '../../../models/loan_model.dart';

final loanRepositoryProvider = Provider<LoanRepository>((ref) {
  return LoanRepository();
});

final activeLoansProvider = FutureProvider<List<Loan>>((ref) async {
  final repo = ref.read(loanRepositoryProvider);
  return repo.fetchActiveLoans();
});

final loanHistoryProvider = FutureProvider<List<Loan>>((ref) async {
  final repo = ref.read(loanRepositoryProvider);
  return repo.fetchLoanHistory();
});
