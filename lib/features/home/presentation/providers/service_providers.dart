/// Service Providers for Riverpod
/// Manages service-related state using mock repositories
library;

import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../data/repositories/mock_service_repository.dart';
import '../../domain/models/service.dart';
import '../../domain/repositories/service_repository.dart';

/// Service Repository Provider
final Provider<ServiceRepository> serviceRepositoryProvider =
    Provider<ServiceRepository>((Ref ref) {
  return MockServiceRepository();
});

/// All Services Provider
final FutureProvider<List<Service>> allServicesProvider =
    FutureProvider<List<Service>>((Ref ref) async {
  final ServiceRepository repository = ref.watch(serviceRepositoryProvider);
  return repository.getAllServices();
});

/// Featured Services Provider
final FutureProvider<List<Service>> featuredServicesProvider =
    FutureProvider<List<Service>>((Ref ref) async {
  final ServiceRepository repository = ref.watch(serviceRepositoryProvider);
  return repository.getFeaturedServices();
});

/// Popular Services Provider
final FutureProvider<List<Service>> popularServicesProvider =
    FutureProvider<List<Service>>((Ref ref) async {
  final ServiceRepository repository = ref.watch(serviceRepositoryProvider);
  return repository.getPopularServices();
});

/// Search Services Provider
final FutureProviderFamily<List<Service>, String> searchServicesProvider =
    FutureProviderFamily<List<Service>, String>((Ref ref, String query) async {
  final ServiceRepository repository = ref.watch(serviceRepositoryProvider);
  return repository.searchServices(query);
});

/// Service by ID Provider
final FutureProviderFamily<Service?, String> serviceByIdProvider =
    FutureProviderFamily<Service?, String>((Ref ref, String id) async {
  final ServiceRepository repository = ref.watch(serviceRepositoryProvider);
  return repository.getServiceById(id);
});
