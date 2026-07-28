/// Address domain model
/// Represents a user address for service delivery
class Address {
  final String id;
  final String userId;
  final String addressLine1;
  final String addressLine2;
  final String city;
  final String state;
  final String postalCode;
  final String country;
  final String label;
  final bool isDefault;
  final DateTime createdAt;

  const Address({
    required this.id,
    required this.userId,
    required this.addressLine1,
    this.addressLine2 = '',
    required this.city,
    required this.state,
    required this.postalCode,
    required this.country,
    this.label = 'Home',
    this.isDefault = false,
    required this.createdAt,
  });

  /// Create a copy of this address with optional updates
  Address copyWith({
    String? id,
    String? userId,
    String? addressLine1,
    String? addressLine2,
    String? city,
    String? state,
    String? postalCode,
    String? country,
    String? label,
    bool? isDefault,
    DateTime? createdAt,
  }) {
    return Address(
      id: id ?? this.id,
      userId: userId ?? this.userId,
      addressLine1: addressLine1 ?? this.addressLine1,
      addressLine2: addressLine2 ?? this.addressLine2,
      city: city ?? this.city,
      state: state ?? this.state,
      postalCode: postalCode ?? this.postalCode,
      country: country ?? this.country,
      label: label ?? this.label,
      isDefault: isDefault ?? this.isDefault,
      createdAt: createdAt ?? this.createdAt,
    );
  }

  /// Convert address to map for serialization
  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'userId': userId,
      'addressLine1': addressLine1,
      'addressLine2': addressLine2,
      'city': city,
      'state': state,
      'postalCode': postalCode,
      'country': country,
      'label': label,
      'isDefault': isDefault,
      'createdAt': createdAt.millisecondsSinceEpoch,
    };
  }

  /// Create address from map
  factory Address.fromMap(Map<String, dynamic> map) {
    return Address(
      id: map['id'] as String,
      userId: map['userId'] as String,
      addressLine1: map['addressLine1'] as String,
      addressLine2: map['addressLine2'] as String? ?? '',
      city: map['city'] as String,
      state: map['state'] as String,
      postalCode: map['postalCode'] as String,
      country: map['country'] as String,
      label: map['label'] as String? ?? 'Home',
      isDefault: map['isDefault'] as bool? ?? false,
      createdAt: DateTime.fromMillisecondsSinceEpoch(map['createdAt'] as int),
    );
  }

  /// Equality comparison
  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is Address &&
        other.id == id &&
        other.userId == userId &&
        other.addressLine1 == addressLine1 &&
        other.addressLine2 == addressLine2 &&
        other.city == city &&
        other.state == state &&
        other.postalCode == postalCode &&
        other.country == country &&
        other.label == label &&
        other.isDefault == isDefault &&
        other.createdAt == createdAt;
  }

  /// Hash code for address
  @override
  int get hashCode {
    return id.hashCode ^
        userId.hashCode ^
        addressLine1.hashCode ^
        addressLine2.hashCode ^
        city.hashCode ^
        state.hashCode ^
        postalCode.hashCode ^
        country.hashCode ^
        label.hashCode ^
        isDefault.hashCode ^
        createdAt.hashCode;
  }

  /// Sample address for testing
  factory Address.sample() {
    return Address(
      id: 'addr-1',
      userId: 'user-1',
      addressLine1: '123 Main Street',
      addressLine2: 'Apt 4B',
      city: 'Bangalore',
      state: 'Karnataka',
      postalCode: '560001',
      country: 'India',
      label: 'Home',
      isDefault: true,
      createdAt: DateTime.now(),
    );
  }

  /// Get formatted address for display
  String get formattedAddress {
    final List<String> parts = <String>[
      addressLine1,
      if (addressLine2.isNotEmpty) addressLine2,
      city,
      state,
      postalCode,
      country,
    ];
    return parts.join(', ');
  }
}
