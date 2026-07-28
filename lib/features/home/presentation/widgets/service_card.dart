/// Service Card Widget
/// Displays a service with image, name, rating, price, and duration
import 'package:flutter/material.dart';

import '../../../../core/theme/app_spacing.dart';
import '../../../../core/theme/app_typography.dart';
import '../../domain/models/service.dart';

class ServiceCard extends StatelessWidget {
  final Service service;
  final VoidCallback? onTap;
  final bool showFavorite;
  final bool isCompact;

  const ServiceCard({
    super.key,
    required this.service,
    this.onTap,
    this.showFavorite = true,
    this.isCompact = false,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(AppSpacing.medium),
      ),
      elevation: 2,
      surfaceTintColor: Theme.of(context).colorScheme.surfaceTint,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(AppSpacing.medium),
        child: Padding(
          padding: EdgeInsets.all(isCompact ? AppSpacing.small : AppSpacing.medium),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Service Image
              ClipRRect(
                borderRadius: BorderRadius.circular(AppSpacing.small),
                child: Image.network(
                  service.imageUrl,
                  height: isCompact ? 100 : 120,
                  width: double.infinity,
                  fit: BoxFit.cover,
                  errorBuilder: (context, error, stackTrace) {
                    return Container(
                      height: isCompact ? 100 : 120,
                      color: Theme.of(context).colorScheme.surfaceVariant,
                      child: Icon(
                        Icons.iron_outlined,
                        size: 40,
                        color: Theme.of(context).colorScheme.onSurfaceVariant,
                      ),
                    );
                  },
                  loadingBuilder: (context, child, loadingProgress) {
                    if (loadingProgress == null) return child;
                    return Container(
                      height: isCompact ? 100 : 120,
                      color: Theme.of(context).colorScheme.surfaceVariant,
                      child: Center(
                        child: CircularProgressIndicator(
                          value: loadingProgress.expectedTotalBytes != null
                              ? loadingProgress.cumulativeBytesLoaded /
                                  loadingProgress.expectedTotalBytes!
                              : null,
                        ),
                      ),
                    );
                  },
                ),
              ),
              SizedBox(height: AppSpacing.small),

              // Service Info
              Text(
                service.name,
                style: AppTypography.bodyText1.copyWith(
                  fontWeight: FontWeight.w600,
                ),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
              SizedBox(height: AppSpacing.xSmall),

              // Rating and Reviews
              Row(
                children: [
                  Icon(
                    Icons.star,
                    color: Colors.amber,
                    size: 16,
                  ),
                  SizedBox(width: AppSpacing.xSmall),
                  Text(
                    service.rating.toString(),
                    style: AppTypography.caption.copyWith(
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  SizedBox(width: AppSpacing.xSmall),
                  Text(
                    '(${service.reviewCount} reviews)',
                    style: AppTypography.caption.copyWith(
                      color: Theme.of(context).colorScheme.onSurfaceVariant,
                    ),
                  ),
                ],
              ),
              SizedBox(height: AppSpacing.small),

              // Price and Duration
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    '₹${service.price.toStringAsFixed(0)}',
                    style: AppTypography.subtitle1.copyWith(
                      fontWeight: FontWeight.bold,
                      color: Theme.of(context).colorScheme.primary,
                    ),
                  ),
                  Row(
                    children: [
                      Icon(
                        Icons.timer_outlined,
                        size: 16,
                        color: Theme.of(context).colorScheme.onSurfaceVariant,
                      ),
                      SizedBox(width: AppSpacing.xSmall),
                      Text(
                        '${service.estimatedDuration.inMinutes} min',
                        style: AppTypography.caption.copyWith(
                          color: Theme.of(context).colorScheme.onSurfaceVariant,
                        ),
                      ),
                    ],
                  ),
                ],
              ),

              if (showFavorite && !isCompact) ...[
                SizedBox(height: AppSpacing.small),
                // Favorite Button
                Align(
                  alignment: Alignment.centerRight,
                  child: IconButton(
                    icon: Icon(
                      Icons.favorite_border,
                      color: Theme.of(context).colorScheme.onSurfaceVariant,
                    ),
                    onPressed: () {
                      // TODO: Implement favorite functionality
                    },
                    visualDensity: VisualDensity.compact,
                    padding: EdgeInsets.zero,
                    constraints: const BoxConstraints(),
                  ),
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }
}