/// TimeSlot domain model
/// Represents an available time slot for service booking
class TimeSlot {
  final String id;
  final DateTime startTime;
  final DateTime endTime;
  final bool isAvailable;
  final String serviceId;

  const TimeSlot({
    required this.id,
    required this.startTime,
    required this.endTime,
    this.isAvailable = true,
    required this.serviceId,
  });

  /// Create a copy of this time slot with optional updates
  TimeSlot copyWith({
    String? id,
    DateTime? startTime,
    DateTime? endTime,
    bool? isAvailable,
    String? serviceId,
  }) {
    return TimeSlot(
      id: id ?? this.id,
      startTime: startTime ?? this.startTime,
      endTime: endTime ?? this.endTime,
      isAvailable: isAvailable ?? this.isAvailable,
      serviceId: serviceId ?? this.serviceId,
    );
  }

  /// Convert time slot to map for serialization
  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'startTime': startTime.millisecondsSinceEpoch,
      'endTime': endTime.millisecondsSinceEpoch,
      'isAvailable': isAvailable,
      'serviceId': serviceId,
    };
  }

  /// Create time slot from map
  factory TimeSlot.fromMap(Map<String, dynamic> map) {
    return TimeSlot(
      id: map['id'] as String,
      startTime: DateTime.fromMillisecondsSinceEpoch(map['startTime'] as int),
      endTime: DateTime.fromMillisecondsSinceEpoch(map['endTime'] as int),
      isAvailable: map['isAvailable'] as bool? ?? true,
      serviceId: map['serviceId'] as String,
    );
  }

  /// Equality comparison
  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is TimeSlot &&
        other.id == id &&
        other.startTime == startTime &&
        other.endTime == endTime &&
        other.isAvailable == isAvailable &&
        other.serviceId == serviceId;
  }

  /// Hash code for time slot
  @override
  int get hashCode {
    return id.hashCode ^
        startTime.hashCode ^
        endTime.hashCode ^
        isAvailable.hashCode ^
        serviceId.hashCode;
  }

  /// Get formatted time display
  String get formattedTime {
    return '${startTime.hour.toString().padLeft(2, '0')}:${startTime.minute.toString().padLeft(2, '0')} - ${endTime.hour.toString().padLeft(2, '0')}:${endTime.minute.toString().padLeft(2, '0')}';
  }

  /// Sample time slots for testing
  static List<TimeSlot> samples() {
    final DateTime now = DateTime.now();
    final DateTime today = DateTime(now.year, now.month, now.day);

    return <TimeSlot>[
      TimeSlot(
        id: 'slot-1',
        startTime: DateTime(today.year, today.month, today.day, 9, 0),
        endTime: DateTime(today.year, today.month, today.day, 10, 0),
        isAvailable: true,
        serviceId: 'service-1',
      ),
      TimeSlot(
        id: 'slot-2',
        startTime: DateTime(today.year, today.month, today.day, 10, 0),
        endTime: DateTime(today.year, today.month, today.day, 11, 0),
        isAvailable: true,
        serviceId: 'service-1',
      ),
      TimeSlot(
        id: 'slot-3',
        startTime: DateTime(today.year, today.month, today.day, 14, 0),
        endTime: DateTime(today.year, today.month, today.day, 15, 0),
        isAvailable: true,
        serviceId: 'service-1',
      ),
      TimeSlot(
        id: 'slot-4',
        startTime: DateTime(today.year, today.month, today.day, 16, 0),
        endTime: DateTime(today.year, today.month, today.day, 17, 0),
        isAvailable: true,
        serviceId: 'service-1',
      ),
    ];
  }
}
