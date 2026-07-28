import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/theme/app_spacing.dart';
import '../../../../core/theme/app_typography.dart';
import '../../../../core/widgets/primary_button.dart';
import '../../../../core/widgets/secondary_button.dart';
import '../widgets/auth_text_field.dart';
import '../widgets/password_field.dart';
import '../widgets/social_login_placeholder.dart';

/// Login screen with email/password authentication.
/// Features form validation, password visibility toggle, and social login options.
class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  bool _rememberMe = false;
  bool _isLoading = false;

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  Future<void> _handleLogin() async {
    if (!_formKey.currentState!.validate()) return;

    setState(() {
      _isLoading = true;
    });

    // Simulate network request
    await Future<void>.delayed(const Duration(milliseconds: 800));

    if (mounted) {
      // In real app, this would call auth service
      // For now, navigate to dashboard placeholder
      context.go('/dashboard-placeholder');
    }

    if (mounted) {
      setState(() {
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Text(
          'Welcome Back',
          style: AppTypography.headline6.copyWith(
            fontWeight: FontWeight.w600,
          ),
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(AppSpacing.large),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                const SizedBox(height: AppSpacing.medium),

                // Email Field
                AuthTextField(
                  controller: _emailController,
                  label: 'Email',
                  hint: 'Enter your email',
                  keyboardType: TextInputType.emailAddress,
                  validator: (String? value) {
                    if (value == null || value.isEmpty) {
                      return 'Email is required';
                    }
                    if (!value.contains('@')) {
                      return 'Please enter a valid email';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: AppSpacing.medium),

                // Password Field
                PasswordField(
                  controller: _passwordController,
                  label: 'Password',
                  hint: 'Enter your password',
                  validator: (String? value) {
                    if (value == null || value.isEmpty) {
                      return 'Password is required';
                    }
                    if (value.length < 6) {
                      return 'Password must be at least 6 characters';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: AppSpacing.small),

                // Remember Me & Forgot Password
                Row(
                  children: <Widget>[
                    Checkbox(
                      value: _rememberMe,
                      onChanged: (bool? value) {
                        setState(() {
                          _rememberMe = value ?? false;
                        });
                      },
                      visualDensity: VisualDensity.compact,
                      materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                    ),
                    Text(
                      'Remember me',
                      style: AppTypography.bodyText2.copyWith(
                        color: Theme.of(context).colorScheme.onSurface,
                      ),
                    ),
                    const Spacer(),
                    TextButton(
                      onPressed: () {
                        context.go('/forgot-password');
                      },
                      child: Text(
                        'Forgot Password?',
                        style: AppTypography.bodyText2.copyWith(
                          color: Theme.of(context).colorScheme.primary,
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: AppSpacing.xLarge),

                // Login Button
                PrimaryButton(
                  onPressed: _isLoading ? null : _handleLogin,
                  isLoading: _isLoading,
                  child: const Text('Login'),
                ),
                const SizedBox(height: AppSpacing.medium),

                // Continue as Guest
                SecondaryButton(
                  onPressed: () {
                    context.go('/dashboard-placeholder');
                  },
                  child: const Text('Continue as Guest'),
                ),
                const SizedBox(height: AppSpacing.xLarge),

                // Divider with "OR"
                Row(
                  children: <Widget>[
                    const Expanded(
                      child: Divider(
                        thickness: 1,
                        indent: 20,
                        endIndent: 10,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8),
                      child: Text(
                        'OR',
                        style: AppTypography.bodyText2.copyWith(
                          color: Theme.of(context).colorScheme.onSurfaceVariant,
                        ),
                      ),
                    ),
                    const Expanded(
                      child: Divider(
                        thickness: 1,
                        indent: 10,
                        endIndent: 20,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: AppSpacing.xLarge),

                // Social Login Placeholders
                const SocialLoginPlaceholder(),
                const SizedBox(height: AppSpacing.xLarge),

                // Register Link
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Text(
                      "Don't have an account? ",
                      style: AppTypography.bodyText2.copyWith(
                        color: Theme.of(context).colorScheme.onSurfaceVariant,
                      ),
                    ),
                    TextButton(
                      onPressed: () {
                        context.go('/register');
                      },
                      child: Text(
                        'Register',
                        style: AppTypography.bodyText2.copyWith(
                          color: Theme.of(context).colorScheme.primary,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
