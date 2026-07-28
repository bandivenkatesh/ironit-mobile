/// Service domain model
/// Represents an ironing service offered by Ironit
class Service {
  final String id;
  final String name;
  final String categoryId;
  final String description;
  final double price;
  final double rating;
  final int reviewCount;
  final String imageUrl;
  final Duration estimatedDuration;
  final bool isFeatured;
  final bool isPopular;
  final DateTime createdAt;

  const Service({
    required this.id,
    required this.name,
    required this.categoryId,
    required this.description,
    required this.price,
    required this.rating,
    required this.reviewCount,
    required this.imageUrl,
    required this.estimatedDuration,
    this.isFeatured = false,
    this.isPopular = false,
    required this.createdAt,
  });

  /// Create a copy of this service with optional updates
  Service copyWith({
    String? id,
    String? name,
    String? categoryId,
    String? description,
    double? price,
    double? rating,
    int? reviewCount,
    String? imageUrl,
    Duration? estimatedDuration,
    bool? isFeatured,
    bool? isPopular,
    DateTime? createdAt,
  }) {
    return Service(
      id: id ?? this.id,
      name: name ?? this.name,
      categoryId: categoryId ?? this.categoryId,
      description: description ?? this.description,
      price: price ?? this.price,
      rating: rating ?? this.rating,
      reviewCount: reviewCount ?? this.reviewCount,
      imageUrl: imageUrl ?? this.imageUrl,
      estimatedDuration: estimatedDuration ?? this.estimatedDuration,
      isFeatured: isFeatured ?? this.isFeatured,
      isPopular: isPopular ?? this.isPopular,
      createdAt: createdAt ?? this.createdAt,
    );
  }

  /// Convert service to map for serialization
  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'name': name,
      'categoryId': categoryId,
      'description': description,
      'price': price,
      'rating': rating,
      'reviewCount': reviewCount,
      'imageUrl': imageUrl,
      'estimatedDuration': estimatedDuration.inMilliseconds,
      'isFeatured': isFeatured,
      'isPopular': isPopular,
      'createdAt': createdAt.millisecondsSinceEpoch,
    };
  }

  /// Create service from map
  factory Service.fromMap(Map<String, dynamic> map) {
    return Service(
      id: map['id'] as String,
      name: map['name'] as String,
      categoryId: map['categoryId'] as String,
      description: map['description'] as String,
      price: (map['price'] as num).toDouble(),
      rating: (map['rating'] as num).toDouble(),
      reviewCount: map['reviewCount'] as int,
      imageUrl: map['imageUrl'] as String,
      estimatedDuration: Duration(milliseconds: map['estimatedDuration'] as int),
      isFeatured: map['isFeatured'] as bool? ?? false,
      isPopular: map['isPopular'] as bool? ?? false,
      createdAt: DateTime.fromMillisecondsSinceEpoch(map['createdAt'] as int),
    );
  }

  /// Equality comparison
  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is Service &&
      other.id == id &&
      other.name == name &&
      other.categoryId == categoryId &&
      other.description == description &&
      other.price == price &&
      other.rating == rating &&
      other.reviewCount == reviewCount &&
      other.imageUrl == imageUrl &&
      other.estimatedDuration == estimatedDuration &&
      other.isFeatured == isFeatured &&
      other.isPopular == isPopular &&
      other.createdAt == createdAt;
  }

  /// Hash code for service
  @override
  int get hashCode {
    return id.hashCode ^
      name.hashCode ^
      categoryId.hashCode ^
      description.hashCode ^
      price.hashCode ^
      rating.hashCode ^
      reviewCount.hashCode ^
      imageUrl.hashCode ^
      estimatedDuration.hashCode ^
      isFeatured.hashCode ^
      isPopular.hashCode ^
      createdAt.hashCode;
  }

  /// Sample factory for testing
  factory Service.sample() {
    return Service(
      id: 'sample-service-1',
      name: 'Premium Shirt Ironing',
      categoryId: 'ironing',
      description: 'Professional ironing service for shirts with premium finish',
      price: 299.0,
      rating: 4.8,
      reviewCount: 128,
      imageUrl: 'https://example.com/images/shirt-ironing.jpg',
      estimatedDuration: const Duration(minutes: 30),
      isFeatured: true,
      isPopular: true,
      createdAt: DateTime.now(),
    );
  }

  /// Sample list of services for testing
  static List<Service> samples() {
    return [
      Service(
        id: 'service-1',
        name: 'Premium Shirt Ironing',
        categoryId: 'ironing',
        description: 'Professional ironing service for shirts with premium finish',
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
        categoryId: 'ironing',
        description: 'Perfect creases for formal trousers and pants',
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
        categoryId: 'ironing',
        description: 'Delicate steaming for business suits to maintain fabric quality',
        price: 799.0,
        rating: 4.9,
        reviewCount: 210,
        imageUrl: 'https://example.com/images/suit-steaming.jpg',
        estimatedDuration: const Duration(minutes: 45),
        isFeatured: false,
        isPopular: true,
        createdAt: DateTime.now(),
      ),
    ];
  }
}