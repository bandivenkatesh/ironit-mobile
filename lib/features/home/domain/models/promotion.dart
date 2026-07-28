/// Promotion domain model
/// Represents a promotional banner in Ironit
class Promotion {
  final String id;
  final String title;
  final String subtitle;
  final String imageUrl;
  final String actionUrl;
  final String actionText;
  final DateTime startDate;
  final DateTime endDate;
  final bool isActive;

  const Promotion({
    required this.id,
    required this.title,
    required this.subtitle,
    required this.imageUrl,
    required this.actionUrl,
    required this.actionText,
    required this.startDate,
    required this.endDate,
    this.isActive = true,
  });

  /// Create a copy of this promotion with optional updates
  Promotion copyWith({
    String? id,
    String? title,
    String? subtitle,
    String? imageUrl,
    String? actionUrl,
    String? actionText,
    DateTime? startDate,
    DateTime? endDate,
    bool? isActive,
  }) {
    return Promotion(
      id: id ?? this.id,
      title: title ?? this.title,
      subtitle: subtitle ?? this.subtitle,
      imageUrl: imageUrl ?? this.imageUrl,
      actionUrl: actionUrl ?? this.actionUrl,
      actionText: actionText ?? this.actionText,
      startDate: startDate ?? this.startDate,
      endDate: endDate ?? this.endDate,
      isActive: isActive ?? this.isActive,
    );
  }

  /// Convert promotion to map for serialization
  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'title': title,
      'subtitle': subtitle,
      'imageUrl': imageUrl,
      'actionUrl': actionUrl,
      'actionText': actionText,
      'startDate': startDate.millisecondsSinceEpoch,
      'endDate': endDate.millisecondsSinceEpoch,
      'isActive': isActive,
    };
  }

  /// Create promotion from map
  factory Promotion.fromMap(Map<String, dynamic> map) {
    return Promotion(
      id: map['id'] as String,
      title: map['title'] as String,
      subtitle: map['subtitle'] as String,
      imageUrl: map['imageUrl'] as String,
      actionUrl: map['actionUrl'] as String,
      actionText: map['actionText'] as String,
      startDate: DateTime.fromMillisecondsSinceEpoch(map['startDate'] as int),
      endDate: DateTime.fromMillisecondsSinceEpoch(map['endDate'] as int),
      isActive: map['isActive'] as bool? ?? true,
    );
  }

  /// Check if promotion is currently valid
  bool get isValid {
    final now = DateTime.now();
    return isActive && now.isAfter(startDate) && now.isBefore(endDate);
  }

  /// Equality comparison
  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is Promotion &&
      other.id == id &&
      other.title == title &&
      other.subtitle == subtitle &&
      other.imageUrl == imageUrl &&
      other.actionUrl == actionUrl &&
      other.actionText == actionText &&
      other.startDate == startDate &&
      other.endDate == endDate &&
      other.isActive == isActive;
  }

  /// Hash code for promotion
  @override
  int get hashCode {
    return id.hashCode ^
      title.hashCode ^
      subtitle.hashCode ^
      imageUrl.hashCode ^
      actionUrl.hashCode ^
      actionText.hashCode ^
      startDate.hashCode ^
      endDate.hashCode ^
      isActive.hashCode;
  }

  /// Sample factory for testing
  factory Promotion.sample() {
    return Promotion(
      id: 'promo-1',
      title: 'Summer Special',
      subtitle: '20% off on all ironing services',
      imageUrl: 'https://example.com/images/summer-promo.jpg',
      actionUrl: '/services',
      actionText: 'Book Now',
      startDate: DateTime.now(),
      endDate: DateTime.now().add(const Duration(days: 30)),
      isActive: true,
    );
  }

  /// Sample list of promotions for testing
  static List<Promotion> samples() {
    final now = DateTime.now();
    return [
      Promotion(
        id: 'promo-1',
        title: 'Summer Special',
        subtitle: '20% off on all ironing services',
        imageUrl: 'https://example.com/images/summer-promo.jpg',
        actionUrl: '/services',
        actionText: 'Book Now',
        startDate: now,
        endDate: now.add(const Duration(days: 30)),
        isActive: true,
      ),
      Promotion(
        id: 'promo-2',
        title: 'Premium Membership',
        subtitle: 'Get unlimited ironing for just ₹999/month',
        imageUrl: 'https://example.com/images/membership-promo.jpg',
        actionUrl: '/membership',
        actionText: 'Learn More',
        startDate: now,
        endDate: now.add(const Duration(days: 15)),
        isActive: true,
      ),
      Promotion(
        id: 'promo-3',
        title: 'Referral Bonus',
        subtitle: 'Get ₹100 for every friend you refer',
        imageUrl: 'https://example.com/images/referral-promo.jpg',
        actionUrl: '/referrals',
        actionText: 'Refer Now',
        startDate: now,
        endDate: now.add(const Duration(days: 60)),
        isActive: true,
      ),
    ];
  }
}