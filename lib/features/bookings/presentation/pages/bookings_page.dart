/// Bookings Page
/// Page for viewing user's booking history
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';

import '../../../../core/theme/app_spacing.dart';
import '../../../../core/theme/app_typography.dart';
import '../../../../core/widgets/loading_widget.dart';
import '../../../../core/widgets/empty_state_widget.dart';
import '../providers/booking_providers.dart';
import '../widgets/booking_summary_card.dart';
import '../../domain/models/booking_summary.dart';

class BookingsPage extends ConsumerWidget {
  const BookingsPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final AsyncValue<List<BookingSummary>> bookingsAsync =
        ref.watch(userBookingsProvider);

    return Scaffold(
      appBar: _buildAppBar(),
      body: bookingsAsync.when(
        loading: () => const LoadingWidget(),
        error: (Object error, StackTrace stack) => Center(
          child: Text(
            'Failed to load bookings',
            style: AppTypography.bodyText1.copyWith(
              color: Theme.of(context).colorScheme.error,
            ),
          ),
        ),
        data: (List<BookingSummary> bookings) {
          if (bookings.isEmpty) {
            return EmptyStateWidget(
              icon: const Icon(
                Icons.history,
                size: 64,
                color: Colors.grey,
              ),
              title: 'No Bookings Yet',
              subtitle: 'Your booked services will appear here',
              action: ElevatedButton(
                onPressed: () {
                  context.go('/home');
                },
                child: const Text('Browse Services'),
              ),
            );
          }

          return _buildBookingsList(context, bookings);
        },
      ),
    );
  }

  /// Build the app bar
  AppBar _buildAppBar() {
    return AppBar(
      title: Text(
        'My Bookings',
        style: AppTypography.headline6.copyWith(
          fontWeight: FontWeight.w600,
        ),
      ),
      centerTitle: true,
    );
  }

  /// Build the bookings list
  Widget _buildBookingsList(
      BuildContext context, List<BookingSummary> bookings) {
    return RefreshIndicator(
      onRefresh: () async {
        // In a real app, we would refresh the bookings data
        await Future.delayed(const Duration(seconds: 1));
      },
      child: ListView.builder(
        padding: const EdgeInsets.all(AppSpacing.medium),
        itemCount: bookings.length,
        itemBuilder: (BuildContext context, int index) {
          final BookingSummary booking = bookings[index];
          return _buildBookingItem(context, booking);
        },
      ),
    );
  }

  /// Build individual booking item
  Widget _buildBookingItem(BuildContext context, BookingSummary booking) {
    final DateFormat dateFormat = DateFormat('MMM d, yyyy');
    final DateFormat timeFormat = DateFormat('h:mm a');

    return Card(
      margin: const EdgeInsets.only(bottom: AppSpacing.medium),
      elevation: 2,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(AppSpacing.medium),
      ),
      child: InkWell(
        onTap: () {
          // TODO: Navigate to booking detail page
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('Booking detail page coming soon!'),
              behavior: SnackBarBehavior.floating,
            ),
          );
        },
        borderRadius: BorderRadius.circular(AppSpacing.medium),
        child: Padding(
          padding: const EdgeInsets.all(AppSpacing.medium),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              // Booking header
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Text(
                    'Booking #${booking.bookingReference}',
                    style: AppTypography.bodyText1.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  _buildStatusChip(context, booking.status),
                ],
              ),
              const SizedBox(height: AppSpacing.small),

              // Service name
              Text(
                booking.service.name,
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
                    dateFormat.format(booking.bookingDate),
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
                    timeFormat.format(booking.timeSlot.startTime),
                    style: AppTypography.bodyText2,
                  ),
                ],
              ),
              const SizedBox(height: AppSpacing.small),

              // Address
              Row(
                children: <Widget>[
                  const Icon(
                    Icons.location_on,
                    size: 16,
                    color: Colors.grey,
                  ),
                  const SizedBox(width: AppSpacing.xSmall),
                  Expanded(
                    child: Text(
                      booking.address.label,
                      style: AppTypography.bodyText2,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: AppSpacing.small),

              // Price
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
              const SizedBox(height: AppSpacing.small),

              // Action buttons
              if (booking.status.toLowerCase() == 'confirmed')
                Row(
                  children: <Widget>[
                    Expanded(
                      child: OutlinedButton(
                        onPressed: () {
                          // TODO: Implement cancel booking
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content:
                                  Text('Cancel booking feature coming soon!'),
                              behavior: SnackBarBehavior.floating,
                            ),
                          );
                        },
                        style: OutlinedButton.styleFrom(
                          padding: const EdgeInsets.symmetric(
                              vertical: AppSpacing.small),
                          shape: RoundedRectangleBorder(
                            borderRadius:
                                BorderRadius.circular(AppSpacing.xSmall),
                          ),
                          side: BorderSide(
                            color: Theme.of(context).colorScheme.error,
                          ),
                        ),
                        child: Text(
                          'Cancel',
                          style: AppTypography.bodyText2.copyWith(
                            color: Theme.of(context).colorScheme.error,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(width: AppSpacing.small),
                    Expanded(
                      child: ElevatedButton(
                        onPressed: () {
                          // TODO: Implement reschedule booking
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content: Text('Reschedule feature coming soon!'),
                              behavior: SnackBarBehavior.floating,
                            ),
                          );
                        },
                        style: ElevatedButton.styleFrom(
                          padding: const EdgeInsets.symmetric(
                              vertical: AppSpacing.small),
                          shape: RoundedRectangleBorder(
                            borderRadius:
                                BorderRadius.circular(AppSpacing.xSmall),
                          ),
                        ),
                        child: Text(
                          'Reschedule',
                          style: AppTypography.bodyText2.copyWith(
                            color: Theme.of(context).colorScheme.onPrimary,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
            ],
          ),
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
