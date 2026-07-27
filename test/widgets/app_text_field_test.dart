import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:ironit/core/widgets/app_text_field.dart';

void main() {
  group('AppTextField', () {
    testWidgets('renders correctly with hint text',
        (WidgetTester tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(
            body: Center(
              child: SizedBox(
                width: 300,
                child: AppTextField(
                  hintText: 'Enter text',
                ),
              ),
            ),
          ),
        ),
      );

      expect(find.text('Enter text'), findsOneWidget);
      expect(find.byType(TextField), findsOneWidget);
    });

    testWidgets('shows prefix and suffix icons', (WidgetTester tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(
            body: Center(
              child: SizedBox(
                width: 300,
                child: AppTextField(
                  prefixIcon: Icon(Icons.person),
                  suffixIcon: Icon(Icons.visibility),
                  hintText: 'With icons',
                ),
              ),
            ),
          ),
        ),
      );

      expect(find.byIcon(Icons.person), findsOneWidget);
      expect(find.byIcon(Icons.visibility), findsOneWidget);
    });

    testWidgets('toggles password visibility', (WidgetTester tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(
            body: Center(
              child: SizedBox(
                width: 300,
                child: AppTextField(
                  isPasswordField: true,
                  obscureText: true,
                  hintText: 'Password',
                ),
              ),
            ),
          ),
        ),
      );

      // Initially should be obscured
      final TextField textField =
          tester.widget<TextField>(find.byType(TextField));
      expect(textField.obscureText, isTrue);

      // Tap the visibility toggle
      await tester.tap(find.byIcon(Icons.visibility_off));
      await tester.pump();

      // Should now be visible
      final TextField updatedTextField =
          tester.widget<TextField>(find.byType(TextField));
      expect(updatedTextField.obscureText, isFalse);
    });

    testWidgets('shows error text when provided', (WidgetTester tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(
            body: Center(
              child: SizedBox(
                width: 300,
                child: AppTextField(
                  hintText: 'Email',
                  errorText: 'Invalid email format',
                ),
              ),
            ),
          ),
        ),
      );

      expect(find.text('Invalid email format'), findsOneWidget);
    });

    testWidgets('supports multi-line input', (WidgetTester tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(
            body: Center(
              child: SizedBox(
                width: 300,
                child: AppTextField(
                  maxLines: 3,
                  minLines: 2,
                  hintText: 'Multi-line text',
                ),
              ),
            ),
          ),
        ),
      );

      final TextField textField =
          tester.widget<TextField>(find.byType(TextField));
      expect(textField.maxLines, equals(3));
      expect(textField.minLines, equals(2));
    });

    testWidgets('is disabled when enabled is false',
        (WidgetTester tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(
            body: Center(
              child: SizedBox(
                width: 300,
                child: AppTextField(
                  hintText: 'Disabled field',
                  enabled: false,
                ),
              ),
            ),
          ),
        ),
      );

      final TextField textField =
          tester.widget<TextField>(find.byType(TextField));
      expect(textField.enabled, isFalse);
    });

    testWidgets('uses controller correctly', (WidgetTester tester) async {
      final TextEditingController controller =
          TextEditingController(text: 'Initial text');
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: Center(
              child: SizedBox(
                width: 300,
                child: AppTextField(
                  controller: controller,
                  hintText: 'Controlled field',
                ),
              ),
            ),
          ),
        ),
      );

      expect(controller.text, equals('Initial text'));
      // The text field should show the controller's text
      final TextField textField =
          tester.widget<TextField>(find.byType(TextField));
      expect(textField.controller?.text, equals('Initial text'));
    });
  });
}
