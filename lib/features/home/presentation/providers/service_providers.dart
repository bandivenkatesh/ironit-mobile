/// Service Providers for Riverpod
/// Manages service-related state using mock repositories
library;

import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../data/repositories/mock_service_repository.dart';
import '../../domain/models/service.dart';
import '../../domain/repositories/service_repository.dart';

/// Service Repository Provider
final serviceRepositoryProvider = Provider<ServiceRepository>((ref) {
  return MockServiceRepository();
});

/// All Services Provider
final allServicesProvider = FutureProvider<List<Service>>((ref) async {
  final repository = ref.watch(serviceRepositoryProvider);
  return repository.getAllServices();
});

/// Featured Services Provider
final featuredServicesProvider = FutureProvider<List<Service>>((ref) async {
  final repository = ref.watch(serviceRepositoryProvider);
  return repository.getFeaturedServices();
});

/// Popular Services Provider
final popularServicesProvider = FutureProvider<List<Service>>((ref) async {
  final repository = ref.watch(serviceRepositoryProvider);
  return repository.getPopularServices();
});

/// Search Services Provider
final searchServicesProvider =
    FutureProvider.family<List<Service>, String>((ref, query) async {
  final repository = ref.watch(serviceRepositoryProvider);
  return repository.searchServices(query);
});

/// Service by ID Provider
final serviceByIdProvider =
    FutureProvider.family<Service?, String>((ref, id) async {
  final repository = ref.watch(serviceRepositoryProvider);
  return repository.getServiceById(id);
});
