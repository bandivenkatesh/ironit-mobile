/// About Page
/// Simple page with app information
import 'package:flutter/material.dart';

import '../../../../core/theme/app_spacing.dart';
import '../../../../core/theme/app_typography.dart';

class AboutPage extends StatelessWidget {
  const AboutPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'About Ironit',
          style: AppTypography.headline6.copyWith(
            fontWeight: FontWeight.w600,
          ),
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(AppSpacing.medium),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              // App icon and name
              Center(
                child: Column(
                  children: <Widget>[
                    const Icon(
                      Icons.iron_outlined,
                      size: 80,
                      color: Colors.blue,
                    ),
                    const SizedBox(height: AppSpacing.medium),
                    Text(
                      'Ironit',
                      style: AppTypography.headline4.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: AppSpacing.xSmall),
                    Text(
                      'Premium Ironing Services',
                      style: AppTypography.bodyText1.copyWith(
                        color: Theme.of(context).colorScheme.onSurfaceVariant,
                      ),
                    ),
                    const SizedBox(height: AppSpacing.large),
                  ],
                ),
              ),

              // App description
              Text(
                'About Ironit',
                style: AppTypography.headline6.copyWith(
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: AppSpacing.small),
              Text(
                'Ironit is your premium on-demand ironing service. We provide professional, high-quality ironing services at your convenience. Our experienced professionals use state-of-the-art equipment to ensure your clothes look their best.',
                style: AppTypography.bodyText1,
              ),
              const SizedBox(height: AppSpacing.large),

              // Version info
              Text(
                'App Information',
                style: AppTypography.headline6.copyWith(
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: AppSpacing.small),
              _buildInfoRow(context, 'Version', '1.0.0'),
              const SizedBox(height: AppSpacing.xSmall),
              _buildInfoRow(context, 'Build', '202307'),
              const SizedBox(height: AppSpacing.xSmall),
              _buildInfoRow(context, 'Last Updated', 'July 2023'),
              const SizedBox(height: AppSpacing.large),

              // Contact info
              Text(
                'Contact Us',
                style: AppTypography.headline6.copyWith(
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: AppSpacing.small),
              _buildInfoRow(context, 'Email', 'support@ironit.com'),
              const SizedBox(height: AppSpacing.xSmall),
              _buildInfoRow(context, 'Phone', '(555) 123-4567'),
              const SizedBox(height: AppSpacing.xSmall),
              _buildInfoRow(context, 'Website', 'www.ironit.com'),
              const SizedBox(height: AppSpacing.large),

              // Legal info
              Text(
                'Legal',
                style: AppTypography.headline6.copyWith(
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: AppSpacing.small),
              InkWell(
                onTap: () {
                  // TODO: Show privacy policy
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text('Privacy policy coming soon!'),
                      behavior: SnackBarBehavior.floating,
                    ),
                  );
                },
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                      vertical: AppSpacing.xSmall),
                  child: Text(
                    'Privacy Policy',
                    style: AppTypography.bodyText1.copyWith(
                      color: Theme.of(context).colorScheme.primary,
                      decoration: TextDecoration.underline,
                    ),
                  ),
                ),
              ),
              InkWell(
                onTap: () {
                  // TODO: Show terms of service
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text('Terms of service coming soon!'),
                      behavior: SnackBarBehavior.floating,
                    ),
                  );
                },
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                      vertical: AppSpacing.xSmall),
                  child: Text(
                    'Terms of Service',
                    style: AppTypography.bodyText1.copyWith(
                      color: Theme.of(context).colorScheme.primary,
                      decoration: TextDecoration.underline,
                    ),
                  ),
                ),
              ),
              const SizedBox(height: AppSpacing.xLarge),
            ],
          ),
        ),
      ),
    );
  }

  /// Build info row
  Widget _buildInfoRow(BuildContext context, String label, String value) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        SizedBox(
          width: 120,
          child: Text(
            label,
            style: AppTypography.bodyText1.copyWith(
              fontWeight: FontWeight.bold,
              color: Theme.of(context).colorScheme.onSurfaceVariant,
            ),
          ),
        ),
        const SizedBox(width: AppSpacing.small),
        Expanded(
          child: Text(
            value,
            style: AppTypography.bodyText1,
          ),
        ),
      ],
    );
  }
}