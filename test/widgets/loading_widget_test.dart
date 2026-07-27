import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:ironit/core/widgets/loading_widget.dart';

void main() {
  group('LoadingWidget', () {
    testWidgets('renders inline circular loader', (WidgetTester tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: LoadingWidget(size: 24),
        ),
      );

      expect(find.byType(CircularProgressIndicator), findsOneWidget);
      final CircularProgressIndicator progressIndicator =
          tester.widget<CircularProgressIndicator>(
        find.byType(CircularProgressIndicator),
      );
      expect(progressIndicator.strokeWidth, equals(2));
    });

    testWidgets('renders with custom size', (WidgetTester tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: LoadingWidget(size: 48),
        ),
      );

      final SizedBox sizedBox = tester.widget<SizedBox>(
        find.ancestor(
          of: find.byType(CircularProgressIndicator),
          matching: find.byType(SizedBox),
        ),
      );
      expect(sizedBox.width, equals(48));
      expect(sizedBox.height, equals(48));
    });

    testWidgets('uses theme primary color', (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          theme: ThemeData(
            colorScheme: const ColorScheme.light(
              primary: Colors.blue,
            ),
          ),
          home: const LoadingWidget(),
        ),
      );

      final CircularProgressIndicator progressIndicator =
          tester.widget<CircularProgressIndicator>(
        find.byType(CircularProgressIndicator),
      );
      final AlwaysStoppedAnimation<Color> valueColor =
          progressIndicator.valueColor as AlwaysStoppedAnimation<Color>;
      expect(valueColor.value, equals(Colors.blue));
    });
  });
}
