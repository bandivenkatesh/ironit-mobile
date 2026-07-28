/// Mock Booking Repository implementation
/// Provides mock data for booking operations during development
import '../../domain/models/address.dart';
import '../../domain/models/booking_draft.dart';
import '../../domain/models/booking_summary.dart';
import '../../domain/models/service_option.dart';
import '../../domain/models/time_slot.dart';
import '../../domain/repositories/booking_repository.dart';
import 'package:ironit/features/home/domain/models/service.dart';
import '../mock/addresses.dart';

class MockBookingRepository implements BookingRepository {
  /// In-memory storage for booking drafts
  final Map<String, BookingDraft> _bookingDrafts = <String, BookingDraft>{};

  /// In-memory storage for booking summaries
  final Map<String, BookingSummary> _bookingSummaries =
      <String, BookingSummary>{};

  @override
  Future<List<TimeSlot>> getAvailableTimeSlots({
    required String serviceId,
    required DateTime date,
  }) async {
    // Return mock time slots for the requested date
    final DateTime normalizedDate = DateTime(date.year, date.month, date.day);
    final List<TimeSlot> timeSlots = <TimeSlot>[
      TimeSlot(
        id: 'slot-${normalizedDate.millisecondsSinceEpoch}-1',
        startTime: DateTime(normalizedDate.year, normalizedDate.month,
            normalizedDate.day, 9, 0),
        endTime: DateTime(normalizedDate.year, normalizedDate.month,
            normalizedDate.day, 10, 0),
        isAvailable: true,
        serviceId: serviceId,
      ),
      TimeSlot(
        id: 'slot-${normalizedDate.millisecondsSinceEpoch}-2',
        startTime: DateTime(normalizedDate.year, normalizedDate.month,
            normalizedDate.day, 10, 0),
        endTime: DateTime(normalizedDate.year, normalizedDate.month,
            normalizedDate.day, 11, 0),
        isAvailable: true,
        serviceId: serviceId,
      ),
      TimeSlot(
        id: 'slot-${normalizedDate.millisecondsSinceEpoch}-3',
        startTime: DateTime(normalizedDate.year, normalizedDate.month,
            normalizedDate.day, 14, 0),
        endTime: DateTime(normalizedDate.year, normalizedDate.month,
            normalizedDate.day, 15, 0),
        isAvailable: true,
        serviceId: serviceId,
      ),
      TimeSlot(
        id: 'slot-${normalizedDate.millisecondsSinceEpoch}-4',
        startTime: DateTime(normalizedDate.year, normalizedDate.month,
            normalizedDate.day, 16, 0),
        endTime: DateTime(normalizedDate.year, normalizedDate.month,
            normalizedDate.day, 17, 0),
        isAvailable: true,
        serviceId: serviceId,
      ),
    ];

    return Future.delayed(
      const Duration(milliseconds: 300),
      () => timeSlots,
    );
  }

  @override
  Future<List<Address>> getUserAddresses(String userId) async {
    // Return mock addresses for the user
    return Future.delayed(
      const Duration(milliseconds: 200),
      () => MockAddresses.getSampleAddresses(),
    );
  }

  @override
  Future<Address?> getDefaultAddress(String userId) async {
    // Return default address for the user
    return Future.delayed(
      const Duration(milliseconds: 200),
      () => MockAddresses.getDefaultAddress(userId),
    );
  }

  @override
  Future<List<ServiceOption>> getServiceOptions(String serviceId) async {
    // Return mock service options
    final List<ServiceOption> options = <ServiceOption>[
      ServiceOption(
        id: 'option-${serviceId}-1',
        serviceId: serviceId,
        name: 'Number of Clothes',
        description: 'Select the number of clothes to be ironed',
        price: 0.0,
        type: 'quantity',
      ),
      ServiceOption(
        id: 'option-${serviceId}-2',
        serviceId: serviceId,
        name: 'Express Service',
        description: 'Priority processing with faster delivery',
        price: 199.0,
        type: 'addon',
      ),
      ServiceOption(
        id: 'option-${serviceId}-3',
        serviceId: serviceId,
        name: 'Folding Option',
        description: 'Professional folding and packaging',
        price: 99.0,
        type: 'addon',
      ),
      ServiceOption(
        id: 'option-${serviceId}-4',
        serviceId: serviceId,
        name: 'Stain Treatment',
        description: 'Pre-treatment for tough stains',
        price: 149.0,
        type: 'addon',
      ),
      ServiceOption(
        id: 'option-${serviceId}-5',
        serviceId: serviceId,
        name: 'Pickup & Drop',
        description: 'Free pickup and drop service',
        price: 0.0,
        type: 'service',
      ),
    ];

    return Future.delayed(
      const Duration(milliseconds: 300),
      () => options,
    );
  }

