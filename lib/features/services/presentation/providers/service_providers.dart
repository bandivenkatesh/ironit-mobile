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

/// Search Query Provider
final StateProvider<String> searchQueryProvider =
    StateProvider<String>((Ref ref) {
  return '';
});

/// Sort Option Provider
final StateProvider<String> sortOptionProvider =
    StateProvider<String>((Ref ref) {
  return 'default'; // Options: default, price-low-high, price-high-low, rating, duration
});

/// Combined Filtered and Sorted Services Provider
final FutureProvider<List<Service>> filteredAndSortedServicesProvider =
    FutureProvider<List<Service>>((Ref ref) async {
  final ServiceRepository repository = ref.watch(servicesRepositoryProvider);
  final String selectedCategory = ref.watch(selectedCategoryProvider);
  final String searchQuery = ref.watch(searchQueryProvider);
  final String sortOption = ref.watch(sortOptionProvider);

  // Get base services
  List<Service> services;
  if (selectedCategory == 'all') {
    services = await repository.getAllServices();
  } else {
    services = await repository.getServicesByCategory(selectedCategory);
  }

  // Apply search filter
  if (searchQuery.isNotEmpty) {
    final String lowerQuery = searchQuery.toLowerCase();
    services = services.where((Service service) {
      return service.name.toLowerCase().contains(lowerQuery) ||
          service.description.toLowerCase().contains(lowerQuery) ||
          service.categoryId.toLowerCase().contains(lowerQuery);
    }).toList();
  }

  // Apply sorting
  return _sortServices(services, sortOption);
});

/// Sort services based on the selected option
List<Service> _sortServices(List<Service> services, String sortOption) {
  switch (sortOption) {
    case 'price-low-high':
      return services
        ..sort((Service a, Service b) => a.price.compareTo(b.price));
    case 'price-high-low':
      return services
        ..sort((Service a, Service b) => b.price.compareTo(a.price));
    case 'rating':
      return services
        ..sort((Service a, Service b) => b.rating.compareTo(a.rating));
    case 'duration':
      return services
        ..sort((Service a, Service b) => a.estimatedDuration.inMinutes
            .compareTo(b.estimatedDuration.inMinutes));
    case 'default':
    default:
      // Default sorting: featured first, then popular, then by name
      return services
        ..sort((Service a, Service b) {
          if (a.isFeatured != b.isFeatured) {
            return a.isFeatured ? -1 : 1;
          }
          if (a.isPopular != b.isPopular) {
            return a.isPopular ? -1 : 1;
          }
          return a.name.compareTo(b.name);
        });
  }
}

/// Service by ID Provider
final FutureProviderFamily<Service?, String> serviceByIdProvider =
    FutureProviderFamily<Service?, String>((Ref ref, String id) async {
  final ServiceRepository repository = ref.watch(servicesRepositoryProvider);
  return repository.getServiceById(id);
});
