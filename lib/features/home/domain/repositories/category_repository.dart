/// Category Repository Abstract Interface
/// Defines the contract for category data access
library;

import '../models/category.dart';

abstract class CategoryRepository {
  /// Get all categories
  Future<List<Category>> getAllCategories();

  /// Get featured categories
  Future<List<Category>> getFeaturedCategories();

  /// Get category by ID
  Future<Category?> getCategoryById(String id);
}
