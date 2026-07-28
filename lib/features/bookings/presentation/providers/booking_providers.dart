/// Booking Providers
/// Riverpod state management for booking flow
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:ironit/features/home/domain/models/service.dart';
import 'package:ironit/features/bookings/data/repositories/mock_booking_repository.dart';

import '../../domain/models/address.dart';
import '../../domain/models/booking_draft.dart';
import '../../domain/models/booking_summary.dart';
import '../../domain/models/service_option.dart';
import '../../domain/models/time_slot.dart';
import '../../domain/repositories/booking_repository.dart';

// Repository provider
final bookingRepositoryProvider = Provider<BookingRepository>(
  (ref) => MockBookingRepository(),
);

// Booking draft state provider
final bookingDraftProvider =
    StateNotifierProvider<BookingDraftNotifier, BookingDraft?>(
  (ref) {
    return BookingDraftNotifier(ref.read(bookingRepositoryProvider));
  },
);

// Selected service provider
final selectedServiceProvider = StateProvider<Service?>(
  (ref) => null,
);

// Selected date provider
final selectedDateProvider = StateProvider<DateTime>(
  (ref) => DateTime.now(),
);

// Selected time slot provider
final selectedTimeSlotProvider = StateProvider<TimeSlot?>(
  (ref) => null,
);

// Selected address provider
final selectedAddressProvider = StateProvider<Address?>(
  (ref) => null,
);

// Selected options provider
final selectedOptionsProvider = StateProvider<List<ServiceOption>>(
  (ref) => <ServiceOption>[],
);

// Notes provider
final notesProvider = StateProvider<String>(
  (ref) => '',
);

// Available time slots provider
final availableTimeSlotsProvider = FutureProvider.autoDispose<List<TimeSlot>>(
  (ref) async {
    final String serviceId = ref.watch(selectedServiceProvider)?.id ?? '';
    final DateTime selectedDate = ref.watch(selectedDateProvider);

    if (serviceId.isEmpty) {
      return <TimeSlot>[];
    }

    final BookingRepository repository = ref.read(bookingRepositoryProvider);
    return repository.getAvailableTimeSlots(
      serviceId: serviceId,
      date: selectedDate,
    );
  },
);

// User addresses provider
final userAddressesProvider = FutureProvider.autoDispose<List<Address>>(
  (ref) async {
    // In a real app, we would get the user ID from auth state
    const String userId = 'user-1';
    final BookingRepository repository = ref.read(bookingRepositoryProvider);
    return repository.getUserAddresses(userId);
  },
);

// Service options provider
final serviceOptionsProvider = FutureProvider.autoDispose<List<ServiceOption>>(
  (ref) async {
    final String serviceId = ref.watch(selectedServiceProvider)?.id ?? '';

    if (serviceId.isEmpty) {
      return <ServiceOption>[];
    }

    final BookingRepository repository = ref.read(bookingRepositoryProvider);
    return repository.getServiceOptions(serviceId);
  },
);

// Booking draft notifier
class BookingDraftNotifier extends StateNotifier<BookingDraft?> {
  final BookingRepository _repository;

  BookingDraftNotifier(this._repository) : super(null);

  /// Create a new booking draft
  Future<void> createDraft(String userId, Service service) async {
    state = await _repository.createBookingDraft(
      userId: userId,
      service: service,
    );
  }

  /// Update the booking draft
  Future<void> updateDraft(BookingDraft draft) async {
    state = await _repository.updateBookingDraft(draft);
  }

  /// Load booking draft by ID
  Future<void> loadDraft(String draftId) async {
    state = await _repository.getBookingDraft(draftId);
  }

  /// Clear current draft
  void clearDraft() {
    state = null;
  }
}

// Current booking ID provider (for navigation)
final currentBookingIdProvider = StateProvider<String>(
  (ref) => '',
);

// Booking summary provider
final bookingSummaryProvider = FutureProvider.autoDispose<BookingSummary>(
  (ref) async {
    final String bookingId = ref.watch(currentBookingIdProvider);
    final BookingRepository repository = ref.read(bookingRepositoryProvider);
    final BookingSummary? summary =
        await repository.getBookingSummary(bookingId);
    if (summary == null) {
      throw Exception('Booking not found');
    }
    return summary;
  },
);

// User bookings provider
final userBookingsProvider = FutureProvider.autoDispose<List<BookingSummary>>(
  (ref) async {
    // In a real app, we would get the user ID from auth state
    const String userId = 'user-1';
    final BookingRepository repository = ref.read(bookingRepositoryProvider);
    return repository.getUserBookings(userId);
  },
);

// Total price calculator
final totalPriceProvider = Provider.autoDispose<double>(
  (ref) {
    final Service? service = ref.watch(selectedServiceProvider);
    final List<ServiceOption> options = ref.watch(selectedOptionsProvider);

    if (service == null) {
      return 0.0;
    }

    double total = service.price;
    for (final ServiceOption option in options) {
      total += option.price;
    }

    return total;
  },
);

// Booking form validation
final isBookingFormValidProvider = Provider.autoDispose<bool>(
  (ref) {
    final Service? service = ref.watch(selectedServiceProvider);
    final DateTime selectedDate = ref.watch(selectedDateProvider);
    final TimeSlot? timeSlot = ref.watch(selectedTimeSlotProvider);
    final Address? address = ref.watch(selectedAddressProvider);

    return service != null &&
        timeSlot != null &&
        address != null &&
        selectedDate != null;
  },
);
