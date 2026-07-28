/// Mock Service Repository for Services Feature
/// Reuses existing mock data from Home feature
library;

import '../../domain/repositories/service_repository.dart';
import '../../../home/data/mock/services.dart';
import '../../../home/domain/models/service.dart';

class MockServiceRepository implements ServiceRepository {
  @override
  Future<List<Service>> getAllServices() async {
    // Simulate network delay
    await Future<void>.delayed(const Duration(milliseconds: 300));
    return MockServices.getAllServices();
  }

  @override
  Future<List<Service>> getServicesByCategory(String categoryId) async {
    // Simulate network delay
    await Future<void>.delayed(const Duration(milliseconds: 300));
    return MockServices.getServicesByCategory(categoryId);
  }

  @override
  Future<List<Service>> searchServices(String query) async {
    // Simulate network delay
    await Future<void>.delayed(const Duration(milliseconds: 300));
    return MockServices.searchServices(query);
  }

  @override
  Future<List<Service>> getFeaturedServices() async {
    // Simulate network delay
    await Future<void>.delayed(const Duration(milliseconds: 300));
    return MockServices.getFeaturedServices();
  }

  @override
  Future<Service?> getServiceById(String id) async {
    // Simulate network delay
    await Future<void>.delayed(const Duration(milliseconds: 300));
    return MockServices.getServiceById(id);
  }
}
