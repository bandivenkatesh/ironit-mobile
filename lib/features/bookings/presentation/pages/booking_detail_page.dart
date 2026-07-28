/// Booking Detail Page
/// Detailed view of an individual booking with all information
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';

import '../../../../core/theme/app_spacing.dart';
import '../../../../core/theme/app_typography.dart';
import '../../../../core/widgets/loading_widget.dart';
import '../../domain/models/address.dart';
import '../../domain/models/service_option.dart';
import '../providers/booking_providers.dart';
import '../../domain/models/booking_summary.dart';

/// Timeline step model for booking status timeline
class TimelineStep {
  final String title;
  final String subtitle;
  final IconData icon;
  final Color color;
  final bool completed;

  const TimelineStep({
    required this.title,
    required this.subtitle,
    required this.icon,
    required this.color,
    required this.completed,
  });
}

class BookingDetailPage extends ConsumerWidget {
  final String bookingId;

  const BookingDetailPage({
    super.key,
    required this.bookingId,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final AsyncValue<BookingSummary> bookingAsync =
        ref.watch(bookingSummaryProvider);

    return Scaffold(
      appBar: _buildAppBar(context),
      body: bookingAsync.when(
        loading: () => const LoadingWidget(),
        error: (Object error, StackTrace stack) => Center(
          child: Text(
            'Failed to load booking details',
            style: AppTypography.bodyText1.copyWith(
              color: Theme.of(context).colorScheme.error,
            ),
          ),
        ),
        data: (BookingSummary booking) {
          return _buildBookingDetailContent(context, booking);
        },
      ),
    );
  }

  /// Build the app bar
  AppBar _buildAppBar(BuildContext context) {
    return AppBar(
      title: Text(
        'Booking Details',
        style: AppTypography.headline6.copyWith(
          fontWeight: FontWeight.w600,
        ),
      ),
      centerTitle: true,
    );
  }

  /// Build the booking detail content
  Widget _buildBookingDetailContent(
      BuildContext context, BookingSummary booking) {
    final DateFormat dateFormat = DateFormat('EEEE, MMMM d, yyyy');
    final DateFormat timeFormat = DateFormat('h:mm a');

    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          // Booking header with status
          Container(
            padding: const EdgeInsets.all(AppSpacing.medium),
            decoration: BoxDecoration(
              color: Theme.of(context).colorScheme.primaryContainer,
              borderRadius: const BorderRadius.only(
                bottomLeft: Radius.circular(AppSpacing.large),
                bottomRight: Radius.circular(AppSpacing.large),
              ),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Text(
                      'Booking #${booking.bookingReference}',
                      style: AppTypography.headline5.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    _buildStatusChip(context, booking.status),
                  ],
                ),
                const SizedBox(height: AppSpacing.small),
                Text(
                  booking.service.name,
                  style: AppTypography.headline6.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: AppSpacing.small),
                Text(
                  'Scheduled for ${dateFormat.format(booking.bookingDate)} at ${timeFormat.format(booking.timeSlot.startTime)}',
                  style: AppTypography.bodyText1.copyWith(
                    color: Theme.of(context).colorScheme.onSurfaceVariant,
                  ),
                ),
              ],
            ),
          ),

