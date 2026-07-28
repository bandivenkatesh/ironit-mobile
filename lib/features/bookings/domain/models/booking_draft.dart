/// BookingDraft domain model
/// Represents a booking in progress with all selected options
import 'address.dart';
import 'service_option.dart';
import 'time_slot.dart';
import 'package:ironit/features/home/domain/models/service.dart';

class BookingDraft {
  final String id;
  final String userId;
  final Service service;
  final DateTime selectedDate;
  final TimeSlot? selectedTimeSlot;
  final Address? selectedAddress;
  final List<ServiceOption> selectedOptions;
  final String notes;
  final DateTime createdAt;
  final DateTime updatedAt;

  const BookingDraft({
    required this.id,
    required this.userId,
    required this.service,
    required this.selectedDate,
    this.selectedTimeSlot,
    this.selectedAddress,
    this.selectedOptions = const <ServiceOption>[],
    this.notes = '',
    required this.createdAt,
    required this.updatedAt,
  });

  /// Create a copy of this booking draft with optional updates
  BookingDraft copyWith({
    String? id,
    String? userId,
    Service? service,
    DateTime? selectedDate,
    TimeSlot? selectedTimeSlot,
    Address? selectedAddress,
    List<ServiceOption>? selectedOptions,
    String? notes,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) {
    return BookingDraft(
      id: id ?? this.id,
      userId: userId ?? this.userId,
      service: service ?? this.service,
      selectedDate: selectedDate ?? this.selectedDate,
      selectedTimeSlot: selectedTimeSlot ?? this.selectedTimeSlot,
      selectedAddress: selectedAddress ?? this.selectedAddress,
      selectedOptions: selectedOptions ?? this.selectedOptions,
      notes: notes ?? this.notes,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }

  /// Convert booking draft to map for serialization
  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'userId': userId,
      'service': service.toMap(),
      'selectedDate': selectedDate.millisecondsSinceEpoch,
      'selectedTimeSlot': selectedTimeSlot?.toMap(),
      'selectedAddress': selectedAddress?.toMap(),
      'selectedOptions': selectedOptions
          .map((ServiceOption option) => option.toMap())
          .toList(),
      'notes': notes,
      'createdAt': createdAt.millisecondsSinceEpoch,
      'updatedAt': updatedAt.millisecondsSinceEpoch,
    };
  }

  /// Create booking draft from map
  factory BookingDraft.fromMap(Map<String, dynamic> map) {
    return BookingDraft(
      id: map['id'] as String,
      userId: map['userId'] as String,
      service: Service.fromMap(map['service'] as Map<String, dynamic>),
      selectedDate:
          DateTime.fromMillisecondsSinceEpoch(map['selectedDate'] as int),
      selectedTimeSlot: map['selectedTimeSlot'] != null
          ? TimeSlot.fromMap(map['selectedTimeSlot'] as Map<String, dynamic>)
          : null,
      selectedAddress: map['selectedAddress'] != null
          ? Address.fromMap(map['selectedAddress'] as Map<String, dynamic>)
          : null,
      selectedOptions: (map['selectedOptions'] as List<dynamic>?)
              ?.map((dynamic option) =>
                  ServiceOption.fromMap(option as Map<String, dynamic>))
              .toList() ??
          <ServiceOption>[],
      notes: map['notes'] as String? ?? '',
      createdAt: DateTime.fromMillisecondsSinceEpoch(map['createdAt'] as int),
      updatedAt: DateTime.fromMillisecondsSinceEpoch(map['updatedAt'] as int),
    );
  }

  /// Equality comparison
  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is BookingDraft &&
        other.id == id &&
        other.userId == userId &&
        other.service == service &&
        other.selectedDate == selectedDate &&
        other.selectedTimeSlot == selectedTimeSlot &&
        other.selectedAddress == selectedAddress &&
        listEquals(other.selectedOptions, selectedOptions) &&
        other.notes == notes &&
        other.createdAt == createdAt &&
        other.updatedAt == updatedAt;
  }

  /// Hash code for booking draft
  @override
  int get hashCode {
    return id.hashCode ^
        userId.hashCode ^
        service.hashCode ^
        selectedDate.hashCode ^
        (selectedTimeSlot?.hashCode ?? 0) ^
        (selectedAddress?.hashCode ?? 0) ^
        selectedOptions.hashCode ^
        notes.hashCode ^
        createdAt.hashCode ^
        updatedAt.hashCode;
  }

  /// Calculate total price including base service and selected options
  double get totalPrice {
    double total = service.price;
    for (final ServiceOption option in selectedOptions) {
      total += option.price;
    }
    return total;
  }

  /// Check if booking draft is complete (all required fields filled)
  bool get isComplete {
    return selectedTimeSlot != null &&
        selectedAddress != null &&
        selectedDate != null;
  }

  /// Sample booking draft for testing
  factory BookingDraft.sample() {
    final Service sampleService = Service.sample();
    final DateTime now = DateTime.now();
    final DateTime today = DateTime(now.year, now.month, now.day);

    return BookingDraft(
      id: 'draft-1',
      userId: 'user-1',
      service: sampleService,
      selectedDate: today,
      selectedTimeSlot: TimeSlot.samples().first,
      selectedAddress: Address.sample(),
      selectedOptions: <ServiceOption>[
        ServiceOption(
          id: 'option-2',
          serviceId: sampleService.id,
          name: 'Express Service',
          description: 'Priority processing with faster delivery',
          price: 199.0,
          isSelected: true,
          type: 'addon',
        ),
      ],
      notes: 'Please handle with care',
      createdAt: DateTime.now(),
      updatedAt: DateTime.now(),
    );
  }
}

/// Helper function for list equality
bool listEquals<T>(List<T>? list1, List<T>? list2) {
  if (list1 == null && list2 == null) return true;
  if (list1 == null || list2 == null) return false;
  if (list1.length != list2.length) return false;

  for (int i = 0; i < list1.length; i++) {
    if (list1[i] != list2[i]) return false;
  }

  return true;
}
