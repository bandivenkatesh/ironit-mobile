/// Promotion Repository Abstract Interface
/// Defines the contract for promotion data access
import '../models/promotion.dart';

abstract class PromotionRepository {
  /// Get all promotions
  Future<List<Promotion>> getAllPromotions();

  /// Get active promotions
  Future<List<Promotion>> getActivePromotions();

  /// Get promotion by ID
  Future<Promotion?> getPromotionById(String id);
}