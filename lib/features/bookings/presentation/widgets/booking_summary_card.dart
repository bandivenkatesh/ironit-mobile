/// Booking Summary Card Widget
/// Reusable component for displaying booking summary
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';

import '../../../../core/theme/app_spacing.dart';
import '../../../../core/theme/app_typography.dart';
import '../providers/booking_providers.dart';
import '../../domain/models/booking_summary.dart';

class BookingSummaryCard extends ConsumerWidget {
  final BookingSummary bookingSummary;

  const BookingSummaryCard({
    super.key,
    required this.bookingSummary,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final DateFormat dateFormat = DateFormat('EEEE, MMMM d, yyyy');
    final DateFormat timeFormat = DateFormat('h:mm a');

    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(AppSpacing.large),
      ),
      child: Padding(
        padding: const EdgeInsets.all(AppSpacing.medium),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            // Booking reference and status
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Text(
                  'Booking #${bookingSummary.bookingReference}',
                  style: AppTypography.headline6.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
                ),
                _buildStatusChip(context, bookingSummary.status),
              ],
            ),
            const SizedBox(height: AppSpacing.small),
            const Divider(),
            const SizedBox(height: AppSpacing.small),

            // Service information
            Text(
              'Service',
              style: AppTypography.bodyText1.copyWith(
                fontWeight: FontWeight.bold,
                color: Theme.of(context).colorScheme.onSurfaceVariant,
              ),
            ),
            const SizedBox(height: AppSpacing.xSmall),
            Text(
              bookingSummary.service.name,
              style: AppTypography.headline6.copyWith(
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: AppSpacing.small),

            // Date and time
            Row(
              children: <Widget>[
                const Icon(
                  Icons.calendar_today,
                  size: 16,
                  color: Colors.grey,
                ),
                const SizedBox(width: AppSpacing.xSmall),
                Text(
                  dateFormat.format(bookingSummary.bookingDate),
                  style: AppTypography.bodyText2,
                ),
                const SizedBox(width: AppSpacing.medium),
                const Icon(
                  Icons.access_time,
                  size: 16,
                  color: Colors.grey,
                ),
                const SizedBox(width: AppSpacing.xSmall),
                Text(
                  timeFormat.format(bookingSummary.timeSlot.startTime),
                  style: AppTypography.bodyText2,
                ),
              ],
            ),
            const SizedBox(height: AppSpacing.small),

            // Address
            Text(
              'Delivery Address',
              style: AppTypography.bodyText1.copyWith(
                fontWeight: FontWeight.bold,
                color: Theme.of(context).colorScheme.onSurfaceVariant,
              ),
            ),
            const SizedBox(height: AppSpacing.xSmall),
            Text(
              bookingSummary.address.formattedAddress,
              style: AppTypography.bodyText2,
            ),
            const SizedBox(height: AppSpacing.small),

            // Selected options
            if (bookingSummary.selectedOptions.isNotEmpty) ...<Widget>[
              Text(
                'Selected Options',
                style: AppTypography.bodyText1.copyWith(
                  fontWeight: FontWeight.bold,
                  color: Theme.of(context).colorScheme.onSurfaceVariant,
                ),
              ),
              const SizedBox(height: AppSpacing.xSmall),
              ...bookingSummary.selectedOptions.map((option) {
                return Padding(
                  padding: const EdgeInsets.only(bottom: AppSpacing.xSmall),
                  child: Row(
                    children: <Widget>[
                      const Icon(
                        Icons.check_circle,
                        size: 16,
                        color: Colors.green,
                      ),
                      const SizedBox(width: AppSpacing.xSmall),
                      Expanded(
                        child: Text(
                          option.name,
                          style: AppTypography.bodyText2,
                        ),
                      ),
                      if (option.price > 0)
                        Text(
                          '+ ₹${option.price.toStringAsFixed(2)}',
                          style: AppTypography.bodyText2.copyWith(
                            color: Theme.of(context).colorScheme.primary,
                          ),
                        ),
                    ],
                  ),
                );
              }).toList(),
              const SizedBox(height: AppSpacing.small),
            ],

            // Notes
            if (bookingSummary.notes.isNotEmpty) ...<Widget>[
              Text(
                'Special Instructions',
                style: AppTypography.bodyText1.copyWith(
                  fontWeight: FontWeight.bold,
                  color: Theme.of(context).colorScheme.onSurfaceVariant,
                ),
              ),
              const SizedBox(height: AppSpacing.xSmall),
              Text(
                bookingSummary.notes,
                style: AppTypography.bodyText2,
              ),
              const SizedBox(height: AppSpacing.small),
            ],

            const Divider(),
            const SizedBox(height: AppSpacing.small),

            // Price summary
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Text(
                  'Total Price',
                  style: AppTypography.bodyText1.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  '₹${bookingSummary.totalPrice.toStringAsFixed(2)}',
                  style: AppTypography.headline6.copyWith(
                    fontWeight: FontWeight.bold,
                    color: Theme.of(context).colorScheme.primary,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  /// Build status chip based on booking status
  Widget _buildStatusChip(BuildContext context, String status) {
    Color chipColor;
    Color textColor;
    String displayText;

    switch (status.toLowerCase()) {
      case 'confirmed':
        chipColor = Theme.of(context).colorScheme.primaryContainer;
        textColor = Theme.of(context).colorScheme.primary;
        displayText = 'Confirmed';
        break;
      case 'in_progress':
        chipColor = Theme.of(context).colorScheme.secondaryContainer;
        textColor = Theme.of(context).colorScheme.secondary;
        displayText = 'In Progress';
        break;
      case 'completed':
        chipColor = Colors.green.shade100;
        textColor = Colors.green.shade800;
        displayText = 'Completed';
        break;
      case 'cancelled':
        chipColor = Colors.red.shade100;
        textColor = Colors.red.shade800;
        displayText = 'Cancelled';
        break;
      default:
        chipColor = Theme.of(context).colorScheme.surfaceContainerHighest;
        textColor = Theme.of(context).colorScheme.onSurface;
        displayText = status;
    }

    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: AppSpacing.small,
        vertical: AppSpacing.xxSmall,
      ),
      decoration: BoxDecoration(
        color: chipColor,
        borderRadius: BorderRadius.circular(AppSpacing.large),
      ),
      child: Text(
        displayText,
        style: AppTypography.bodyText2.copyWith(
          color: textColor,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}
