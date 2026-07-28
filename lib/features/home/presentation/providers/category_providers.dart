/// Category Providers for Riverpod
/// Manages category-related state using mock repositories
library;

import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../data/repositories/mock_category_repository.dart';
import '../../domain/models/category.dart';
import '../../domain/repositories/category_repository.dart';

/// Category Repository Provider
final Provider<CategoryRepository> categoryRepositoryProvider =
    Provider<CategoryRepository>((Ref ref) {
  return MockCategoryRepository();
});

/// All Categories Provider
final FutureProvider<List<Category>> allCategoriesProvider =
    FutureProvider<List<Category>>((Ref ref) async {
  final CategoryRepository repository = ref.watch(categoryRepositoryProvider);
  return repository.getAllCategories();
});

/// Featured Categories Provider
final FutureProvider<List<Category>> featuredCategoriesProvider =
    FutureProvider<List<Category>>((Ref ref) async {
  final CategoryRepository repository = ref.watch(categoryRepositoryProvider);
  return repository.getFeaturedCategories();
});

/// Category by ID Provider
final FutureProviderFamily<Category?, String> categoryByIdProvider =
    FutureProviderFamily<Category?, String>((Ref ref, String id) async {
  final CategoryRepository repository = ref.watch(categoryRepositoryProvider);
  return repository.getCategoryById(id);
});
