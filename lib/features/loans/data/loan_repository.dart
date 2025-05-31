import 'package:dio/dio.dart';
import '../../../core/constants/api_endpoints.dart';
import '../../../core/service/dio_client.dart';
import '../../../models/loan_model.dart';

class LoanRepository {
  final Dio _dio = DioClient.dio;

  Future<List<Loan>> fetchActiveLoans() async {
    try {
      final response = await _dio.get(ApiEndpoints.loans);
      if (response.statusCode == 200) {
        final data = response.data['data'] as List;
        return data.map((json) => Loan.fromJson(json)).toList();
      } else {
        throw Exception('Failed to fetch loans');
      }
    } on DioError catch (e) {
      throw Exception('Dio error: ${e.message}');
    }
  }

  Future<List<Loan>> fetchLoanHistory() async {
    try {
      final response = await _dio.get(ApiEndpoints.loanHistory);
      if (response.statusCode == 200) {
        final data = response.data['data'] as List;
        return data.map((json) => Loan.fromJson(json)).toList();
      } else {
        throw Exception('Failed to fetch loan history');
      }
    } on DioError catch (e) {
      throw Exception('Dio error: ${e.message}');
    }
  }

  Future<void> borrowBook(int bookId) async {
    try {
      final response = await _dio.post(ApiEndpoints.loans, data: {'book_id': bookId});
      if (response.statusCode != 201) {
        throw Exception(response.data['message'] ?? 'Failed to borrow book');
      }
    } on DioError catch (e) {
      throw Exception('Dio error: ${e.response?.data['message'] ?? e.message}');
    }
  }

  Future<void> returnBook(int loanId) async {
    try {
      final response = await _dio.put('${ApiEndpoints.loans}/$loanId/return');
      if (response.statusCode != 200) {
        throw Exception(response.data['message'] ?? 'Failed to return book');
      }
    } on DioError catch (e) {
      throw Exception('Dio error: ${e.response?.data['message'] ?? e.message}');
    }
  }
}
