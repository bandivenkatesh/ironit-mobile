import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:ironit/core/widgets/primary_button.dart';

void main() {
  group('PrimaryButton', () {
    testWidgets('renders correctly with text', (WidgetTester tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(
            body: Center(
              child: PrimaryButton(
                onPressed: null,
                child: Text('Test Button'),
              ),
            ),
          ),
        ),
      );

      expect(find.text('Test Button'), findsOneWidget);
      expect(find.byType(ElevatedButton), findsOneWidget);
    });

    testWidgets('renders correctly with icon', (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: Center(
              child: PrimaryButton(
                onPressed: () {},
                icon: const Icon(Icons.add),
                child: const Text('Add'),
              ),
            ),
          ),
        ),
      );

      expect(find.byIcon(Icons.add), findsOneWidget);
      expect(find.text('Add'), findsOneWidget);
    });

    testWidgets('shows loading indicator when isLoading is true',
        (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: Center(
              child: PrimaryButton(
                onPressed: () {},
                isLoading: true,
                child: const Text('Loading'),
              ),
            ),
          ),
        ),
      );

      expect(find.byType(CircularProgressIndicator), findsOneWidget);
      expect(find.text('Loading'), findsNothing);
    });

    testWidgets('is disabled when isEnabled is false',
        (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: Center(
              child: PrimaryButton(
                onPressed: () {},
                isEnabled: false,
                child: const Text('Disabled'),
              ),
            ),
          ),
        ),
      );

      final ElevatedButton button =
          tester.widget<ElevatedButton>(find.byType(ElevatedButton));
      expect(button.onPressed, isNull);
    });

    testWidgets('is full width when isFullWidth is true',
        (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: Center(
              child: SizedBox(
                width: 300,
                child: PrimaryButton(
                  onPressed: () {},
                  isFullWidth: true,
                  child: const Text('Full Width'),
                ),
              ),
            ),
          ),
        ),
      );

      // Find the SizedBox that has width = double.infinity
      final Finder fullWidthButton = find.byWidgetPredicate(
        (Widget widget) =>
            widget is SizedBox && widget.width == double.infinity,
      );
      expect(fullWidthButton, findsOneWidget);
    });

    testWidgets('calls onPressed when tapped', (WidgetTester tester) async {
      bool tapped = false;
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: Center(
              child: PrimaryButton(
                onPressed: () => tapped = true,
                child: const Text('Tap Me'),
              ),
            ),
          ),
        ),
      );

      await tester.tap(find.text('Tap Me'));
      expect(tapped, isTrue);
    });
  });
}
