import 'package:flutter/material.dart';

import '../../../../core/theme/app_spacing.dart';
import '../../../../core/theme/app_typography.dart';

/// Social login buttons placeholder.
/// Shows "Coming Soon" for social authentication options.
class SocialLoginPlaceholder extends StatelessWidget {
  const SocialLoginPlaceholder({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        // Google Sign-In
        _buildSocialButton(
          context,
          icon: Icons.mail_outline,
          label: 'Continue with Google',
          color: Theme.of(context).colorScheme.surfaceContainerHighest,
          textColor: Theme.of(context).colorScheme.onSurface,
        ),
        const SizedBox(height: AppSpacing.medium),
        // Apple Sign-In
        _buildSocialButton(
          context,
          icon: Icons.apple,
          label: 'Continue with Apple',
          color: Theme.of(context).colorScheme.surfaceContainerHighest,
          textColor: Theme.of(context).colorScheme.onSurface,
        ),
        const SizedBox(height: AppSpacing.medium),
        // Facebook Sign-In
        _buildSocialButton(
          context,
          icon: Icons.facebook,
          label: 'Continue with Facebook',
          color: const Color(0xFF1877F2),
          textColor: Colors.white,
        ),
        const SizedBox(height: AppSpacing.small),
        Text(
          'Social login coming soon',
          style: AppTypography.caption.copyWith(
            color: Theme.of(context).colorScheme.onSurfaceVariant,
            fontStyle: FontStyle.italic,
          ),
          textAlign: TextAlign.center,
        ),
      ],
    );
  }

  Widget _buildSocialButton(
    BuildContext context, {
    required IconData icon,
    required String label,
    required Color color,
    required Color textColor,
  }) {
    return SizedBox(
      height: 48,
      child: OutlinedButton(
        onPressed: () {
          // Show "Coming Soon" message
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('Social login coming soon!'),
              behavior: SnackBarBehavior.floating,
            ),
          );
        },
        style: OutlinedButton.styleFrom(
          backgroundColor: color,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8),
          ),
          side: BorderSide(
            color: Theme.of(context).colorScheme.outline,
          ),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Icon(
              icon,
              color: textColor,
              size: 20,
            ),
            const SizedBox(width: AppSpacing.small),
            Text(
              label,
              style: AppTypography.button.copyWith(
                color: textColor,
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
