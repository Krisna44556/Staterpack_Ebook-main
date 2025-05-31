import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../domain/review_provider.dart';
import '../../../models/review_model.dart';

class ReviewSection extends ConsumerWidget {
  final int bookId;

  const ReviewSection({Key? key, required this.bookId}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(reviewNotifierProvider(bookId));
    final notifier = ref.read(reviewNotifierProvider(bookId).notifier);

    if (state.isLoading) {
      return const Center(child: CircularProgressIndicator());
    }

    if (state.error != null) {
      return Text('Error: ${state.error}', style: const TextStyle(color: Colors.red));
    }

    final reviews = state.reviews;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Reviews', style: Theme.of(context).textTheme.headline6),
        const SizedBox(height: 8),
        if (reviews.isEmpty)
          const Text('No reviews yet.')
        else
          ...reviews.map(
            (review) => ListTile(
              title: Text(review.userName),
              subtitle: Text(review.comment ?? ''),
              trailing: Text('${review.rating}/5'),
            ),
          ),
        const SizedBox(height: 16),

        // Contoh tombol tambah review (bisa diganti form input)
        ElevatedButton(
          onPressed: () async {
            // Contoh create review fixed rating 5 dan komentar
            await notifier.createReview(5, 'Great book!');
            // Setelah submit, otomatis fetchReviews dipanggil di createReview
          },
          child: const Text('Add Review'),
        ),
      ],
    );
  }
}
