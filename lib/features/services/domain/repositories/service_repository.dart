/// Service Repository Interface for Services Feature
/// Provides access to service data for browsing and filtering
library;

import '../../../home/domain/models/service.dart';

abstract class ServiceRepository {
  /// Get all services
  Future<List<Service>> getAllServices();

  /// Get services by category
  Future<List<Service>> getServicesByCategory(String categoryId);

  /// Search services by query
  Future<List<Service>> searchServices(String query);

  /// Get featured services
  Future<List<Service>> getFeaturedServices();

  /// Get service by ID
  Future<Service?> getServiceById(String id);
}