  @override
  Future<BookingDraft> createBookingDraft({
    required String userId,
    required Service service,
  }) async {
    // Create a new booking draft
    final DateTime now = DateTime.now();
    final BookingDraft draft = BookingDraft(
      id: 'draft-${now.millisecondsSinceEpoch}',
      userId: userId,
      service: service,
      selectedDate: DateTime.now(),
      createdAt: now,
      updatedAt: now,
    );

    _bookingDrafts[draft.id] = draft;

    return Future.delayed(
      const Duration(milliseconds: 200),
      () => draft,
    );
  }

  @override
  Future<BookingDraft> updateBookingDraft(BookingDraft draft) async {
    // Update existing booking draft
    _bookingDrafts[draft.id] = draft.copyWith(
      updatedAt: DateTime.now(),
    );

    return Future.delayed(
      const Duration(milliseconds: 200),
      () => _bookingDrafts[draft.id]!,
    );
  }

  @override
  Future<BookingDraft?> getBookingDraft(String draftId) async {
    // Get booking draft by ID
    return Future.delayed(
      const Duration(milliseconds: 200),
      () => _bookingDrafts[draftId],
    );
  }

  @override
  Future<BookingSummary> confirmBooking(BookingDraft draft) async {
    // Create booking summary from draft
    final DateTime now = DateTime.now();
    final String bookingRef =
        'IRN-${now.millisecondsSinceEpoch.toString().substring(8)}';

    final BookingSummary summary = BookingSummary(
      id: 'booking-${now.millisecondsSinceEpoch}',
      userId: draft.userId,
      service: draft.service,
      bookingDate: draft.selectedDate,
      timeSlot: draft.selectedTimeSlot!,
      address: draft.selectedAddress!,
      selectedOptions: draft.selectedOptions,
      notes: draft.notes,
      totalPrice: draft.totalPrice,
      bookingReference: bookingRef,
      createdAt: now,
      status: 'confirmed',
    );

    // Store the booking summary
    _bookingSummaries[summary.id] = summary;

    // Remove the draft
    _bookingDrafts.remove(draft.id);

    return Future.delayed(
      const Duration(milliseconds: 500),
      () => summary,
    );
  }

  @override
  Future<BookingSummary?> getBookingSummary(String bookingId) async {
    // Get booking summary by ID
    return Future.delayed(
      const Duration(milliseconds: 200),
      () => _bookingSummaries[bookingId],
    );
  }

  @override
  Future<List<BookingSummary>> getUserBookings(String userId) async {
    // Get all bookings for a user
    final List<BookingSummary> userBookings = _bookingSummaries.values
        .where((BookingSummary booking) => booking.userId == userId)
        .toList();

    // Add some sample bookings if empty
    if (userBookings.isEmpty) {
      final Service sampleService = Service.sample();
      final DateTime now = DateTime.now();

      userBookings.add(
        BookingSummary(
          id: 'booking-sample-1',
          userId: userId,
          service: sampleService,
          bookingDate: DateTime(now.year, now.month, now.day + 1),
          timeSlot: TimeSlot.samples().first,
          address: MockAddresses.getSampleAddresses().first,
          selectedOptions: <ServiceOption>[
            ServiceOption(
              id: 'option-2',
              serviceId: sampleService.id,
              name: 'Express Service',
              description: 'Priority processing with faster delivery',
              price: 199.0,
              isSelected: true,
              type: 'addon',
            ),
          ],
          notes: 'Handle with care',
          totalPrice: 498.0,
          bookingReference:
              'IRN-${(now.millisecondsSinceEpoch + 1000).toString().substring(8)}',
          createdAt: now.subtract(const Duration(hours: 2)),
          status: 'confirmed',
        ),
      );
    }

    // Sort by createdAt (newest first)
    userBookings.sort((BookingSummary a, BookingSummary b) =>
        b.createdAt.compareTo(a.createdAt));

    return Future.delayed(
      const Duration(milliseconds: 300),
      () => userBookings,
    );
  }
}
