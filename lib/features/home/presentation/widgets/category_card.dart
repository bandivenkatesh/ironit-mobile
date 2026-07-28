/// Category Card Widget
/// Displays a category with icon, name, and service count
library;

import 'package:flutter/material.dart';

import '../../../../core/theme/app_spacing.dart';
import '../../../../core/theme/app_typography.dart';
import '../../domain/models/category.dart';

class CategoryCard extends StatelessWidget {
  final Category category;
  final VoidCallback? onTap;
  final bool isSelected;

  const CategoryCard({
    super.key,
    required this.category,
    this.onTap,
    this.isSelected = false,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(AppSpacing.medium),
      child: Container(
        width: 100,
        padding: const EdgeInsets.all(AppSpacing.small),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            // Category Icon
            Container(
              width: 56,
              height: 56,
              decoration: BoxDecoration(
                color: isSelected
                    ? Theme.of(context).colorScheme.primaryContainer
                    : Theme.of(context).colorScheme.surfaceContainerHighest,
                shape: BoxShape.circle,
              ),
              child: Icon(
                _getIconForCategory(category.icon),
                color: isSelected
                    ? Theme.of(context).colorScheme.onPrimaryContainer
                    : Theme.of(context).colorScheme.onSurfaceVariant,
                size: 28,
              ),
            ),
            const SizedBox(height: AppSpacing.xSmall),

            // Category Name
            Text(
              category.name,
              style: AppTypography.bodyText2.copyWith(
                fontWeight: FontWeight.w500,
                color: isSelected
                    ? Theme.of(context).colorScheme.primary
                    : Theme.of(context).colorScheme.onSurface,
              ),
              textAlign: TextAlign.center,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            ),
            const SizedBox(height: AppSpacing.xSmall),

            // Service Count
            Text(
              '${category.serviceCount} services',
              style: AppTypography.caption.copyWith(
                color: Theme.of(context).colorScheme.onSurfaceVariant,
              ),
            ),
          ],
        ),
      ),
    );
  }

  /// Get icon data for category icon string
  IconData _getIconForCategory(String iconName) {
    switch (iconName) {
      case 'shirt':
        return Icons.checkroom;
      case 'suit':
        return Icons.business_center;
      case 'tshirt':
        return Icons.face;
      case 'fabric':
        return Icons.brush;
      case 'bed':
        return Icons.bed;
      case 'briefcase':
        return Icons.work;
      case 'dress':
        return Icons.celebration;
      case 'child':
        return Icons.child_friendly;
      default:
        return Icons.category;
    }
  }
}
