/// ServiceOption domain model
/// Represents an optional add-on or customization for a service
class ServiceOption {
  final String id;
  final String serviceId;
  final String name;
  final String description;
  final double price;
  final bool isSelected;
  final String type;

  const ServiceOption({
    required this.id,
    required this.serviceId,
    required this.name,
    this.description = '',
    this.price = 0.0,
    this.isSelected = false,
    this.type = 'addon',
  });

  /// Create a copy of this service option with optional updates
  ServiceOption copyWith({
    String? id,
    String? serviceId,
    String? name,
    String? description,
    double? price,
    bool? isSelected,
    String? type,
  }) {
    return ServiceOption(
      id: id ?? this.id,
      serviceId: serviceId ?? this.serviceId,
      name: name ?? this.name,
      description: description ?? this.description,
      price: price ?? this.price,
      isSelected: isSelected ?? this.isSelected,
      type: type ?? this.type,
    );
  }

  /// Convert service option to map for serialization
  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'serviceId': serviceId,
      'name': name,
      'description': description,
      'price': price,
      'isSelected': isSelected,
      'type': type,
    };
  }

  /// Create service option from map
  factory ServiceOption.fromMap(Map<String, dynamic> map) {
    return ServiceOption(
      id: map['id'] as String,
      serviceId: map['serviceId'] as String,
      name: map['name'] as String,
      description: map['description'] as String? ?? '',
      price: (map['price'] as num).toDouble(),
      isSelected: map['isSelected'] as bool? ?? false,
      type: map['type'] as String? ?? 'addon',
    );
  }

  /// Equality comparison
  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is ServiceOption &&
        other.id == id &&
        other.serviceId == serviceId &&
        other.name == name &&
        other.description == description &&
        other.price == price &&
        other.isSelected == isSelected &&
        other.type == type;
  }

  /// Hash code for service option
  @override
  int get hashCode {
    return id.hashCode ^
        serviceId.hashCode ^
        name.hashCode ^
        description.hashCode ^
        price.hashCode ^
        isSelected.hashCode ^
        type.hashCode;
  }

  /// Sample service options for ironing services
  static List<ServiceOption> ironingOptions() {
    return <ServiceOption>[
      ServiceOption(
        id: 'option-1',
        serviceId: 'service-1',
        name: 'Number of Clothes',
        description: 'Select the number of clothes to be ironed',
        price: 0.0,
        type: 'quantity',
      ),
      ServiceOption(
        id: 'option-2',
        serviceId: 'service-1',
        name: 'Express Service',
        description: 'Priority processing with faster delivery',
        price: 199.0,
        type: 'addon',
      ),
      ServiceOption(
        id: 'option-3',
        serviceId: 'service-1',
        name: 'Folding Option',
        description: 'Professional folding and packaging',
        price: 99.0,
        type: 'addon',
      ),
      ServiceOption(
        id: 'option-4',
        serviceId: 'service-1',
        name: 'Stain Treatment',
        description: 'Pre-treatment for tough stains',
        price: 149.0,
        type: 'addon',
      ),
      ServiceOption(
        id: 'option-5',
        serviceId: 'service-1',
        name: 'Pickup & Drop',
        description: 'Free pickup and drop service',
        price: 0.0,
        type: 'service',
      ),
    ];
  }
}
