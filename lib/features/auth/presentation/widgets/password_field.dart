import 'package:flutter/material.dart';

import 'auth_text_field.dart';

/// Password field with visibility toggle.
/// Extends AuthTextField with password-specific features.
class PasswordField extends StatefulWidget {
  final TextEditingController? controller;
  final String label;
  final String hint;
  final String? Function(String?)? validator;

  const PasswordField({
    super.key,
    this.controller,
    this.label = 'Password',
    this.hint = 'Enter your password',
    this.validator,
  });

  @override
  State<PasswordField> createState() => _PasswordFieldState();
}

class _PasswordFieldState extends State<PasswordField> {
  bool _obscureText = true;

  @override
  Widget build(BuildContext context) {
    return AuthTextField(
      controller: widget.controller,
      label: widget.label,
      hint: widget.hint,
      obscureText: _obscureText,
      keyboardType: TextInputType.visiblePassword,
      validator: widget.validator,
      suffixIcon: IconButton(
        icon: Icon(
          _obscureText ? Icons.visibility_off : Icons.visibility,
          color: Theme.of(context).colorScheme.onSurfaceVariant,
        ),
        onPressed: () {
          setState(() {
            _obscureText = !_obscureText;
          });
        },
        splashRadius: 20,
      ),
    );
  }
}
