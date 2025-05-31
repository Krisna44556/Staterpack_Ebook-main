import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../models/category_model.dart';
import '../domain/category_provider.dart'; // pastikan path sesuai

typedef CategorySelectedCallback = void Function(CategoryModel? selectedCategory);

class CategoryFilterWidget extends ConsumerWidget {
  final CategoryModel? selectedCategory;
  final CategorySelectedCallback onCategorySelected;

  const CategoryFilterWidget({
    Key? key,
    this.selectedCategory,
    required this.onCategorySelected,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final categoriesAsync = ref.watch(categoriesProvider);

    return categoriesAsync.when(
      data: (categories) {
        return SizedBox(
          height: 40,
          child: ListView.separated(
            scrollDirection: Axis.horizontal,
            padding: const EdgeInsets.symmetric(horizontal: 16),
            itemCount: categories.length + 1,
            separatorBuilder: (_, __) => const SizedBox(width: 8),
            itemBuilder: (context, index) {
              if (index == 0) {
                final bool isSelected = selectedCategory == null;
                return ChoiceChip(
                  label: const Text('Semua'),
                  selected: isSelected,
                  onSelected: (_) => onCategorySelected(null),
                );
              }

              final category = categories[index - 1];
              final bool isSelected = selectedCategory?.id == category.id;

              return ChoiceChip(
                label: Text(category.name),
                selected: isSelected,
                onSelected: (_) => onCategorySelected(category),
              );
            },
          ),
        );
      },
      loading: () => const Center(child: CircularProgressIndicator()),
      error: (error, _) => Center(child: Text('Gagal memuat kategori: $error')),
    );
  }
}
