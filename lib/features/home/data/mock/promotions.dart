/// Mock promotions data for Ironit
/// Provides sample promotion data for development and testing
import '../../domain/models/promotion.dart';

class MockPromotions {
  /// Get all mock promotions
  static List<Promotion> getAllPromotions() {
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
      Promotion(
        id: 'promo-4',
        title: 'First Time Discount',
        subtitle: '₹100 off your first order',
        imageUrl: 'https://example.com/images/first-time-promo.jpg',
        actionUrl: '/services',
        actionText: 'Claim Offer',
        startDate: now,
        endDate: now.add(const Duration(days: 7)),
        isActive: true,
      ),
      Promotion(
        id: 'promo-5',
        title: 'Weekend Special',
        subtitle: 'Free pickup and delivery on weekends',
        imageUrl: 'https://example.com/images/weekend-promo.jpg',
        actionUrl: '/book-now',
        actionText: 'Book Weekend Slot',
        startDate: now,
        endDate: now.add(const Duration(days: 90)),
        isActive: true,
      ),
    ];
  }

  /// Get active promotions
  static List<Promotion> getActivePromotions() {
    return getAllPromotions().where((promotion) => promotion.isValid).toList();
  }

  /// Get promotion by ID
  static Promotion? getPromotionById(String id) {
    try {
      return getAllPromotions().firstWhere((promotion) => promotion.id == id);
    } catch (e) {
      return null;
    }
  }
}