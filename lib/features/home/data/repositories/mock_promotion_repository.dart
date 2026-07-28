/// Mock Promotion Repository Implementation
/// Provides mock data for promotion operations
library;

import '../../domain/models/promotion.dart';
import '../../domain/repositories/promotion_repository.dart';
import '../mock/promotions.dart';

class MockPromotionRepository implements PromotionRepository {
  @override
  Future<List<Promotion>> getAllPromotions() async {
    // Simulate network delay
    await Future<void>.delayed(const Duration(milliseconds: 250));
    return MockPromotions.getAllPromotions();
  }

  @override
  Future<List<Promotion>> getActivePromotions() async {
    // Simulate network delay
    await Future<void>.delayed(const Duration(milliseconds: 200));
    return MockPromotions.getActivePromotions();
  }

  @override
  Future<Promotion?> getPromotionById(String id) async {
    // Simulate network delay
    await Future<void>.delayed(const Duration(milliseconds: 150));
    return MockPromotions.getPromotionById(id);
  }
}
