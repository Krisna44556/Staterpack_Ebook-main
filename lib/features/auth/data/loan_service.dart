import 'dart:convert';
import 'package:http/http.dart' as http;
import '../../../core/constants/api_endpoints.dart';
import '../../../core/utils/storage_helper.dart';
import '../../../models/loan_model.dart';

class LoanService {
  static const baseUrl = ApiEndpoints.baseUrl;

  // Pinjam buku
  static Future<void> borrowBook({
    required int bookId,
  }) async {
    final token = await StorageHelper.getToken();
    final today = DateTime.now();
    final returnedAt = today.add(const Duration(days: 7));

    final response = await http.post(
      Uri.parse('$baseUrl/loans'),
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token',
        'Accept': 'application/json',
      },
      body: jsonEncode({
        'book_id': bookId,
        'borrowed_at': today.toIso8601String().substring(0, 10),
        'returned_at': returnedAt.toIso8601String().substring(0, 10),
        'status': 'borrowed',
      }),
    );

    if (response.statusCode != 201) {
      throw Exception('Gagal meminjam buku: ${response.body}');
    }
  }

  // Ambil riwayat pinjaman user yang sedang login
  static Future<List<Loan>> fetchLoanHistory() async {
    final token = await StorageHelper.getToken();
    final response = await http.get(
      Uri.parse('$baseUrl/loans/history'),
      headers: {
        'Authorization': 'Bearer $token',
        'Accept': 'application/json',
      },
    );

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body) as List;
      return data.map((json) => Loan.fromJson(json)).toList();
    } else {
      throw Exception('Gagal memuat riwayat pinjaman');
    }
  }
}