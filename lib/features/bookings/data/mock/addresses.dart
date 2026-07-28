/// Mock addresses data for testing and development
import '../../domain/models/address.dart';

class MockAddresses {
  /// Get sample addresses for testing
  static List<Address> getSampleAddresses() {
    return <Address>[
      Address(
        id: 'addr-1',
        userId: 'user-1',
        addressLine1: '123 Main Street',
        addressLine2: 'Apt 4B',
        city: 'Bangalore',
        state: 'Karnataka',
        postalCode: '560001',
        country: 'India',
        label: 'Home',
        isDefault: true,
        createdAt: DateTime.now(),
      ),
      Address(
        id: 'addr-2',
        userId: 'user-1',
        addressLine1: '456 Tech Park Road',
        addressLine2: 'Building C, Floor 5',
        city: 'Bangalore',
        state: 'Karnataka',
        postalCode: '560037',
        country: 'India',
        label: 'Office',
        isDefault: false,
        createdAt: DateTime.now(),
      ),
      Address(
        id: 'addr-3',
        userId: 'user-1',
        addressLine1: '789 Residency Apartments',
        addressLine2: 'Tower B, Flat 1203',
        city: 'Bangalore',
        state: 'Karnataka',
        postalCode: '560076',
        country: 'India',
        label: 'Other',
        isDefault: false,
        createdAt: DateTime.now(),
      ),
    ];
  }

  /// Get a specific address by ID
  static Address? getAddressById(String addressId) {
    try {
      return getSampleAddresses().firstWhere(
        (Address address) => address.id == addressId,
      );
    } catch (e) {
      return null;
    }
  }

  /// Get default address for user
  static Address? getDefaultAddress(String userId) {
    try {
      return getSampleAddresses().firstWhere(
        (Address address) => address.userId == userId && address.isDefault,
      );
    } catch (e) {
      return getSampleAddresses().isNotEmpty
          ? getSampleAddresses().first
          : null;
    }
  }
}
