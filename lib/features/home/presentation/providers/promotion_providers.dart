/// Promotion Providers for Riverpod
/// Manages promotion-related state using mock repositories
library;

import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../data/repositories/mock_promotion_repository.dart';
import '../../domain/models/promotion.dart';
import '../../domain/repositories/promotion_repository.dart';

/// Promotion Repository Provider
final Provider<PromotionRepository> promotionRepositoryProvider =
    Provider<PromotionRepository>((Ref ref) {
  return MockPromotionRepository();
});

/// All Promotions Provider
final FutureProvider<List<Promotion>> allPromotionsProvider =
    FutureProvider<List<Promotion>>((Ref ref) async {
  final PromotionRepository repository = ref.watch(promotionRepositoryProvider);
  return repository.getAllPromotions();
});

/// Active Promotions Provider
final FutureProvider<List<Promotion>> activePromotionsProvider =
    FutureProvider<List<Promotion>>((Ref ref) async {
  final PromotionRepository repository = ref.watch(promotionRepositoryProvider);
  return repository.getActivePromotions();
});

/// Promotion by ID Provider
final FutureProviderFamily<Promotion?, String> promotionByIdProvider =
    FutureProviderFamily<Promotion?, String>((Ref ref, String id) async {
  final PromotionRepository repository = ref.watch(promotionRepositoryProvider);
  return repository.getPromotionById(id);
});
