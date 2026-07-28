/// Category domain model
/// Represents a service category in Ironit
class Category {
  final String id;
  final String name;
  final String description;
  final String icon;
  final String imageUrl;
  final int serviceCount;
  final bool isFeatured;

  const Category({
    required this.id,
    required this.name,
    required this.description,
    required this.icon,
    required this.imageUrl,
    required this.serviceCount,
    this.isFeatured = false,
  });

  /// Create a copy of this category with optional updates
  Category copyWith({
    String? id,
    String? name,
    String? description,
    String? icon,
    String? imageUrl,
    int? serviceCount,
    bool? isFeatured,
  }) {
    return Category(
      id: id ?? this.id,
      name: name ?? this.name,
      description: description ?? this.description,
      icon: icon ?? this.icon,
      imageUrl: imageUrl ?? this.imageUrl,
      serviceCount: serviceCount ?? this.serviceCount,
      isFeatured: isFeatured ?? this.isFeatured,
    );
  }

  /// Convert category to map for serialization
  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'name': name,
      'description': description,
      'icon': icon,
      'imageUrl': imageUrl,
      'serviceCount': serviceCount,
      'isFeatured': isFeatured,
    };
  }

  /// Create category from map
  factory Category.fromMap(Map<String, dynamic> map) {
    return Category(
      id: map['id'] as String,
      name: map['name'] as String,
      description: map['description'] as String,
      icon: map['icon'] as String,
      imageUrl: map['imageUrl'] as String,
      serviceCount: map['serviceCount'] as int,
      isFeatured: map['isFeatured'] as bool? ?? false,
    );
  }

  /// Equality comparison
  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is Category &&
        other.id == id &&
        other.name == name &&
        other.description == description &&
        other.icon == icon &&
        other.imageUrl == imageUrl &&
        other.serviceCount == serviceCount &&
        other.isFeatured == isFeatured;
  }

  /// Hash code for category
  @override
  int get hashCode {
    return id.hashCode ^
        name.hashCode ^
        description.hashCode ^
        icon.hashCode ^
        imageUrl.hashCode ^
        serviceCount.hashCode ^
        isFeatured.hashCode;
  }

  /// Sample factory for testing
  factory Category.sample() {
    return const Category(
      id: 'category-1',
      name: 'Shirt Ironing',
      description: 'Premium ironing services for all types of shirts',
      icon: 'shirt',
      imageUrl: 'https://example.com/images/shirt-category.jpg',
      serviceCount: 12,
      isFeatured: true,
    );
  }

  /// Sample list of categories for testing
  static List<Category> samples() {
    return <Category>[
      const Category(
        id: 'category-1',
        name: 'Shirt Ironing',
        description: 'Premium ironing services for all types of shirts',
        icon: 'shirt',
        imageUrl: 'https://example.com/images/shirt-category.jpg',
        serviceCount: 12,
        isFeatured: true,
      ),
      const Category(
        id: 'category-2',
        name: 'Formal Wear',
        description:
            'Specialized ironing for suits, dresses, and formal attire',
        icon: 'suit',
        imageUrl: 'https://example.com/images/formal-category.jpg',
        serviceCount: 8,
        isFeatured: true,
      ),
      const Category(
        id: 'category-3',
        name: 'Casual Wear',
        description:
            'Everyday ironing for t-shirts, jeans, and casual clothing',
        icon: 'tshirt',
        imageUrl: 'https://example.com/images/casual-category.jpg',
        serviceCount: 15,
        isFeatured: false,
      ),
      const Category(
        id: 'category-4',
        name: 'Delicate Fabrics',
        description: 'Gentle steaming for silk, lace, and delicate materials',
        icon: 'fabric',
        imageUrl: 'https://example.com/images/delicate-category.jpg',
        serviceCount: 6,
        isFeatured: false,
      ),
      const Category(
        id: 'category-5',
        name: 'Household Linens',
        description:
            'Ironing services for bed sheets, tablecloths, and curtains',
        icon: 'bed',
        imageUrl: 'https://example.com/images/linens-category.jpg',
        serviceCount: 10,
        isFeatured: true,
      ),
      const Category(
        id: 'category-6',
        name: 'Business Attire',
        description:
            'Professional ironing for office wear and business clothing',
        icon: 'briefcase',
        imageUrl: 'https://example.com/images/business-category.jpg',
        serviceCount: 9,
        isFeatured: false,
      ),
    ];
  }
}
