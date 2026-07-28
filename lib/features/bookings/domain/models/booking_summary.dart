/// BookingSummary domain model
/// Represents a completed booking summary for confirmation
import 'address.dart';
import 'service_option.dart';
import 'time_slot.dart';
import 'package:ironit/features/home/domain/models/service.dart';

class BookingSummary {
  final String id;
  final String userId;
  final Service service;
  final DateTime bookingDate;
  final TimeSlot timeSlot;
  final Address address;
  final List<ServiceOption> selectedOptions;
  final String notes;
  final double totalPrice;
  final String bookingReference;
  final DateTime createdAt;
  final String status;

  const BookingSummary({
    required this.id,
    required this.userId,
    required this.service,
    required this.bookingDate,
    required this.timeSlot,
    required this.address,
    this.selectedOptions = const <ServiceOption>[],
    this.notes = '',
    required this.totalPrice,
    required this.bookingReference,
    required this.createdAt,
    this.status = 'confirmed',
  });

  /// Create a copy of this booking summary with optional updates
  BookingSummary copyWith({
    String? id,
    String? userId,
    Service? service,
    DateTime? bookingDate,
    TimeSlot? timeSlot,
    Address? address,
    List<ServiceOption>? selectedOptions,
    String? notes,
    double? totalPrice,
    String? bookingReference,
    DateTime? createdAt,
    String? status,
  }) {
    return BookingSummary(
      id: id ?? this.id,
      userId: userId ?? this.userId,
      service: service ?? this.service,
      bookingDate: bookingDate ?? this.bookingDate,
      timeSlot: timeSlot ?? this.timeSlot,
      address: address ?? this.address,
      selectedOptions: selectedOptions ?? this.selectedOptions,
      notes: notes ?? this.notes,
      totalPrice: totalPrice ?? this.totalPrice,
      bookingReference: bookingReference ?? this.bookingReference,
      createdAt: createdAt ?? this.createdAt,
      status: status ?? this.status,
    );
  }

  /// Convert booking summary to map for serialization
  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'userId': userId,
      'service': service.toMap(),
      'bookingDate': bookingDate.millisecondsSinceEpoch,
      'timeSlot': timeSlot.toMap(),
      'address': address.toMap(),
      'selectedOptions': selectedOptions
          .map((ServiceOption option) => option.toMap())
          .toList(),
      'notes': notes,
      'totalPrice': totalPrice,
      'bookingReference': bookingReference,
      'createdAt': createdAt.millisecondsSinceEpoch,
      'status': status,
    };
  }

  /// Create booking summary from map
  factory BookingSummary.fromMap(Map<String, dynamic> map) {
    return BookingSummary(
      id: map['id'] as String,
      userId: map['userId'] as String,
      service: Service.fromMap(map['service'] as Map<String, dynamic>),
      bookingDate:
          DateTime.fromMillisecondsSinceEpoch(map['bookingDate'] as int),
      timeSlot: TimeSlot.fromMap(map['timeSlot'] as Map<String, dynamic>),
      address: Address.fromMap(map['address'] as Map<String, dynamic>),
      selectedOptions: (map['selectedOptions'] as List<dynamic>?)
              ?.map((dynamic option) =>
                  ServiceOption.fromMap(option as Map<String, dynamic>))
              .toList() ??
          <ServiceOption>[],
      notes: map['notes'] as String? ?? '',
      totalPrice: (map['totalPrice'] as num).toDouble(),
      bookingReference: map['bookingReference'] as String,
      createdAt: DateTime.fromMillisecondsSinceEpoch(map['createdAt'] as int),
      status: map['status'] as String? ?? 'confirmed',
    );
  }

  /// Equality comparison
  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is BookingSummary &&
        other.id == id &&
        other.userId == userId &&
        other.service == service &&
        other.bookingDate == bookingDate &&
        other.timeSlot == timeSlot &&
        other.address == address &&
        listEquals(other.selectedOptions, selectedOptions) &&
        other.notes == notes &&
        other.totalPrice == totalPrice &&
        other.bookingReference == bookingReference &&
        other.createdAt == createdAt &&
        other.status == status;
  }

  /// Hash code for booking summary
  @override
  int get hashCode {
    return id.hashCode ^
        userId.hashCode ^
        service.hashCode ^
        bookingDate.hashCode ^
        timeSlot.hashCode ^
        address.hashCode ^
        selectedOptions.hashCode ^
        notes.hashCode ^
        totalPrice.hashCode ^
        bookingReference.hashCode ^
        createdAt.hashCode ^
        status.hashCode;
  }

  /// Get formatted booking date and time
  String get formattedDateTime {
    return '${bookingDate.year}-${bookingDate.month.toString().padLeft(2, '0')}-${bookingDate.day.toString().padLeft(2, '0')} ${timeSlot.formattedTime}';
  }

  /// Sample booking summary for testing
  factory BookingSummary.sample() {
    final Service sampleService = Service.sample();
    final DateTime now = DateTime.now();
    final DateTime today = DateTime(now.year, now.month, now.day);

    return BookingSummary(
      id: 'booking-1',
      userId: 'user-1',
      service: sampleService,
      bookingDate: today,
      timeSlot: TimeSlot.samples().first,
      address: Address.sample(),
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
      totalPrice: 498.0,
      bookingReference:
          'IRN-${now.millisecondsSinceEpoch.toString().substring(8)}',
      createdAt: DateTime.now(),
      status: 'confirmed',
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
