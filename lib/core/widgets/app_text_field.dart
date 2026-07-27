import 'package:flutter/material.dart';

/// A reusable text field with comprehensive input features.
///
/// Supports validation, icons, password toggle, and various input configurations.
/// Uses theme colors and text styles for consistent appearance.
class AppTextField extends StatefulWidget {
  /// Creates an app text field.
  ///
  /// The [controller] controls the text being edited.
  /// The [focusNode] controls the keyboard focus.
  /// The [validator] is called to validate the input.
  /// The [keyboardType] determines the keyboard type.
  /// The [textInputAction] determines the action button on the keyboard.
  /// Set [obscureText] to true for password fields.
  /// Set [isPasswordField] to true to show password visibility toggle.
  /// The [maxLines] and [minLines] control the height of the field.
  /// Set [readOnly] to true to prevent editing.
  /// Set [enabled] to false to disable the field.
  /// The [prefixIcon] and [suffixIcon] add icons to the field.
  /// The [errorText] displays validation errors.
  const AppTextField({
    super.key,
    this.controller,
    this.focusNode,
    this.hintText,
    this.prefixIcon,
    this.suffixIcon,
    this.keyboardType,
    this.textInputAction,
    this.obscureText = false,
    this.isPasswordField = false,
    this.maxLines = 1,
    this.minLines,
    this.readOnly = false,
    this.enabled = true,
    this.validator,
    this.errorText,
  });

  /// Controls the text being edited.
  final TextEditingController? controller;

  /// Controls the keyboard focus.
  final FocusNode? focusNode;

  /// Text that suggests what sort of input the field accepts.
  final String? hintText;

  /// An icon that appears before the editable part of the text field.
  final Widget? prefixIcon;

  /// An icon that appears after the editable part of the text field.
  final Widget? suffixIcon;

  /// The type of keyboard to use for editing the text.
  final TextInputType? keyboardType;

  /// The type of action button to use for the keyboard.
  final TextInputAction? textInputAction;

  /// Whether to hide the text being edited (for passwords).
  final bool obscureText;

  /// Whether this is a password field that should show a visibility toggle.
  final bool isPasswordField;

  /// The maximum number of lines to show.
  final int maxLines;

  /// The minimum number of lines to show.
  final int? minLines;

  /// Whether the text field is read-only.
  final bool readOnly;

  /// Whether the text field is enabled.
  final bool enabled;

  /// An optional method that validates an input.
  final String? Function(String?)? validator;

  /// Text that appears below the field when validation fails.
  final String? errorText;

  @override
  State<AppTextField> createState() => _AppTextFieldState();
}

class _AppTextFieldState extends State<AppTextField> {
  bool _obscureText = false;
  late TextEditingController _controller;
  late FocusNode _focusNode;

  @override
  void initState() {
    super.initState();
    _obscureText = widget.obscureText;
    _controller = widget.controller ?? TextEditingController();
    _focusNode = widget.focusNode ?? FocusNode();
  }

  @override
  void dispose() {
    if (widget.controller == null) {
      _controller.dispose();
    }
    if (widget.focusNode == null) {
      _focusNode.dispose();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final ColorScheme colorScheme = Theme.of(context).colorScheme;
    final TextTheme textTheme = Theme.of(context).textTheme;

    final Widget? effectiveSuffixIcon = widget.isPasswordField
        ? IconButton(
            icon: Icon(
              _obscureText ? Icons.visibility_off : Icons.visibility,
              color: colorScheme.onSurfaceVariant,
            ),
            onPressed: () {
              setState(() {
                _obscureText = !_obscureText;
              });
            },
          )
        : widget.suffixIcon;

    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Material(
          color: Colors.transparent,
          child: TextField(
            controller: _controller,
            focusNode: _focusNode,
            obscureText: _obscureText,
            keyboardType: widget.keyboardType,
            textInputAction: widget.textInputAction,
            maxLines: widget.maxLines,
            minLines: widget.minLines,
            readOnly: widget.readOnly,
            enabled: widget.enabled,
            decoration: InputDecoration(
              hintText: widget.hintText,
              hintStyle: textTheme.bodyLarge?.copyWith(
                color: colorScheme.onSurfaceVariant,
              ),
              prefixIcon: widget.prefixIcon,
              suffixIcon: effectiveSuffixIcon,
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8),
                borderSide: BorderSide(
                  color: colorScheme.outline,
                ),
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8),
                borderSide: BorderSide(
                  color: colorScheme.outline,
                ),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8),
                borderSide: BorderSide(
                  color: colorScheme.primary,
                  width: 2,
                ),
              ),
              errorBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8),
                borderSide: BorderSide(
                  color: colorScheme.error,
                  width: 2,
                ),
              ),
              focusedErrorBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8),
                borderSide: BorderSide(
                  color: colorScheme.error,
                  width: 2,
                ),
              ),
              disabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8),
                borderSide: BorderSide(
                  color: colorScheme.onSurface.withValues(alpha: 0.12),
                ),
              ),
              fillColor: colorScheme.surfaceContainerHighest,
              filled: true,
              contentPadding: const EdgeInsets.symmetric(
                horizontal: 16,
                vertical: 12,
              ),
              errorStyle: textTheme.bodySmall?.copyWith(
                color: colorScheme.error,
              ),
            ),
            style: textTheme.bodyLarge?.copyWith(
              color: colorScheme.onSurface,
            ),
          ),
        ),
        if (widget.errorText != null && widget.errorText!.isNotEmpty)
          Padding(
            padding: const EdgeInsets.only(top: 4, left: 16),
            child: Text(
              widget.errorText!,
              style: textTheme.bodySmall?.copyWith(
                color: colorScheme.error,
              ),
            ),
          ),
      ],
    );
  }
}
