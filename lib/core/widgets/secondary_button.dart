import 'package:flutter/material.dart';

/// A secondary outlined button with Material 3 styling.
///
/// Supports various states including loading, disabled, and full-width.
/// Uses theme colors and can include an optional icon.
class SecondaryButton extends StatelessWidget {
  /// Creates a secondary button.
  ///
  /// The [onPressed] callback is called when the button is tapped.
  /// If [onPressed] is null, the button will be disabled.
  ///
  /// The [child] widget is the primary content of the button.
  ///
  /// The [icon] widget is displayed before the child (leading position).
  ///
  /// Set [isLoading] to true to show a loading indicator instead of the child.
  ///
  /// Set [isEnabled] to false to disable the button.
  ///
  /// Set [isFullWidth] to true to make the button expand to full width.
  const SecondaryButton({
    super.key,
    required this.onPressed,
    required this.child,
    this.icon,
    this.isLoading = false,
    this.isEnabled = true,
    this.isFullWidth = false,
  });

  /// The callback that is called when the button is tapped.
  final VoidCallback? onPressed;

  /// The primary content of the button.
  final Widget child;

  /// An optional icon to display before the child.
  final Widget? icon;

  /// Whether to show a loading indicator instead of the child.
  final bool isLoading;

  /// Whether the button is enabled.
  final bool isEnabled;

  /// Whether the button should expand to full width.
  final bool isFullWidth;

  @override
  Widget build(BuildContext context) {
    final ColorScheme colorScheme = Theme.of(context).colorScheme;
    final TextTheme textTheme = Theme.of(context).textTheme;

    final VoidCallback? effectiveOnPressed =
        isEnabled && !isLoading ? onPressed : null;

    return SizedBox(
      width: isFullWidth ? double.infinity : null,
      child: OutlinedButton(
        onPressed: effectiveOnPressed,
        style: OutlinedButton.styleFrom(
          foregroundColor: colorScheme.primary,
          disabledForegroundColor:
              colorScheme.onSurface.withValues(alpha: 0.38),
          side: BorderSide(
            color: isEnabled
                ? colorScheme.outline
                : colorScheme.onSurface.withValues(alpha: 0.12),
          ),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8),
          ),
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
          textStyle: textTheme.labelLarge,
        ),
        child: isLoading
            ? SizedBox(
                width: 24,
                height: 24,
                child: CircularProgressIndicator(
                  strokeWidth: 2,
                  valueColor: AlwaysStoppedAnimation<Color>(
                    colorScheme.primary,
                  ),
                ),
              )
            : icon != null
                ? Row(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      icon!,
                      const SizedBox(width: 8),
                      child,
                    ],
                  )
                : child,
      ),
    );
  }
}
