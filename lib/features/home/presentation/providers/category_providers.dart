/// Category Providers for Riverpod
/// Manages category-related state using mock repositories
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../data/repositories/mock_category_repository.dart';
import '../../domain/models/category.dart';
import '../../domain/repositories/category_repository.dart';

/// Category Repository Provider
final categoryRepositoryProvider = Provider<CategoryRepository>((ref) {
  return MockCategoryRepository();
});

/// All Categories Provider
final allCategoriesProvider = FutureProvider<List<Category>>((ref) async {
  final repository = ref.watch(categoryRepositoryProvider);
  return repository.getAllCategories();
});

/// Featured Categories Provider
final featuredCategoriesProvider = FutureProvider<List<Category>>((ref) async {
  final repository = ref.watch(categoryRepositoryProvider);
  return repository.getFeaturedCategories();
});

/// Category by ID Provider
final categoryByIdProvider = FutureProvider.family<Category?, String>((ref, id) async {
  final repository = ref.watch(categoryRepositoryProvider);
  return repository.getCategoryById(id);
});