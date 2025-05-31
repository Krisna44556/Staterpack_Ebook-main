import 'package:dio/dio.dart';
import '../../../core/constants/api_endpoints.dart';
import '../../../core/service/dio_client.dart';
import '../../../models/review_model.dart';

class ReviewRepository {
  final Dio _dio = DioClient.dio;

  Future<List<Review>> fetchReviewsByBook(int bookId) async {
    final response = await _dio.get(ApiEndpoints.reviewsByBook(bookId));
    if (response.statusCode == 200) {
      final data = response.data['data']['reviews'] as List;
      return data.map((json) => Review.fromJson(json)).toList();
    }
    throw Exception('Failed to load reviews');
  }

  Future<Review> createReview(int bookId, int rating, String? comment) async {
    final response = await _dio.post(ApiEndpoints.reviewsByBook(bookId), data: {
      'rating': rating,
      'comment': comment,
    });
    if (response.statusCode == 201) {
      return Review.fromJson(response.data['data']);
    }
    throw Exception('Failed to create review');
  }

  Future<Review> updateReview(int reviewId, int rating, String? comment) async {
    final response = await _dio.put(ApiEndpoints.reviewById(reviewId), data: {
      'rating': rating,
      'comment': comment,
    });
    if (response.statusCode == 200) {
      return Review.fromJson(response.data['data']);
    }
    throw Exception('Failed to update review');
  }

  Future<void> deleteReview(int reviewId) async {
    final response = await _dio.delete(ApiEndpoints.reviewById(reviewId));
    if (response.statusCode != 200) {
      throw Exception('Failed to delete review');
    }
  }
}
