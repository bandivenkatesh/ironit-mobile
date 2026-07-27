import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/theme/app_spacing.dart';
import '../../../../core/theme/app_typography.dart';
import '../../../../core/widgets/app_scaffold.dart';
import '../../../../core/widgets/primary_button.dart';
import '../../../../core/widgets/secondary_button.dart';

/// Premium welcome screen that serves as the first impression of the Ironit app.
/// Provides users with an overview of the service and clear call-to-action options.
class WelcomePage extends StatelessWidget {
  const WelcomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return AppScaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(AppSpacing.medium),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const SizedBox(height: AppSpacing.xLarge),
              // Hero illustration placeholder
              Container(
                height: 240,
                decoration: BoxDecoration(
                  color: Theme.of(context).colorScheme.primaryContainer,
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Center(
                  child: Icon(
                    Icons.local_laundry_service_outlined,
                    size: 120,
                    color: Theme.of(context).colorScheme.primary,
                  ),
                ),
              ),
              const SizedBox(height: AppSpacing.xLarge),
              // App title
              Text(
                'Welcome to Ironit',
                style: AppTypography.headline5.copyWith(
                  color: Theme.of(context).colorScheme.onSurface,
                  fontWeight: FontWeight.w600,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: AppSpacing.small),
              // App description
              Text(
                'Premium ironing services delivered to your doorstep with care and precision.',
                style: AppTypography.bodyText1.copyWith(
                  color: Theme.of(context).colorScheme.onSurfaceVariant,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: AppSpacing.xLarge),
              // Feature highlights
              _buildFeatureCard(
                context,
                icon: Icons.iron_outlined,
                title: 'Professional Ironing',
                description: 'Expert care for all your clothing needs',
              ),
              const SizedBox(height: AppSpacing.medium),
              _buildFeatureCard(
                context,
                icon: Icons.doorbell_outlined,
                title: 'Doorstep Pickup',
                description: 'Convenient collection from your home',
              ),
              const SizedBox(height: AppSpacing.medium),
              _buildFeatureCard(
                context,
                icon: Icons.query_builder_outlined,
                title: 'Fast Delivery',
                description: '24-hour turnaround for most services',
              ),
              const SizedBox(height: AppSpacing.xLarge),
              // Primary CTA - Get Started
              PrimaryButton(
                onPressed: () {
                  // Navigate to placeholder screen (will be replaced with actual login)
                  context.go('/placeholder');
                },
                child: const Text('Get Started'),
              ),
              const SizedBox(height: AppSpacing.medium),
              // Secondary CTA - Continue as Guest
              SecondaryButton(
                onPressed: () {
                  // Navigate to placeholder screen (will be replaced with guest flow)
                  context.go('/guest-placeholder');
                },
                child: const Text('Continue as Guest'),
              ),
              const SizedBox(height: AppSpacing.xLarge),
              // Footer with legal links
              Text(
                'By continuing, you agree to our Terms of Service and Privacy Policy',
                style: AppTypography.caption.copyWith(
                  color: Theme.of(context).colorScheme.onSurfaceVariant,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: AppSpacing.small),
              Text(
                'Version 1.0.0',
                style: AppTypography.caption.copyWith(
                  color: Theme.of(context).colorScheme.outline,
                ),
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
      ),
    );
  }

  /// Builds a feature highlight card for the welcome screen.
  Widget _buildFeatureCard(
    BuildContext context, {
    required IconData icon,
    required String title,
    required String description,
  }) {
    return Container(
      padding: const EdgeInsets.all(AppSpacing.medium),
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.surfaceVariant,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        children: [
          Container(
            width: 48,
            height: 48,
            decoration: BoxDecoration(
              color: Theme.of(context).colorScheme.primaryContainer,
              shape: BoxShape.circle,
            ),
            child: Icon(
              icon,
              size: 24,
              color: Theme.of(context).colorScheme.primary,
            ),
          ),
          const SizedBox(width: AppSpacing.medium),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: AppTypography.subtitle1.copyWith(
                    color: Theme.of(context).colorScheme.onSurface,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                const SizedBox(height: AppSpacing.xSmall),
                Text(
                  description,
                  style: AppTypography.bodyText2.copyWith(
                    color: Theme.of(context).colorScheme.onSurfaceVariant,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
