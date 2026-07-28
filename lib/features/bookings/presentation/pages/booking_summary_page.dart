/// Booking Summary Page
/// Page for reviewing booking details before confirmation
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';

import '../../../../core/theme/app_spacing.dart';
import '../../../../core/theme/app_typography.dart';
import '../../../../core/widgets/loading_widget.dart';
import '../providers/booking_providers.dart';
import '../widgets/booking_summary_card.dart';
import '../../domain/models/booking_draft.dart';
import '../../domain/models/booking_summary.dart';

class BookingSummaryPage extends ConsumerStatefulWidget {
  const BookingSummaryPage({super.key});

  @override
  ConsumerState<BookingSummaryPage> createState() => _BookingSummaryPageState();
}

class _BookingSummaryPageState extends ConsumerState<BookingSummaryPage> {
  bool _isLoading = false;
  bool _isConfirming = false;

  @override
  Widget build(BuildContext context) {
    final BookingDraft? draft = ref.watch(bookingDraftProvider);
    final double totalPrice = ref.watch(totalPriceProvider);

    return Scaffold(
      appBar: _buildAppBar(),
      body: _isLoading
          ? const LoadingWidget()
          : draft == null
              ? Center(
                  child: Text(
                    'Booking details not available',
                    style: AppTypography.bodyText1.copyWith(
                      color: Theme.of(context).colorScheme.onSurfaceVariant,
                    ),
                  ),
                )
              : !draft.isComplete
                  ? Center(
                      child: Text(
                        'Please complete all booking details',
                        style: AppTypography.bodyText1.copyWith(
                          color: Theme.of(context).colorScheme.onSurfaceVariant,
                        ),
                      ),
                    )
                  : _buildSummaryContent(context, draft, totalPrice),
      bottomNavigationBar: _buildBottomNavigation(context),
    );
  }

  /// Build the app bar
  AppBar _buildAppBar() {
    return AppBar(
      title: Text(
        'Booking Summary',
        style: AppTypography.headline6.copyWith(
          fontWeight: FontWeight.w600,
        ),
      ),
      centerTitle: true,
    );
  }

