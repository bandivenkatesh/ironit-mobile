/// Mock Category Repository Implementation
/// Provides mock data for category operations
library;

import '../../domain/models/category.dart';
import '../../domain/repositories/category_repository.dart';
import '../mock/categories.dart';

class MockCategoryRepository implements CategoryRepository {
  @override
  Future<List<Category>> getAllCategories() async {
    // Simulate network delay
    await Future<void>.delayed(const Duration(milliseconds: 300));
    return MockCategories.getAllCategories();
  }

  @override
  Future<List<Category>> getFeaturedCategories() async {
    // Simulate network delay
    await Future<void>.delayed(const Duration(milliseconds: 200));
    return MockCategories.getFeaturedCategories();
  }

  @override
  Future<Category?> getCategoryById(String id) async {
    // Simulate network delay
    await Future<void>.delayed(const Duration(milliseconds: 150));
    return MockCategories.getCategoryById(id);
  }
}
