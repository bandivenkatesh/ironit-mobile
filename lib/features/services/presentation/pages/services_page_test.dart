/// Services Page Widget Tests
/// Tests for the ServicesPage widget and its components
library;

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';

import '../pages/services_page.dart';
import '../widgets/service_card.dart';
import '../widgets/category_chip.dart';
import '../providers/service_providers.dart';
import '../../../home/domain/models/service.dart';
import '../../../home/domain/models/category.dart';
import '../../../home/data/mock/categories.dart';

void main() {
  group('ServicesPage Widget Tests', () {
    testWidgets('renders ServicesPage with search field',
        (WidgetTester tester) async {
      await tester.pumpWidget(
        ProviderScope(
          child: MaterialApp(
            home: const ServicesPage(),
          ),
        ),
      );

      await tester.pump();

      // Verify search field is present
      expect(find.byType(TextField), findsOneWidget);
      expect(find.text('Search all services...'), findsOneWidget);
    });

    testWidgets('renders category chips', (WidgetTester tester) async {
      await tester.pumpWidget(
        ProviderScope(
          child: MaterialApp(
            home: const ServicesPage(),
          ),
        ),
      );

      await tester.pump();

      // Verify category chips are present
      expect(find.byType(CategoryChip), findsWidgets);
      expect(find.text('All'), findsOneWidget);
    });

    testWidgets('sort button is present', (WidgetTester tester) async {
      await tester.pumpWidget(
        ProviderScope(
          child: MaterialApp(
            home: const ServicesPage(),
          ),
        ),
      );

      await tester.pump();

      // Verify sort button is present
      expect(find.byIcon(Icons.tune), findsOneWidget);
    });
  });

  group('ServiceCard Widget Tests', () {
    final Service mockService = Service(
      id: 'test-service',
      name: 'Test Service',
      categoryId: 'category-1',
      description: 'Test description',
      price: 299.0,
      rating: 4.5,
      reviewCount: 100,
      imageUrl: 'https://example.com/test.jpg',
      estimatedDuration: const Duration(minutes: 30),
      isFeatured: true,
      isPopular: true,
      createdAt: DateTime.now(),
    );

    testWidgets('ServiceCard displays service information',
        (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: ServiceCard(
              service: mockService,
              isCompact: true,
            ),
          ),
        ),
      );

      // Verify service information is displayed
      expect(find.text('Test Service'), findsOneWidget);
      expect(find.text('₹299'), findsOneWidget);
      expect(find.text('4.5'), findsOneWidget);
      expect(find.text('(100 reviews)'), findsOneWidget);
      expect(find.text('30 min'), findsOneWidget);
    });

    testWidgets('ServiceCard shows popular badge for popular services',
        (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: ServiceCard(
              service: mockService,
              isCompact: true,
              showCategory: true,
            ),
          ),
        ),
      );

      // Verify popular badge is shown
      expect(find.byIcon(Icons.whatshot), findsOneWidget);
    });
  });
}
