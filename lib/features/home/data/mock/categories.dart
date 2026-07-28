/// Mock categories data for Ironit
/// Provides sample category data for development and testing
import '../../domain/models/category.dart';

class MockCategories {
  /// Get all mock categories
  static List<Category> getAllCategories() {
    return [
      Category(
        id: 'category-1',
        name: 'Shirt Ironing',
        description: 'Premium ironing services for all types of shirts including formal, casual, and business shirts',
        icon: 'shirt',
        imageUrl: 'https://example.com/images/shirt-category.jpg',
        serviceCount: 12,
        isFeatured: true,
      ),
      Category(
        id: 'category-2',
        name: 'Formal Wear',
        description: 'Specialized ironing for suits, dresses, and formal attire with delicate fabric care',
        icon: 'suit',
        imageUrl: 'https://example.com/images/formal-category.jpg',
        serviceCount: 8,
        isFeatured: true,
      ),
      Category(
        id: 'category-3',
        name: 'Casual Wear',
        description: 'Everyday ironing for t-shirts, jeans, and casual clothing with quick turnaround',
        icon: 'tshirt',
        imageUrl: 'https://example.com/images/casual-category.jpg',
        serviceCount: 15,
        isFeatured: false,
      ),
      Category(
        id: 'category-4',
        name: 'Delicate Fabrics',
        description: 'Gentle steaming for silk, lace, and delicate materials that require special care',
        icon: 'fabric',
        imageUrl: 'https://example.com/images/delicate-category.jpg',
        serviceCount: 6,
        isFeatured: false,
      ),
      Category(
        id: 'category-5',
        name: 'Household Linens',
        description: 'Ironing services for bed sheets, tablecloths, curtains, and other household fabrics',
        icon: 'bed',
        imageUrl: 'https://example.com/images/linens-category.jpg',
        serviceCount: 10,
        isFeatured: true,
      ),
      Category(
        id: 'category-6',
        name: 'Business Attire',
        description: 'Professional ironing for office wear and business clothing with express service options',
        icon: 'briefcase',
        imageUrl: 'https://example.com/images/business-category.jpg',
        serviceCount: 9,
        isFeatured: false,
      ),
      Category(
        id: 'category-7',
        name: 'Special Occasions',
        description: 'Premium ironing for wedding dresses, gowns, and special event attire',
        icon: 'dress',
        imageUrl: 'https://example.com/images/special-category.jpg',
        serviceCount: 4,
        isFeatured: true,
      ),
      Category(
        id: 'category-8',
        name: 'Children\'s Clothing',
        description: 'Gentle ironing for children\'s clothing with hypoallergenic options available',
        icon: 'child',
        imageUrl: 'https://example.com/images/children-category.jpg',
        serviceCount: 7,
        isFeatured: false,
      ),
    ];
  }

  /// Get featured categories
  static List<Category> getFeaturedCategories() {
    return getAllCategories().where((category) => category.isFeatured).toList();
  }

  /// Get category by ID
  static Category? getCategoryById(String id) {
    try {
      return getAllCategories().firstWhere((category) => category.id == id);
    } catch (e) {
      return null;
    }
  }
}