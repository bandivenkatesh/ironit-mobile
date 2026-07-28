/// Booking Entry Page
/// Main page for creating a new booking with all selection steps
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:ironit/features/home/domain/models/service.dart';

import '../../../../core/theme/app_spacing.dart';
import '../../../../core/theme/app_typography.dart';
import '../../../../core/widgets/loading_widget.dart';
import '../../../../core/widgets/error_state_widget.dart';
import '../../domain/models/address.dart';
import '../../domain/models/booking_draft.dart';
import '../../domain/models/service_option.dart';
import '../../domain/models/time_slot.dart';
import '../providers/booking_providers.dart';
import '../widgets/date_selector.dart';
import '../widgets/time_slot_selector.dart';
import '../widgets/address_selector.dart';
import '../widgets/service_options_selector.dart';
import '../widgets/notes_field.dart';

class BookingEntryPage extends ConsumerStatefulWidget {
  final Service service;

  const BookingEntryPage({
    super.key,
    required this.service,
  });

  @override
  ConsumerState<BookingEntryPage> createState() => _BookingEntryPageState();
}

class _BookingEntryPageState extends ConsumerState<BookingEntryPage> {
  final ScrollController _scrollController = ScrollController();
  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    // Initialize the booking draft when page loads
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _initializeBookingDraft();
    });
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  /// Initialize booking draft with selected service
  Future<void> _initializeBookingDraft() async {
    setState(() => _isLoading = true);

    try {
      // Set the selected service
      ref.read(selectedServiceProvider.notifier).state = widget.service;

      // Get default address for the user
      final Address? defaultAddress =
          await ref.read(bookingRepositoryProvider).getDefaultAddress('user-1');
      if (defaultAddress != null) {
        ref.read(selectedAddressProvider.notifier).state = defaultAddress;
      }

      // Create booking draft
      await ref
          .read(bookingDraftProvider.notifier)
          .createDraft('user-1', widget.service);
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Failed to initialize booking: ${e.toString()}'),
            behavior: SnackBarBehavior.floating,
          ),
        );
      }
    } finally {
      if (mounted) {
        setState(() => _isLoading = false);
      }
    }
  }

  /// Navigate to booking summary page
  Future<void> _navigateToSummary() async {
    setState(() => _isLoading = true);

    try {
      // Get current state
      final Service? service = ref.read(selectedServiceProvider);
      final DateTime selectedDate = ref.read(selectedDateProvider);
      final TimeSlot? timeSlot = ref.read(selectedTimeSlotProvider);
      final Address? address = ref.read(selectedAddressProvider);
      final List<ServiceOption> options = ref.read(selectedOptionsProvider);
      final String notes = ref.read(notesProvider);

      if (service == null || timeSlot == null || address == null) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Please complete all required fields'),
            behavior: SnackBarBehavior.floating,
          ),
        );
        return;
      }

      // Create booking draft
      final BookingDraft draft = BookingDraft(
        id: 'draft-${DateTime.now().millisecondsSinceEpoch}',
        userId: 'user-1',
        service: service,
        selectedDate: selectedDate,
        selectedTimeSlot: timeSlot,
        selectedAddress: address,
        selectedOptions: options,
        notes: notes,
        createdAt: DateTime.now(),
        updatedAt: DateTime.now(),
      );

      // Update draft
      await ref.read(bookingDraftProvider.notifier).updateDraft(draft);

      // Navigate to summary
      context.push('/booking-summary');
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Failed to prepare booking: ${e.toString()}'),
          behavior: SnackBarBehavior.floating,
        ),
      );
    } finally {
      setState(() => _isLoading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    final bool isFormValid = ref.watch(isBookingFormValidProvider);

    return Scaffold(
      appBar: _buildAppBar(),
      body: _isLoading ? const LoadingWidget() : _buildBookingForm(context),
      bottomNavigationBar: _buildBottomNavigation(context, isFormValid),
    );
  }

  /// Build the app bar
  AppBar _buildAppBar() {
    return AppBar(
      title: Text(
        'Book ${widget.service.name}',
        style: AppTypography.headline6.copyWith(
          fontWeight: FontWeight.w600,
        ),
      ),
      centerTitle: true,
    );
  }

  /// Build the main booking form
  Widget _buildBookingForm(BuildContext context) {
    return SingleChildScrollView(
      controller: _scrollController,
      padding: const EdgeInsets.all(AppSpacing.medium),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          // Service information
          _buildServiceInfo(),
          const SizedBox(height: AppSpacing.large),

          // Date selector
          const DateSelector(),
          const SizedBox(height: AppSpacing.large),

          // Time slot selector
          const TimeSlotSelector(),
          const SizedBox(height: AppSpacing.large),

          // Address selector
          const AddressSelector(),
          const SizedBox(height: AppSpacing.large),

          // Service options
          const ServiceOptionsSelector(),
          const SizedBox(height: AppSpacing.large),

          // Notes field
          const NotesField(),
          const SizedBox(height: AppSpacing.xLarge),
        ],
      ),
    );
  }

  /// Build service information section
  Widget _buildServiceInfo() {
    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(AppSpacing.medium),
      ),
      child: Padding(
        padding: const EdgeInsets.all(AppSpacing.medium),
        child: Row(
          children: <Widget>[
            // Service image placeholder
            Container(
              width: 80,
              height: 80,
              decoration: BoxDecoration(
                color: Theme.of(context).colorScheme.surfaceContainerHighest,
                borderRadius: BorderRadius.circular(AppSpacing.small),
              ),
              child: widget.service.imageUrl.isNotEmpty
                  ? Image.network(
                      widget.service.imageUrl,
                      fit: BoxFit.cover,
                      errorBuilder: (BuildContext context, Object error,
                          StackTrace? stack) {
                        return const Icon(
                          Icons.iron_outlined,
                          size: 40,
                          color: Colors.grey,
                        );
                      },
                    )
                  : const Icon(
                      Icons.iron_outlined,
                      size: 40,
                      color: Colors.grey,
                    ),
            ),
            const SizedBox(width: AppSpacing.medium),
            // Service details
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    widget.service.name,
                    style: AppTypography.headline6.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: AppSpacing.xSmall),
                  Row(
                    children: <Widget>[
                      const Icon(
                        Icons.timer_outlined,
                        size: 16,
                        color: Colors.grey,
                      ),
                      const SizedBox(width: AppSpacing.xSmall),
                      Text(
                        '${widget.service.estimatedDuration.inMinutes} min',
                        style: AppTypography.bodyText2,
                      ),
                      const SizedBox(width: AppSpacing.small),
                      const Icon(
                        Icons.star,
                        size: 16,
                        color: Colors.amber,
                      ),
                      const SizedBox(width: AppSpacing.xSmall),
                      Text(
                        '${widget.service.rating} (${widget.service.reviewCount} reviews)',
                        style: AppTypography.bodyText2,
                      ),
                    ],
                  ),
                ],
              ),
            ),
            // Price
            Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: <Widget>[
                Text(
                  '₹${widget.service.price.toStringAsFixed(0)}',
                  style: AppTypography.headline6.copyWith(
                    fontWeight: FontWeight.bold,
                    color: Theme.of(context).colorScheme.primary,
                  ),
                ),
                Text(
                  'Base Price',
                  style: AppTypography.bodyText2.copyWith(
                    color: Theme.of(context).colorScheme.onSurfaceVariant,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  /// Build bottom navigation with continue button
  Widget _buildBottomNavigation(BuildContext context, bool isFormValid) {
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.all(AppSpacing.medium),
        child: ElevatedButton(
          onPressed: isFormValid ? _navigateToSummary : null,
          style: ElevatedButton.styleFrom(
            minimumSize: const Size(double.infinity, 56),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(AppSpacing.small),
            ),
            backgroundColor: isFormValid
                ? Theme.of(context).colorScheme.primary
                : Theme.of(context).colorScheme.onSurface.withOpacity(0.12),
          ),
          child: _isLoading
              ? const CircularProgressIndicator(
                  color: Colors.white,
                  strokeWidth: 2,
                )
              : Text(
                  'Continue to Summary',
                  style: AppTypography.bodyText1.copyWith(
                    color: isFormValid
                        ? Theme.of(context).colorScheme.onPrimary
                        : Theme.of(context)
                            .colorScheme
                            .onSurface
                            .withOpacity(0.38),
                    fontWeight: FontWeight.bold,
                  ),
                ),
        ),
      ),
    );
  }
}
