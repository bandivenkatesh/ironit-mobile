/// Booking Success Page
/// Page shown after successful booking confirmation
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';

import '../../../../core/theme/app_spacing.dart';
import '../../../../core/theme/app_typography.dart';
import '../../../../core/widgets/loading_widget.dart';
import '../../domain/models/booking_summary.dart';
import '../providers/booking_providers.dart';
import '../widgets/booking_summary_card.dart';

class BookingSuccessPage extends ConsumerWidget {
  const BookingSuccessPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final AsyncValue<BookingSummary> summaryAsync =
        ref.watch(bookingSummaryProvider);

    return Scaffold(
      body: summaryAsync.when(
        loading: () => const LoadingWidget(),
        error: (Object error, StackTrace stack) => Center(
          child: Text(
            'Failed to load booking details',
            style: AppTypography.bodyText1.copyWith(
              color: Theme.of(context).colorScheme.error,
            ),
          ),
        ),
        data: (BookingSummary summary) {
          return _buildSuccessContent(context, summary);
        },
      ),
    );
  }

  /// Build success content
  Widget _buildSuccessContent(BuildContext context, BookingSummary summary) {
    final DateFormat dateFormat = DateFormat('EEEE, MMMM d, yyyy');
    final DateFormat timeFormat = DateFormat('h:mm a');

    return SingleChildScrollView(
      child: Column(
        children: <Widget>[
          // Top illustration and success message
          Container(
            height: 300,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: <Color>[
                  Theme.of(context).colorScheme.primary,
                  Theme.of(context).colorScheme.primaryContainer,
                ],
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
              ),
            ),
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  const Icon(
                    Icons.check_circle_outline,
                    size: 80,
                    color: Colors.white,
                  ),
                  const SizedBox(height: AppSpacing.medium),
                  Text(
                    'Booking Confirmed!',
                    style: AppTypography.headline4.copyWith(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: AppSpacing.small),
                  Text(
                    'Your ironing service has been successfully booked',
                    style: AppTypography.bodyText1.copyWith(
                      color: Colors.white.withOpacity(0.9),
                    ),
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
            ),
          ),

          // Booking summary card
          Padding(
            padding: const EdgeInsets.all(AppSpacing.medium),
            child: BookingSummaryCard(bookingSummary: summary),
          ),

          // Booking details
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: AppSpacing.medium),
            child: Card(
              elevation: 2,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(AppSpacing.medium),
              ),
              child: Padding(
                padding: const EdgeInsets.all(AppSpacing.medium),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      'Booking Details',
                      style: AppTypography.headline6.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: AppSpacing.medium),
                    const Divider(),
                    const SizedBox(height: AppSpacing.medium),
                    _buildDetailRow(
                      context,
                      'Booking Reference',
                      summary.bookingReference,
                    ),
                    const SizedBox(height: AppSpacing.small),
                    _buildDetailRow(
                      context,
                      'Service',
                      summary.service.name,
                    ),
                    const SizedBox(height: AppSpacing.small),
                    _buildDetailRow(
                      context,
                      'Date',
                      dateFormat.format(summary.bookingDate),
                    ),
                    const SizedBox(height: AppSpacing.small),
                    _buildDetailRow(
                      context,
                      'Time',
                      timeFormat.format(summary.timeSlot.startTime),
                    ),
                    const SizedBox(height: AppSpacing.small),
                    _buildDetailRow(
                      context,
                      'Address',
                      summary.address.label,
                    ),
                    const SizedBox(height: AppSpacing.small),
                    const Divider(),
                    const SizedBox(height: AppSpacing.small),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Text(
                          'Total Paid',
                          style: AppTypography.bodyText1.copyWith(
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text(
                          '₹${summary.totalPrice.toStringAsFixed(2)}',
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
            ),
          ),

          // Next steps
          Padding(
            padding: const EdgeInsets.all(AppSpacing.medium),
            child: Card(
              elevation: 2,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(AppSpacing.medium),
              ),
              child: Padding(
                padding: const EdgeInsets.all(AppSpacing.medium),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      'What happens next?',
                      style: AppTypography.headline6.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: AppSpacing.medium),
                    _buildNextStepItem(
                      context,
                      Icons.notifications,
                      'Confirmation Notification',
                      'You will receive a confirmation notification with booking details',
                    ),
                    const SizedBox(height: AppSpacing.small),
                    _buildNextStepItem(
                      context,
                      Icons.person,
                      'Professional Assignment',
                      'A professional will be assigned to your booking',
                    ),
                    const SizedBox(height: AppSpacing.small),
                    _buildNextStepItem(
                      context,
                      Icons.calendar_today,
                      'Service Day',
                      'Our professional will arrive at your selected date and time',
                    ),
                    const SizedBox(height: AppSpacing.small),
                    _buildNextStepItem(
                      context,
                      Icons.star,
                      'Quality Check',
                      'We ensure premium quality service every time',
                    ),
                  ],
                ),
              ),
            ),
          ),

          // Actions
          Padding(
            padding: const EdgeInsets.all(AppSpacing.medium),
            child: Column(
              children: <Widget>[
                ElevatedButton(
                  onPressed: () {
                    context.go('/home');
                  },
                  style: ElevatedButton.styleFrom(
                    minimumSize: const Size(double.infinity, 56),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(AppSpacing.small),
                    ),
                  ),
                  child: Text(
                    'Back to Home',
                    style: AppTypography.bodyText1.copyWith(
                      color: Theme.of(context).colorScheme.onPrimary,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                const SizedBox(height: AppSpacing.small),
                OutlinedButton(
                  onPressed: () {
                    // We need to get the booking ID from the summary that's already loaded
                    // Since we're in a ConsumerWidget, we can access it through the build method
                    // For now, let's use a placeholder approach
                    context.go('/bookings');
                  },
                  style: OutlinedButton.styleFrom(
                    minimumSize: const Size(double.infinity, 56),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(AppSpacing.small),
                    ),
                    side: BorderSide(
                      color: Theme.of(context).colorScheme.primary,
                    ),
                  ),
                  child: Text(
                    'View Booking Details',
                    style: AppTypography.bodyText1.copyWith(
                      color: Theme.of(context).colorScheme.primary,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: AppSpacing.large),
        ],
      ),
    );
  }

  /// Build a detail row
  Widget _buildDetailRow(BuildContext context, String label, String value) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        SizedBox(
          width: 140,
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

  /// Build a next step item
  Widget _buildNextStepItem(
    BuildContext context,
    IconData icon,
    String title,
    String subtitle,
  ) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Icon(
          icon,
          size: 24,
          color: Theme.of(context).colorScheme.primary,
        ),
        const SizedBox(width: AppSpacing.small),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(
                title,
                style: AppTypography.bodyText1.copyWith(
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: AppSpacing.xxSmall),
              Text(
                subtitle,
                style: AppTypography.bodyText2.copyWith(
                  color: Theme.of(context).colorScheme.onSurfaceVariant,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