          // Booking information sections
          Padding(
            padding: const EdgeInsets.all(AppSpacing.medium),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                // Service information
                _buildSectionHeader(context, 'Service Information'),
                const SizedBox(height: AppSpacing.small),
                _buildInfoCard(
                  context,
                  'Service',
                  booking.service.name,
                  icon: Icons.local_laundry_service,
                ),
                const SizedBox(height: AppSpacing.small),
                _buildInfoCard(
                  context,
                  'Duration',
                  '${booking.service.estimatedDuration.inMinutes} minutes',
                  icon: Icons.timer,
                ),
                const SizedBox(height: AppSpacing.small),
                _buildInfoCard(
                  context,
                  'Category',
                  'Ironing Service',
                  icon: Icons.category,
                ),

                const SizedBox(height: AppSpacing.large),

                // Schedule information
                _buildSectionHeader(context, 'Schedule'),
                const SizedBox(height: AppSpacing.small),
                _buildInfoCard(
                  context,
                  'Date',
                  dateFormat.format(booking.bookingDate),
                  icon: Icons.calendar_today,
                ),
                const SizedBox(height: AppSpacing.small),
                _buildInfoCard(
                  context,
                  'Time',
                  '${timeFormat.format(booking.timeSlot.startTime)} - ${timeFormat.format(booking.timeSlot.endTime)}',
                  icon: Icons.access_time,
                ),

                const SizedBox(height: AppSpacing.large),

                // Location information
                _buildSectionHeader(context, 'Location'),
                const SizedBox(height: AppSpacing.small),
                _buildAddressCard(context, booking.address),

                const SizedBox(height: AppSpacing.large),

                // Service options
                if (booking.selectedOptions.isNotEmpty) ...<Widget>[
                  _buildSectionHeader(context, 'Service Options'),
                  const SizedBox(height: AppSpacing.small),
                  ...booking.selectedOptions.map((option) {
                    return Padding(
                      padding: const EdgeInsets.only(bottom: AppSpacing.small),
                      child: _buildOptionCard(context, option),
                    );
                  }).toList(),
                ],

                const SizedBox(height: AppSpacing.large),

                // Notes
                if (booking.notes.isNotEmpty) ...<Widget>[
                  _buildSectionHeader(context, 'Special Instructions'),
                  const SizedBox(height: AppSpacing.small),
                  _buildNotesCard(context, booking.notes),
                ],

                const SizedBox(height: AppSpacing.large),

                // Price breakdown
                _buildSectionHeader(context, 'Price Breakdown'),
                const SizedBox(height: AppSpacing.small),
                _buildPriceBreakdown(context, booking),

                const SizedBox(height: AppSpacing.large),

                // Booking status timeline
                _buildSectionHeader(context, 'Booking Status'),
                const SizedBox(height: AppSpacing.small),
                _buildStatusTimeline(context, booking.status),

                const SizedBox(height: AppSpacing.xLarge),

                // Action buttons
                if (booking.status.toLowerCase() == 'confirmed')
                  _buildActionButtons(context, booking),
              ],
            ),
          ),
        ],
      ),
    );
  }

  /// Build section header
  Widget _buildSectionHeader(BuildContext context, String title) {
    return Text(
      title,
      style: AppTypography.headline6.copyWith(
        fontWeight: FontWeight.bold,
      ),
    );
  }

  /// Build info card
  Widget _buildInfoCard(
    BuildContext context,
    String label,
    String value, {
    IconData? icon,
  }) {
    return Card(
      elevation: 1,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(AppSpacing.medium),
      ),
      child: Padding(
        padding: const EdgeInsets.all(AppSpacing.medium),
        child: Row(
          children: <Widget>[
            if (icon != null) ...<Widget>[
              Icon(
                icon,
                size: 24,
                color: Theme.of(context).colorScheme.primary,
              ),
              const SizedBox(width: AppSpacing.medium),
            ],
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  label,
                  style: AppTypography.bodyText2.copyWith(
                    color: Theme.of(context).colorScheme.onSurfaceVariant,
                  ),
                ),
                const SizedBox(height: AppSpacing.xxSmall),
                Text(
                  value,
                  style: AppTypography.bodyText1.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  /// Build address card
  Widget _buildAddressCard(BuildContext context, Address address) {
    return Card(
      elevation: 1,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(AppSpacing.medium),
      ),
      child: Padding(
        padding: const EdgeInsets.all(AppSpacing.medium),
        child: Row(
          children: <Widget>[
            Icon(
              Icons.location_on,
              size: 24,
              color: Theme.of(context).colorScheme.primary,
            ),
            const SizedBox(width: AppSpacing.medium),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    address.label,
                    style: AppTypography.bodyText1.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: AppSpacing.xSmall),
                  Text(
                    address.formattedAddress,
                    style: AppTypography.bodyText2.copyWith(
                      color: Theme.of(context).colorScheme.onSurfaceVariant,
                    ),
                  ),
                  const SizedBox(height: AppSpacing.xSmall),
                  if (address.isDefault)
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
            ),
            IconButton(
              icon: const Icon(Icons.edit),
              onPressed: () {
                // TODO: Implement edit address
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text('Edit address feature coming soon!'),
                    behavior: SnackBarBehavior.floating,
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }

  /// Build option card
  Widget _buildOptionCard(BuildContext context, ServiceOption option) {
    return Card(
      elevation: 1,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(AppSpacing.medium),
      ),
      child: Padding(
        padding: const EdgeInsets.all(AppSpacing.medium),
        child: Row(
          children: <Widget>[
            const Icon(
              Icons.check_circle,
              size: 24,
              color: Colors.green,
            ),
            const SizedBox(width: AppSpacing.medium),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    option.name,
                    style: AppTypography.bodyText1.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  if (option.description.isNotEmpty) ...<Widget>[
                    const SizedBox(height: AppSpacing.xSmall),
                    Text(
                      option.description,
                      style: AppTypography.bodyText2.copyWith(
                        color: Theme.of(context).colorScheme.onSurfaceVariant,
                      ),
                    ),
                  ],
                ],
              ),
            ),
            if (option.price > 0)
              Text(
                '+ ₹${option.price.toStringAsFixed(2)}',
                style: AppTypography.bodyText1.copyWith(
                  fontWeight: FontWeight.bold,
                  color: Theme.of(context).colorScheme.primary,
                ),
              ),
          ],
        ),
      ),
    );
  }

  /// Build notes card
  Widget _buildNotesCard(BuildContext context, String notes) {
    return Card(
      elevation: 1,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(AppSpacing.medium),
      ),
      child: Padding(
        padding: const EdgeInsets.all(AppSpacing.medium),
        child: Row(
          children: <Widget>[
            const Icon(
              Icons.note,
              size: 24,
              color: Colors.amber,
            ),
            const SizedBox(width: AppSpacing.medium),
            Expanded(
              child: Text(
                notes,
                style: AppTypography.bodyText1,
              ),
            ),
          ],
        ),
      ),
    );
  }

  /// Build price breakdown
  Widget _buildPriceBreakdown(BuildContext context, BookingSummary booking) {
    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(AppSpacing.medium),
      ),
      child: Padding(
        padding: const EdgeInsets.all(AppSpacing.medium),
        child: Column(
          children: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Text(
                  'Base Price',
                  style: AppTypography.bodyText1,
                ),
                Text(
                  '₹${booking.service.price.toStringAsFixed(2)}',
                  style: AppTypography.bodyText1,
                ),
              ],
            ),
            if (booking.selectedOptions.isNotEmpty) ...<Widget>[
              const SizedBox(height: AppSpacing.small),
              const Divider(),
              ...booking.selectedOptions.map((option) {
                if (option.price > 0) {
                  return Padding(
                    padding:
                        const EdgeInsets.symmetric(vertical: AppSpacing.xSmall),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Text(
                          option.name,
                          style: AppTypography.bodyText1,
                        ),
                        Text(
                          '+ ₹${option.price.toStringAsFixed(2)}',
                          style: AppTypography.bodyText1,
                        ),
                      ],
                    ),
                  );
                }
                return const SizedBox.shrink();
              }).toList(),
            ],
            const SizedBox(height: AppSpacing.small),
            const Divider(),
            const SizedBox(height: AppSpacing.small),
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
                  '₹${booking.totalPrice.toStringAsFixed(2)}',
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

  /// Build status timeline
  Widget _buildStatusTimeline(BuildContext context, String status) {
    final List<TimelineStep> timelineSteps = [
      TimelineStep(
        title: 'Booking Confirmed',
        subtitle: 'Your booking has been confirmed',
        icon: Icons.check_circle,
        color: Colors.green,
        completed: true,
      ),
      TimelineStep(
        title: 'Professional Assigned',
        subtitle: 'A professional will be assigned soon',
        icon: Icons.person,
        color: status.toLowerCase() == 'confirmed' ? Colors.grey : Colors.blue,
        completed: status.toLowerCase() != 'confirmed',
      ),
      TimelineStep(
        title: 'Service in Progress',
        subtitle: 'Professional is on the way',
        icon: Icons.work,
        color:
            status.toLowerCase() == 'in_progress' ? Colors.blue : Colors.grey,
        completed: status.toLowerCase() == 'in_progress',
      ),
      TimelineStep(
        title: 'Service Completed',
        subtitle: 'Service has been completed',
        icon: Icons.check_circle_outline,
        color: status.toLowerCase() == 'completed' ? Colors.green : Colors.grey,
        completed: status.toLowerCase() == 'completed',
      ),
    ];

    return Card(
      elevation: 1,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(AppSpacing.medium),
      ),
      child: Padding(
        padding: const EdgeInsets.all(AppSpacing.medium),
        child: Column(
          children: <Widget>[
            ...timelineSteps.map((step) {
              return Padding(
                padding: const EdgeInsets.only(bottom: AppSpacing.medium),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Icon(
                      step.icon,
                      size: 24,
                      color: step.color,
                    ),
                    const SizedBox(width: AppSpacing.medium),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Text(
                            step.title,
                            style: AppTypography.bodyText1.copyWith(
                              fontWeight: FontWeight.bold,
                              color: step.completed
                                  ? Theme.of(context).colorScheme.onSurface
                                  : Theme.of(context)
                                      .colorScheme
                                      .onSurfaceVariant,
                            ),
                          ),
                          const SizedBox(height: AppSpacing.xSmall),
                          Text(
                            step.subtitle,
                            style: AppTypography.bodyText2.copyWith(
                              color: Theme.of(context)
                                  .colorScheme
                                  .onSurfaceVariant,
                            ),
                          ),
                        ],
                      ),
                    ),
                    if (step.completed)
                      const Icon(
                        Icons.check_circle,
                        size: 20,
                        color: Colors.green,
                      ),
                  ],
                ),
              );
            }).toList(),
          ],
        ),
      ),
    );
  }

  /// Build action buttons
  Widget _buildActionButtons(BuildContext context, BookingSummary booking) {
    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(AppSpacing.medium),
      ),
      child: Padding(
        padding: const EdgeInsets.all(AppSpacing.medium),
        child: Column(
          children: <Widget>[
            Text(
              'Booking Actions',
              style: AppTypography.headline6.copyWith(
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: AppSpacing.medium),
            Row(
              children: <Widget>[
                Expanded(
                  child: OutlinedButton.icon(
                    onPressed: () {
                      // TODO: Implement cancel booking
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text('Cancel booking feature coming soon!'),
                          behavior: SnackBarBehavior.floating,
                        ),
                      );
                    },
                    icon: const Icon(Icons.cancel),
                    label: const Text('Cancel Booking'),
                    style: OutlinedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(
                          vertical: AppSpacing.small),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(AppSpacing.xSmall),
                      ),
                      side: BorderSide(
                        color: Theme.of(context).colorScheme.error,
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: AppSpacing.small),
                Expanded(
                  child: ElevatedButton.icon(
                    onPressed: () {
                      // TODO: Implement reschedule booking
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text('Reschedule feature coming soon!'),
                          behavior: SnackBarBehavior.floating,
                        ),
                      );
                    },
                    icon: const Icon(Icons.edit_calendar),
                    label: const Text('Reschedule'),
                    style: ElevatedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(
                          vertical: AppSpacing.small),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(AppSpacing.xSmall),
                      ),
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: AppSpacing.small),
            ElevatedButton.icon(
              onPressed: () {
                // TODO: Implement contact support
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text('Contact support feature coming soon!'),
                    behavior: SnackBarBehavior.floating,
                  ),
                );
              },
              icon: const Icon(Icons.support),
              label: const Text('Contact Support'),
              style: ElevatedButton.styleFrom(
                minimumSize: const Size(double.infinity, 56),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(AppSpacing.xSmall),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  /// Build status chip
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
