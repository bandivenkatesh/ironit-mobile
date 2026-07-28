/// Promotion Banner Widget
/// Displays a promotional banner with image, title, subtitle, and action button
import 'package:flutter/material.dart';

import '../../../../core/theme/app_spacing.dart';
import '../../../../core/theme/app_typography.dart';
import '../../domain/models/promotion.dart';

class PromotionBanner extends StatelessWidget {
  final Promotion promotion;
  final VoidCallback? onAction;

  const PromotionBanner({
    super.key,
    required this.promotion,
    this.onAction,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(AppSpacing.medium),
      ),
      elevation: 0,
      margin: EdgeInsets.zero,
      child: Stack(
        children: [
          // Banner Image
          ClipRRect(
            borderRadius: BorderRadius.circular(AppSpacing.medium),
            child: Image.network(
              promotion.imageUrl,
              height: 160,
              width: double.infinity,
              fit: BoxFit.cover,
              errorBuilder: (context, error, stackTrace) {
                return Container(
                  height: 160,
                  color: Theme.of(context).colorScheme.primaryContainer,
                  child: Icon(
                    Icons.local_offer,
                    size: 60,
                    color: Theme.of(context).colorScheme.onPrimaryContainer,
                  ),
                );
              },
              loadingBuilder: (context, child, loadingProgress) {
                if (loadingProgress == null) return child;
                return Container(
                  height: 160,
                  color: Theme.of(context).colorScheme.primaryContainer,
                  child: Center(
                    child: CircularProgressIndicator(
                      value: loadingProgress.expectedTotalBytes != null
                          ? loadingProgress.cumulativeBytesLoaded /
                              loadingProgress.expectedTotalBytes!
                          : null,
                      color: Theme.of(context).colorScheme.onPrimaryContainer,
                    ),
                  ),
                );
              },
            ),
          ),

          // Overlay Gradient
          Container(
            height: 160,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(AppSpacing.medium),
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  Colors.transparent,
                  Colors.black.withOpacity(0.6),
                ],
              ),
            ),
          ),

          // Banner Content
          Positioned(
            left: AppSpacing.medium,
            right: AppSpacing.medium,
            bottom: AppSpacing.medium,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Promotion Title
                Text(
                  promotion.title,
                  style: AppTypography.headline6.copyWith(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: AppSpacing.xSmall),

                // Promotion Subtitle
                Text(
                  promotion.subtitle,
                  style: AppTypography.bodyText1.copyWith(
                    color: Colors.white.withOpacity(0.9),
                  ),
                ),
                SizedBox(height: AppSpacing.small),

                // Action Button
                ElevatedButton(
                  onPressed: onAction,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Theme.of(context).colorScheme.primary,
                    foregroundColor: Theme.of(context).colorScheme.onPrimary,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(AppSpacing.small),
                    ),
                    padding: EdgeInsets.symmetric(
                      horizontal: AppSpacing.medium,
                      vertical: AppSpacing.xSmall,
                    ),
                  ),
                  child: Text(promotion.actionText),
                ),
              ],
            ),
          ),

          // Promotion Tag
          if (promotion.isValid) ...[
            Positioned(
              top: AppSpacing.small,
              right: AppSpacing.small,
              child: Container(
                padding: EdgeInsets.symmetric(
                  horizontal: AppSpacing.xSmall,
                  vertical: AppSpacing.xxSmall,
                ),
                decoration: BoxDecoration(
                  color: Theme.of(context).colorScheme.secondary,
                  borderRadius: BorderRadius.circular(AppSpacing.xSmall),
                ),
                child: Text(
                  'ONGOING',
                  style: AppTypography.caption.copyWith(
                    color: Theme.of(context).colorScheme.onSecondary,
                    fontWeight: FontWeight.bold,
                    letterSpacing: 0.5,
                  ),
                ),
              ),
            ),
          ],
        ],
      ),
    );
  }
}