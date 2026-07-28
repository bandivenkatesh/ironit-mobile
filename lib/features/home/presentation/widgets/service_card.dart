/// Service Card Widget
/// Displays a service with image, name, rating, price, and duration
library;

import 'package:flutter/material.dart';

import '../../../../core/theme/app_spacing.dart';
import '../../../../core/theme/app_typography.dart';
import '../../../../core/theme/app_colors.dart';
import '../../domain/models/service.dart';

class ServiceCard extends StatelessWidget {
  final Service service;
  final VoidCallback? onTap;
  final bool showFavorite;
  final bool isCompact;
  final bool showCategory;

  const ServiceCard({
    super.key,
    required this.service,
    this.onTap,
    this.showFavorite = true,
    this.isCompact = false,
    this.showCategory = false,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(AppSpacing.medium),
      ),
      elevation: isCompact ? 1 : 2,
      surfaceTintColor: Theme.of(context).colorScheme.surfaceTint,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(AppSpacing.medium),
        overlayColor: MaterialStateProperty.all(
          Theme.of(context).colorScheme.primary.withOpacity(0.08),
        ),
        child: Padding(
          padding:
              EdgeInsets.all(isCompact ? AppSpacing.small : AppSpacing.medium),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              // Service Image with Category Badge
              Stack(
                children: <Widget>[
                  ClipRRect(
                    borderRadius: BorderRadius.circular(AppSpacing.small),
                    child: Container(
                      height: isCompact ? 100 : 120,
                      width: double.infinity,
                      color:
                          Theme.of(context).colorScheme.surfaceContainerHighest,
                      child: service.imageUrl.isNotEmpty
                          ? Image.network(
                              service.imageUrl,
                              fit: BoxFit.cover,
                              errorBuilder: (
                                BuildContext context,
                                Object error,
                                StackTrace? stackTrace,
                              ) {
                                return Center(
                                  child: Icon(
                                    Icons.iron_outlined,
                                    size: 40,
                                    color: Theme.of(context)
                                        .colorScheme
                                        .onSurfaceVariant,
                                  ),
                                );
                              },
                              loadingBuilder: (
                                BuildContext context,
                                Widget child,
                                ImageChunkEvent? loadingProgress,
                              ) {
                                if (loadingProgress == null) return child;
                                return Center(
                                  child: CircularProgressIndicator(
                                    value: loadingProgress.expectedTotalBytes !=
                                            null
                                        ? loadingProgress
                                                .cumulativeBytesLoaded /
                                            loadingProgress.expectedTotalBytes!
                                        : null,
                                    strokeWidth: 2,
                                  ),
                                );
                              },
                            )
                          : Center(
                              child: Icon(
                                Icons.iron_outlined,
                                size: 40,
                                color: Theme.of(context)
                                    .colorScheme
                                    .onSurfaceVariant,
                              ),
                            ),
                    ),
                  ),
                  if (showCategory)
                    Positioned(
                      top: AppSpacing.small,
                      right: AppSpacing.small,
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: AppSpacing.xSmall,
                          vertical: AppSpacing.xxSmall,
                        ),
                        decoration: BoxDecoration(
                          color: Theme.of(context).colorScheme.primaryContainer,
                          borderRadius:
                              BorderRadius.circular(AppSpacing.xSmall),
                        ),
                        child: Text(
                          'Premium',
                          style: AppTypography.caption.copyWith(
                            color: Theme.of(context)
                                .colorScheme
                                .onPrimaryContainer,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ),
                ],
              ),
              const SizedBox(height: AppSpacing.small),

              // Service Info
              Text(
                service.name,
                style: AppTypography.bodyText1.copyWith(
                  fontWeight: FontWeight.w600,
                ),
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
              const SizedBox(height: AppSpacing.xSmall),

              // Rating and Reviews
              Row(
                children: <Widget>[
                  Icon(
                    Icons.star_rounded,
                    color: Colors.amber,
                    size: 16,
                  ),
                  const SizedBox(width: AppSpacing.xSmall),
                  Text(
                    service.rating.toString(),
                    style: AppTypography.caption.copyWith(
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  const SizedBox(width: AppSpacing.xSmall),
                  Text(
                    '(${service.reviewCount} reviews)',
                    style: AppTypography.caption.copyWith(
                      color: Theme.of(context).colorScheme.onSurfaceVariant,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: AppSpacing.small),

              // Price and Duration
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Row(
                    children: <Widget>[
                      Text(
                        '₹${service.price.toStringAsFixed(0)}',
                        style: AppTypography.subtitle1.copyWith(
                          fontWeight: FontWeight.bold,
                          color: Theme.of(context).colorScheme.primary,
                        ),
                      ),
                      if (service.isPopular)
                        Padding(
                          padding:
                              const EdgeInsets.only(left: AppSpacing.xSmall),
                          child: Icon(
                            Icons.whatshot,
                            color: Theme.of(context).colorScheme.secondary,
                            size: 16,
                          ),
                        ),
                    ],
                  ),
                  Row(
                    children: <Widget>[
                      Icon(
                        Icons.timer_outlined,
                        size: 16,
                        color: Theme.of(context).colorScheme.onSurfaceVariant,
                      ),
                      const SizedBox(width: AppSpacing.xSmall),
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

              if (showFavorite && !isCompact) ...<Widget>[
                const SizedBox(height: AppSpacing.small),
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