  /// Build the summary content
  Widget _buildSummaryContent(
    BuildContext context,
    BookingDraft draft,
    double totalPrice,
  ) {
    final DateFormat dateFormat = DateFormat('EEEE, MMMM d, yyyy');
    final DateFormat timeFormat = DateFormat('h:mm a');

    return SingleChildScrollView(
      padding: const EdgeInsets.all(AppSpacing.medium),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          // Booking preview card
          BookingSummaryCard(
            bookingSummary: BookingSummary(
              id: 'preview-${draft.id}',
              userId: draft.userId,
              service: draft.service,
              bookingDate: draft.selectedDate,
              timeSlot: draft.selectedTimeSlot!,
              address: draft.selectedAddress!,
              selectedOptions: draft.selectedOptions,
              notes: draft.notes,
              totalPrice: draft.totalPrice,
              bookingReference: 'IRN-PREVIEW',
              createdAt: DateTime.now(),
              status: 'preview',
            ),
          ),
          const SizedBox(height: AppSpacing.large),

          // Additional booking details
          Card(
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
                  _buildDetailRow(
                    context,
                    'Service',
                    draft.service.name,
                  ),
                  const SizedBox(height: AppSpacing.small),
                  _buildDetailRow(
                    context,
                    'Date',
                    dateFormat.format(draft.selectedDate),
                  ),
                  const SizedBox(height: AppSpacing.small),
                  _buildDetailRow(
                    context,
                    'Time',
                    timeFormat.format(draft.selectedTimeSlot!.startTime),
                  ),
                  const SizedBox(height: AppSpacing.small),
                  _buildDetailRow(
                    context,
                    'Duration',
                    '${draft.service.estimatedDuration.inMinutes} minutes',
                  ),
                  const SizedBox(height: AppSpacing.small),
                  _buildDetailRow(
                    context,
                    'Address',
                    draft.selectedAddress!.label,
                  ),
                  const SizedBox(height: AppSpacing.small),
                  if (draft.selectedOptions.isNotEmpty)
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text(
                          'Selected Options',
                          style: AppTypography.bodyText1.copyWith(
                            fontWeight: FontWeight.bold,
                            color:
                                Theme.of(context).colorScheme.onSurfaceVariant,
                          ),
                        ),
                        const SizedBox(height: AppSpacing.xSmall),
                        ...draft.selectedOptions.map((option) {
                          return Padding(
                            padding: const EdgeInsets.only(
                                bottom: AppSpacing.xSmall),
                            child: Row(
                              children: <Widget>[
                                const Icon(
                                  Icons.check_circle,
                                  size: 16,
                                  color: Colors.green,
                                ),
                                const SizedBox(width: AppSpacing.xSmall),
                                Text(
                                  option.name,
                                  style: AppTypography.bodyText2,
                                ),
                              ],
                            ),
                          );
                        }).toList(),
                      ],
                    ),
                  if (draft.selectedOptions.isNotEmpty)
                    const SizedBox(height: AppSpacing.small),
                  if (draft.notes.isNotEmpty)
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text(
                          'Special Instructions',
                          style: AppTypography.bodyText1.copyWith(
                            fontWeight: FontWeight.bold,
                            color:
                                Theme.of(context).colorScheme.onSurfaceVariant,
                          ),
                        ),
                        const SizedBox(height: AppSpacing.xSmall),
                        Text(
                          draft.notes,
                          style: AppTypography.bodyText2,
                        ),
                      ],
                    ),
                ],
              ),
            ),
          ),
          const SizedBox(height: AppSpacing.large),

          // Price breakdown
          Card(
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
                    'Price Breakdown',
                    style: AppTypography.headline6.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: AppSpacing.small),
                  const Divider(),
                  const SizedBox(height: AppSpacing.small),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Text(
                        'Base Price',
                        style: AppTypography.bodyText1,
                      ),
                      Text(
                        '₹${draft.service.price.toStringAsFixed(2)}',
                        style: AppTypography.bodyText1,
                      ),
                    ],
                  ),
                  if (draft.selectedOptions.isNotEmpty) ...<Widget>[
                    const SizedBox(height: AppSpacing.xSmall),
                    ...draft.selectedOptions.map((option) {
                      if (option.price > 0) {
                        return Padding(
                          padding:
                              const EdgeInsets.only(top: AppSpacing.xSmall),
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
                        '₹${totalPrice.toStringAsFixed(2)}',
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
          const SizedBox(height: AppSpacing.xLarge),
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

  /// Build bottom navigation with confirm and edit buttons
  Widget _buildBottomNavigation(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.all(AppSpacing.medium),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            // Edit booking button
            OutlinedButton(
              onPressed: () {
                context.pop();
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
                'Edit Booking',
                style: AppTypography.bodyText1.copyWith(
                  color: Theme.of(context).colorScheme.primary,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            const SizedBox(height: AppSpacing.small),
            // Confirm booking button
            ElevatedButton(
              onPressed: _isConfirming ? null : _confirmBooking,
              style: ElevatedButton.styleFrom(
                minimumSize: const Size(double.infinity, 56),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(AppSpacing.small),
                ),
              ),
              child: _isConfirming
                  ? const CircularProgressIndicator(
                      color: Colors.white,
                      strokeWidth: 2,
                    )
                  : Text(
                      'Confirm Booking',
                      style: AppTypography.bodyText1.copyWith(
                        color: Theme.of(context).colorScheme.onPrimary,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
            ),
          ],
        ),
      ),
    );
  }

  /// Confirm the booking and navigate to success page
  Future<void> _confirmBooking() async {
    setState(() => _isConfirming = true);

    try {
      final BookingDraft? draft = ref.read(bookingDraftProvider);

      if (draft == null || !draft.isComplete) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Booking details are incomplete'),
            behavior: SnackBarBehavior.floating,
          ),
        );
        return;
      }

      // Confirm booking through repository
      final BookingSummary summary =
          await ref.read(bookingRepositoryProvider).confirmBooking(draft);

      // Set the current booking ID for the success page
      ref.read(currentBookingIdProvider.notifier).state = summary.id;

      // Navigate to success page
      context.go('/booking-success');
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Failed to confirm booking: ${e.toString()}'),
          behavior: SnackBarBehavior.floating,
        ),
      );
    } finally {
      setState(() => _isConfirming = false);
    }
  }
}
