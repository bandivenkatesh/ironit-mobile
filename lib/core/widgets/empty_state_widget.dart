import 'package:flutter/material.dart';

/// A widget to display empty state information.
///
/// Shows an icon, title, and subtitle to indicate that no content is available.
/// Uses theme colors and text styles for consistent appearance.
class EmptyStateWidget extends StatelessWidget {
  /// Creates an empty state widget.
  ///
  /// The [icon] widget is displayed at the top.
  /// The [title] is the main text describing the empty state.
  /// The [subtitle] provides additional context.
  /// The [action] widget is displayed below the subtitle (optional).
  const EmptyStateWidget({
    super.key,
    this.icon = const Icon(Icons.inbox_outlined, size: 48),
    required this.title,
    this.subtitle,
    this.action,
  });

  /// The icon to display at the top of the empty state.
  final Widget icon;

  /// The main title describing the empty state.
  final String title;

  /// Additional subtitle providing more context.
  final String? subtitle;

  /// An optional action widget to display below the subtitle.
  final Widget? action;

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
                color: colorScheme.onSurfaceVariant,
                size: 48,
              ),
              child: icon,
            ),
            const SizedBox(height: 16),
            Text(
              title,
              style: textTheme.titleLarge?.copyWith(
                color: colorScheme.onSurface,
              ),
              textAlign: TextAlign.center,
            ),
            if (subtitle != null && subtitle!.isNotEmpty) ...<Widget>[
              const SizedBox(height: 8),
              Text(
                subtitle!,
                style: textTheme.bodyMedium?.copyWith(
                  color: colorScheme.onSurfaceVariant,
                ),
                textAlign: TextAlign.center,
              ),
            ],
            if (action != null) ...<Widget>[
              const SizedBox(height: 16),
              action!,
            ],
          ],
        ),
      ),
    );
  }
}
