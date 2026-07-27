import 'package:flutter/material.dart';

/// A widget to display error state information.
///
/// Shows an error icon, message, and optional retry button.
/// Uses theme colors and text styles for consistent appearance.
class ErrorStateWidget extends StatelessWidget {
  /// Creates an error state widget.
  ///
  /// The [errorIcon] widget is displayed at the top.
  /// The [message] describes the error that occurred.
  /// The [onRetry] callback is called when the retry button is pressed.
  /// The [retryButtonText] customizes the retry button text.
  const ErrorStateWidget({
    super.key,
    this.errorIcon = const Icon(Icons.warning_amber_outlined, size: 48),
    required this.message,
    this.onRetry,
    this.retryButtonText = 'Retry',
  });

  /// The error icon to display at the top.
  final Widget errorIcon;

  /// The error message to display.
  final String message;

  /// The callback to call when the retry button is pressed.
  final VoidCallback? onRetry;

  /// The text to display on the retry button.
  final String retryButtonText;

  @override
  Widget build(BuildContext context) {
    final ColorScheme colorScheme = Theme.of(context).colorScheme;
    final TextTheme textTheme = Theme.of(context).textTheme;

    return Center(
      child: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            IconTheme(
              data: IconThemeData(
                color: colorScheme.error,
                size: 48,
              ),
              child: errorIcon,
            ),
            const SizedBox(height: 16),
            Text(
              message,
              style: textTheme.titleLarge?.copyWith(
                color: colorScheme.onSurface,
              ),
              textAlign: TextAlign.center,
            ),
            if (onRetry != null) ...<Widget>[
              const SizedBox(height: 16),
              ElevatedButton(
                onPressed: onRetry,
                child: Text(retryButtonText),
              ),
            ],
          ],
        ),
      ),
    );
  }
}
