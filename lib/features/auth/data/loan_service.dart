import 'dart:convert';
import '../../../core/constants/api_endpoints.dart';
import 'package:sungokong_book/core/service/dio_client.dart';
import '../../../core/utils/storage_helper.dart';
import 'package:http/http.dart' as http;
import 'loan_model.dart';

class LoanService {
  static const baseUrl = 'http://127.0.0.1:8000/api'; // ganti sesuai IP server-mu

  static Future<void> borrowBook({
    required int userId,
    required int bookId,
  }) async {
    final today = DateTime.now();
    final returnedAt = today.add(const Duration(days: 7));

    final response = await http.post(
      Uri.parse('$baseUrl/loans'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({
        'user_id': userId,
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

  static Future<List<Loan>> fetchLoanHistory(int userId) async {
    final response = await http.get(Uri.parse('$baseUrl/loans/user/$userId'));

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body) as List;
      return data.map((json) => Loan.fromJson(json)).toList();
    } else {
      throw Exception('Gagal memuat riwayat pinjaman');
    }
  }
}