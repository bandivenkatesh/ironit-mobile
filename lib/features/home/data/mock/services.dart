/// Mock services data for Ironit
/// Provides sample service data for development and testing
import '../../domain/models/service.dart';

class MockServices {
  /// Get all mock services
  static List<Service> getAllServices() {
    return [
      Service(
        id: 'service-1',
        name: 'Premium Shirt Ironing',
        categoryId: 'category-1',
        description: 'Professional ironing service for shirts with premium finish and crisp creases. Includes collar and cuff treatment.',
        price: 299.0,
        rating: 4.8,
        reviewCount: 128,
        imageUrl: 'https://example.com/images/shirt-ironing.jpg',
        estimatedDuration: const Duration(minutes: 30),
        isFeatured: true,
        isPopular: true,
        createdAt: DateTime.now(),
      ),
      Service(
        id: 'service-2',
        name: 'Formal Trousers Pressing',
        categoryId: 'category-2',
        description: 'Perfect creases for formal trousers and pants. Includes steam treatment for wrinkle-free finish.',
        price: 399.0,
        rating: 4.7,
        reviewCount: 95,
        imageUrl: 'https://example.com/images/trousers-pressing.jpg',
        estimatedDuration: const Duration(minutes: 25),
        isFeatured: true,
        isPopular: false,
        createdAt: DateTime.now(),
      ),
      Service(
        id: 'service-3',
        name: 'Business Suit Steaming',
        categoryId: 'category-2',
        description: 'Delicate steaming for business suits to maintain fabric quality and remove wrinkles without direct heat.',
        price: 799.0,
        rating: 4.9,
        reviewCount: 210,
        imageUrl: 'https://example.com/images/suit-steaming.jpg',
        estimatedDuration: const Duration(minutes: 45),
        isFeatured: false,
        isPopular: true,
        createdAt: DateTime.now(),
      ),
      Service(
        id: 'service-4',
        name: 'Casual T-Shirt Ironing',
        categoryId: 'category-3',
        description: 'Quick and affordable ironing for casual t-shirts and polo shirts. Perfect for everyday wear.',
        price: 199.0,
        rating: 4.5,
        reviewCount: 87,
        imageUrl: 'https://example.com/images/tshirt-ironing.jpg',
        estimatedDuration: const Duration(minutes: 20),
        isFeatured: false,
        isPopular: false,
        createdAt: DateTime.now(),
      ),
      Service(
        id: 'service-5',
        name: 'Jeans Pressing',
        categoryId: 'category-3',
        description: 'Specialized pressing for jeans to maintain shape and create sharp creases without damaging fabric.',
        price: 249.0,
        rating: 4.6,
        reviewCount: 63,
        imageUrl: 'https://example.com/images/jeans-pressing.jpg',
        estimatedDuration: const Duration(minutes: 25),
        isFeatured: false,
        isPopular: false,
        createdAt: DateTime.now(),
      ),
      Service(
        id: 'service-6',
        name: 'Silk Dress Steaming',
        categoryId: 'category-4',
        description: 'Gentle steaming for delicate silk dresses and blouses. Preserves fabric integrity while removing wrinkles.',
        price: 899.0,
        rating: 4.9,
        reviewCount: 142,
        imageUrl: 'https://example.com/images/silk-steaming.jpg',
        estimatedDuration: const Duration(minutes: 50),
        isFeatured: true,
        isPopular: true,
        createdAt: DateTime.now(),
      ),
      Service(
        id: 'service-7',
        name: 'Bed Sheets Ironing',
        categoryId: 'category-5',
        description: 'Professional ironing for bed sheets with hospital corners and crisp finish. Available for all sizes.',
        price: 499.0,
        rating: 4.7,
        reviewCount: 115,
        imageUrl: 'https://example.com/images/sheets-ironing.jpg',
        estimatedDuration: const Duration(minutes: 60),
        isFeatured: false,
        isPopular: true,
        createdAt: DateTime.now(),
      ),
      Service(
        id: 'service-8',
        name: 'Tablecloth Ironing',
        categoryId: 'category-5',
        description: 'Large tablecloth ironing with perfect creases and stain treatment options. Ideal for events and restaurants.',
        price: 799.0,
        rating: 4.8,
        reviewCount: 48,
        imageUrl: 'https://example.com/images/tablecloth-ironing.jpg',
        estimatedDuration: const Duration(minutes: 90),
        isFeatured: false,
        isPopular: false,
        createdAt: DateTime.now(),
      ),
    ];
  }

  /// Get featured services
  static List<Service> getFeaturedServices() {
    return getAllServices().where((service) => service.isFeatured).toList();
  }

  /// Get popular services
  static List<Service> getPopularServices() {
    return getAllServices().where((service) => service.isPopular).toList();
  }

  /// Get services by category
  static List<Service> getServicesByCategory(String categoryId) {
    return getAllServices().where((service) => service.categoryId == categoryId).toList();
  }

  /// Search services by name or description
  static List<Service> searchServices(String query) {
    if (query.isEmpty) return getAllServices();

    final lowerQuery = query.toLowerCase();
    return getAllServices().where((service) {
      return service.name.toLowerCase().contains(lowerQuery) ||
          service.description.toLowerCase().contains(lowerQuery);
    }).toList();
  }

  /// Get service by ID
  static Service? getServiceById(String id) {
    try {
      return getAllServices().firstWhere((service) => service.id == id);
    } catch (e) {
      return null;
    }
  }
}