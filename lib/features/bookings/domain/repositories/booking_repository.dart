/// Booking Repository interface
/// Abstract contract for booking-related data operations
import '../models/address.dart';
import '../models/booking_draft.dart';
import '../models/booking_summary.dart';
import '../models/service_option.dart';
import '../models/time_slot.dart';
import 'package:ironit/features/home/domain/models/service.dart';

abstract class BookingRepository {
  /// Get available time slots for a service on a specific date
  Future<List<TimeSlot>> getAvailableTimeSlots({
    required String serviceId,
    required DateTime date,
  });

  /// Get user addresses
  Future<List<Address>> getUserAddresses(String userId);

  /// Get default address for user
  Future<Address?> getDefaultAddress(String userId);

  /// Get service options for a service
  Future<List<ServiceOption>> getServiceOptions(String serviceId);

  /// Create a new booking draft
  Future<BookingDraft> createBookingDraft({
    required String userId,
    required Service service,
  });

  /// Update booking draft
  Future<BookingDraft> updateBookingDraft(BookingDraft draft);

  /// Get booking draft by ID
  Future<BookingDraft?> getBookingDraft(String draftId);

  /// Confirm booking and create booking summary
  Future<BookingSummary> confirmBooking(BookingDraft draft);

  /// Get booking summary by ID
  Future<BookingSummary?> getBookingSummary(String bookingId);

  /// Get user bookings
  Future<List<BookingSummary>> getUserBookings(String userId);
}
