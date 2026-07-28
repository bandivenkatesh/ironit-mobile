/// Mock Service Repository Implementation
/// Provides mock data for service operations
import '../../domain/models/service.dart';
import '../../domain/repositories/service_repository.dart';
import '../mock/services.dart';

class MockServiceRepository implements ServiceRepository {
  @override
  Future<List<Service>> getAllServices() async {
    // Simulate network delay
    await Future<void>.delayed(const Duration(milliseconds: 500));
    return MockServices.getAllServices();
  }

  @override
  Future<List<Service>> getFeaturedServices() async {
    // Simulate network delay
    await Future<void>.delayed(const Duration(milliseconds: 300));
    return MockServices.getFeaturedServices();
  }

  @override
  Future<List<Service>> getPopularServices() async {
    // Simulate network delay
    await Future<void>.delayed(const Duration(milliseconds: 300));
    return MockServices.getPopularServices();
  }

  @override
  Future<List<Service>> getServicesByCategory(String categoryId) async {
    // Simulate network delay
    await Future<void>.delayed(const Duration(milliseconds: 400));
    return MockServices.getServicesByCategory(categoryId);
  }

  @override
  Future<List<Service>> searchServices(String query) async {
    // Simulate network delay
    await Future<void>.delayed(const Duration(milliseconds: 600));
    return MockServices.searchServices(query);
  }

  @override
  Future<Service?> getServiceById(String id) async {
    // Simulate network delay
    await Future<void>.delayed(const Duration(milliseconds: 200));
    return MockServices.getServiceById(id);
  }
}