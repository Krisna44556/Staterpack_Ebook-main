import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../data/review_repository.dart';
import '../../../models/review_model.dart';

class ReviewState {
  final List<Review> reviews;
  final bool isLoading;
  final String? error;

  ReviewState({
    required this.reviews,
    this.isLoading = false,
    this.error,
  });

  ReviewState copyWith({
    List<Review>? reviews,
    bool? isLoading,
    String? error,
  }) {
    return ReviewState(
      reviews: reviews ?? this.reviews,
      isLoading: isLoading ?? this.isLoading,
      error: error,
    );
  }
}

class ReviewNotifier extends StateNotifier<ReviewState> {
  final ReviewRepository _repo;
  final int bookId;

  ReviewNotifier(this._repo, this.bookId) : super(ReviewState(reviews: [])) {
    fetchReviews();
  }

  Future<void> fetchReviews() async {
    try {
      state = state.copyWith(isLoading: true, error: null);
      final reviews = await _repo.fetchReviewsByBook(bookId);
      state = state.copyWith(reviews: reviews, isLoading: false);
    } catch (e) {
      state = state.copyWith(error: e.toString(), isLoading: false);
    }
  }

  Future<void> createReview(int rating, String? comment) async {
    try {
      state = state.copyWith(isLoading: true, error: null);
      await _repo.createReview(bookId, rating, comment);
      await fetchReviews(); // refresh list setelah create
    } catch (e) {
      state = state.copyWith(error: e.toString(), isLoading: false);
    }
  }

  Future<void> updateReview(int reviewId, int rating, String? comment) async {
    try {
      state = state.copyWith(isLoading: true, error: null);
      await _repo.updateReview(reviewId, rating, comment);
      await fetchReviews(); // refresh list setelah update
    } catch (e) {
      state = state.copyWith(error: e.toString(), isLoading: false);
    }
  }

  Future<void> deleteReview(int reviewId) async {
    try {
      state = state.copyWith(isLoading: true, error: null);
      await _repo.deleteReview(reviewId);
      await fetchReviews(); // refresh list setelah delete
    } catch (e) {
      state = state.copyWith(error: e.toString(), isLoading: false);
    }
  }
}

// Provider untuk ReviewRepository
final reviewRepositoryProvider = Provider<ReviewRepository>((ref) {
  return ReviewRepository();
});

// Family provider untuk ReviewNotifier berdasar bookId
final reviewNotifierProvider = StateNotifierProvider.family<ReviewNotifier, ReviewState, int>((ref, bookId) {
  final repo = ref.read(reviewRepositoryProvider);
  return ReviewNotifier(repo, bookId);
});
