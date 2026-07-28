/// Profile Providers
/// Riverpod state management for profile feature
import 'package:flutter_riverpod/flutter_riverpod.dart';

/// Mock profile data provider
final profileDataProvider = FutureProvider.autoDispose<Map<String, dynamic>>(
  (FutureProviderRef<Map<String, dynamic>> ref) async {
    // Simulate network delay
    await Future.delayed(const Duration(milliseconds: 500));

    // Return mock profile data
    return <String, dynamic>{
      'name': 'Sarah Johnson',
      'email': 'sarah.johnson@example.com',
      'phone': '+1 (555) 123-4567',
      'stats': <String, int>{
        'bookings': 8,
        'addresses': 3,
        'rewards': 125,
      },
      'preferences': <String, dynamic>{
        'notifications': true,
        'darkMode': false,
        'emailUpdates': true,
      },
    };
  },
);

/// Address book provider
final addressBookProvider = FutureProvider.autoDispose<List<Map<String, dynamic>>>(
  (FutureProviderRef<List<Map<String, dynamic>>> ref) async {
    // Simulate network delay
    await Future.delayed(const Duration(milliseconds: 300));

    // Return mock address data
    return <Map<String, dynamic>>[
      <String, dynamic>{
        'id': 'addr-1',
        'label': 'Home',
        'formattedAddress': '123 Main St, Apt 4B, San Francisco, CA 94105',
        'isDefault': true,
        'type': 'home',
      },
      <String, dynamic>{
        'id': 'addr-2',
        'label': 'Office',
        'formattedAddress': '456 Market St, Suite 300, San Francisco, CA 94103',
        'isDefault': false,
        'type': 'work',
      },
      <String, dynamic>{
        'id': 'addr-3',
        'label': 'Gym',
        'formattedAddress': '789 Fitness Blvd, San Francisco, CA 94110',
        'isDefault': false,
        'type': 'other',
      },
    ];
  },
);

/// Preferences provider
final preferencesProvider = StateProvider<Map<String, dynamic>>(
  (StateProviderRef<Map<String, dynamic>> ref) {
    return <String, dynamic>{
      'notifications': true,
      'darkMode': false,
      'emailUpdates': true,
      'smsAlerts': false,
    };
  },
);

/// Support FAQ provider
final supportFaqProvider = FutureProvider.autoDispose<List<Map<String, dynamic>>>(
  (FutureProviderRef<List<Map<String, dynamic>>> ref) async {
    // Simulate network delay
    await Future.delayed(const Duration(milliseconds: 200));

    // Return mock FAQ data
    return <Map<String, dynamic>>[
      <String, dynamic>{
        'id': 'faq-1',
        'question': 'How do I schedule a service?',
        'answer':
            'You can schedule a service by browsing our available services, selecting your preferred date and time, and completing the booking process. Our professionals will be assigned to your booking.',
      },
      <String, dynamic>{
        'id': 'faq-2',
        'question': 'What is your cancellation policy?',
        'answer':
            'You can cancel your booking up to 24 hours before the scheduled time without any penalty. For cancellations within 24 hours, a 20% cancellation fee may apply.',
      },
      <String, dynamic>{
        'id': 'faq-3',
        'question': 'How do I contact customer support?',
        'answer':
            'You can contact our customer support team through the app, by phone at (555) 123-4567, or by email at support@ironit.com. Our team is available 24/7 to assist you.',
      },
      <String, dynamic>{
        'id': 'faq-4',
        'question': 'What payment methods do you accept?',
        'answer':
            'We accept all major credit cards, debit cards, and digital wallets. Payment is processed securely through our platform after service completion.',
      },
    ];
  },
);