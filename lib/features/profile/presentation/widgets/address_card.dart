/// Address Card
/// Reusable widget for displaying address information
import 'package:flutter/material.dart';

import '../../../../core/theme/app_spacing.dart';
import '../../../../core/theme/app_typography.dart';

class AddressCard extends StatelessWidget {
  final Map<String, dynamic> address;
  final VoidCallback onEdit;
  final VoidCallback onDelete;
  final VoidCallback? onSetDefault;

  const AddressCard({
    super.key,
    required this.address,
    required this.onEdit,
    required this.onDelete,
    this.onSetDefault,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 1,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(AppSpacing.medium),
      ),
      child: Padding(
        padding: const EdgeInsets.all(AppSpacing.medium),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            // Address label and default badge
            Row(
              children: <Widget>[
                Text(
                  address['label'] as String,
                  style: AppTypography.bodyText1.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const Spacer(),
                if (address['isDefault'] as bool)
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: AppSpacing.xSmall,
                      vertical: AppSpacing.xxSmall,
                    ),
                    decoration: BoxDecoration(
                      color: Theme.of(context).colorScheme.primaryContainer,
                      borderRadius: BorderRadius.circular(AppSpacing.xSmall),
                    ),
                    child: Text(
                      'DEFAULT',
                      style: AppTypography.bodyText2.copyWith(
                        color: Theme.of(context).colorScheme.primary,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
              ],
            ),
            const SizedBox(height: AppSpacing.small),

            // Address details
            Text(
              address['formattedAddress'] as String,
              style: AppTypography.bodyText1,
            ),
            const SizedBox(height: AppSpacing.small),

            // Address type
            Text(
              _getAddressTypeLabel(address['type'] as String),
              style: AppTypography.bodyText2.copyWith(
                color: Theme.of(context).colorScheme.onSurfaceVariant,
              ),
            ),
            const SizedBox(height: AppSpacing.medium),

            // Action buttons
            Row(
              children: <Widget>[
                Expanded(
                  child: OutlinedButton.icon(
                    onPressed: onEdit,
                    icon: const Icon(Icons.edit, size: 18),
                    label: const Text('Edit'),
                    style: OutlinedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(
                          vertical: AppSpacing.xSmall),
                      shape: RoundedRectangleBorder(
                        borderRadius:
                            BorderRadius.circular(AppSpacing.xSmall),
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: AppSpacing.small),
                if (onSetDefault != null)
                  Expanded(
                    child: OutlinedButton.icon(
                      onPressed: onSetDefault,
                      icon: const Icon(Icons.star, size: 18),
                      label: const Text('Set Default'),
                      style: OutlinedButton.styleFrom(
                        padding: const EdgeInsets.symmetric(
                            vertical: AppSpacing.xSmall),
                        shape: RoundedRectangleBorder(
                          borderRadius:
                              BorderRadius.circular(AppSpacing.xSmall),
                        ),
                      ),
                    ),
                  ),
                if (onSetDefault != null)
                  const SizedBox(width: AppSpacing.small),
                Expanded(
                  child: OutlinedButton.icon(
                    onPressed: onDelete,
                    icon: const Icon(Icons.delete, size: 18),
                    label: const Text('Delete'),
                    style: OutlinedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(
                          vertical: AppSpacing.xSmall),
                      shape: RoundedRectangleBorder(
                        borderRadius:
                            BorderRadius.circular(AppSpacing.xSmall),
                      ),
                      side: BorderSide(
                        color: Theme.of(context).colorScheme.error,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  /// Get address type label
  String _getAddressTypeLabel(String type) {
    switch (type) {
      case 'home':
        return 'Home Address';
      case 'work':
        return 'Work Address';
      case 'other':
        return 'Other Location';
      default:
        return 'Unknown Type';
    }
  }
}