import 'package:flutter/material.dart';

/// A loading indicator widget with Material 3 styling.
///
/// Can be used as an inline circular loader or as a full-screen loading overlay.
/// Uses theme colors for consistent appearance.
class LoadingWidget extends StatelessWidget {
  /// Creates a loading widget.
  ///
  /// The [size] determines the diameter of the circular loader.
  /// Set [isFullScreen] to true to show a full-screen loading overlay.
  const LoadingWidget({
    super.key,
    this.size = 24.0,
    this.isFullScreen = false,
  });

  /// The diameter of the circular loader.
  final double size;

  /// Whether to show as a full-screen overlay.
  final bool isFullScreen;

  @override
  Widget build(BuildContext context) {
    final ColorScheme colorScheme = Theme.of(context).colorScheme;

    if (isFullScreen) {
      return Stack(
        children: <Widget>[
          ModalBarrier(
            dismissible: false,
            color: colorScheme.scrim,
          ),
          Center(
            child: SizedBox(
              width: size,
              height: size,
              child: CircularProgressIndicator(
                strokeWidth: 3,
                valueColor: AlwaysStoppedAnimation<Color>(
                  colorScheme.primary,
                ),
              ),
            ),
          ),
        ],
      );
    }

    return SizedBox(
      width: size,
      height: size,
      child: CircularProgressIndicator(
        strokeWidth: 2,
        valueColor: AlwaysStoppedAnimation<Color>(
          colorScheme.primary,
        ),
      ),
    );
  }
}
