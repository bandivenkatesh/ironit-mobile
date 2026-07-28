/// Promotion Providers for Riverpod
/// Manages promotion-related state using mock repositories
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../data/repositories/mock_promotion_repository.dart';
import '../../domain/models/promotion.dart';
import '../../domain/repositories/promotion_repository.dart';

/// Promotion Repository Provider
final promotionRepositoryProvider = Provider<PromotionRepository>((ref) {
  return MockPromotionRepository();
});

/// All Promotions Provider
final allPromotionsProvider = FutureProvider<List<Promotion>>((ref) async {
  final repository = ref.watch(promotionRepositoryProvider);
  return repository.getAllPromotions();
});

/// Active Promotions Provider
final activePromotionsProvider = FutureProvider<List<Promotion>>((ref) async {
  final repository = ref.watch(promotionRepositoryProvider);
  return repository.getActivePromotions();
});

/// Promotion by ID Provider
final promotionByIdProvider = FutureProvider.family<Promotion?, String>((ref, id) async {
  final repository = ref.watch(promotionRepositoryProvider);
  return repository.getPromotionById(id);
});