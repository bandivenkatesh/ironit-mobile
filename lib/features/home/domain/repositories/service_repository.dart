/// Service Repository Abstract Interface
/// Defines the contract for service data access
import '../models/service.dart';

abstract class ServiceRepository {
  /// Get all services
  Future<List<Service>> getAllServices();

  /// Get featured services
  Future<List<Service>> getFeaturedServices();

  /// Get popular services
  Future<List<Service>> getPopularServices();

  /// Get services by category
  Future<List<Service>> getServicesByCategory(String categoryId);

  /// Search services by query
  Future<List<Service>> searchServices(String query);

  /// Get service by ID
  Future<Service?> getServiceById(String id);
}