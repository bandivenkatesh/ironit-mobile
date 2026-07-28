/// Service Providers for Services Feature
/// Manages service-related state for browsing and filtering
library;

import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../data/repositories/mock_service_repository.dart';
import '../../domain/repositories/service_repository.dart';
import '../../../home/domain/models/service.dart';

/// Service Repository Provider for Services Feature
final Provider<ServiceRepository> servicesRepositoryProvider =
    Provider<ServiceRepository>((Ref ref) {
  return MockServiceRepository();
});

/// All Services Provider
final FutureProvider<List<Service>> allServicesProvider =
    FutureProvider<List<Service>>((Ref ref) async {
  final ServiceRepository repository = ref.watch(servicesRepositoryProvider);
  return repository.getAllServices();
});

/// Selected Category Provider
final StateProvider<String> selectedCategoryProvider =
    StateProvider<String>((Ref ref) {
  return 'all'; // Default to 'all' category
});

/// Filtered Services Provider
final FutureProvider<List<Service>> filteredServicesProvider =
    FutureProvider<List<Service>>((Ref ref) async {
  final ServiceRepository repository = ref.watch(servicesRepositoryProvider);
  final String selectedCategory = ref.watch(selectedCategoryProvider);

  if (selectedCategory == 'all') {
    return repository.getAllServices();
  } else {
    return repository.getServicesByCategory(selectedCategory);
  }
});

/// Search Query Provider
final StateProvider<String> searchQueryProvider =
    StateProvider<String>((Ref ref) {
  return '';
});

/// Search Results Provider
final FutureProvider<List<Service>> searchResultsProvider =
    FutureProvider<List<Service>>((Ref ref) async {
  final ServiceRepository repository = ref.watch(servicesRepositoryProvider);
  final String searchQuery = ref.watch(searchQueryProvider);

  return repository.searchServices(searchQuery);
});

/// Service by ID Provider
final FutureProviderFamily<Service?, String> serviceByIdProvider =
    FutureProviderFamily<Service?, String>((Ref ref, String id) async {
  final ServiceRepository repository = ref.watch(servicesRepositoryProvider);
  return repository.getServiceById(id);
});
