import 'dart:async';

/// Mock authentication service for testing and development.
/// Simulates real authentication without backend dependencies.
class MockAuthService {
  // Simulated network delay
  static const Duration _networkDelay = Duration(milliseconds: 800);

  // Mock user database
  final Map<String, MockUser> _userDatabase = <String, MockUser>{
    'test@example.com': MockUser(
      id: '1',
      name: 'Test User',
      email: 'test@example.com',
      phone: '1234567890',
    ),
  };

  /// Simulates user login
  ///
  /// Returns [MockAuthResult] with success/failure status
  /// Delays response to simulate network request
  Future<MockAuthResult> login({
    required String email,
    required String password,
    bool rememberMe = false,
  }) async {
    await Future<void>.delayed(_networkDelay);

    // Basic validation
    if (email.isEmpty || password.isEmpty) {
      return MockAuthResult(
        success: false,
        error: 'Email and password are required',
      );
    }

    if (!email.contains('@')) {
      return MockAuthResult(
        success: false,
        error: 'Invalid email format',
      );
    }

    if (password.length < 6) {
      return MockAuthResult(
        success: false,
        error: 'Password must be at least 6 characters',
      );
    }

    // Check if user exists (mock database)
    if (!_userDatabase.containsKey(email)) {
      return MockAuthResult(
        success: false,
        error: 'User not found',
      );
    }

    // In a real app, we'd verify password here
    // For mock, we accept any non-empty password
    return MockAuthResult(
      success: true,
      user: _userDatabase[email]!,
      rememberMe: rememberMe,
    );
  }

  /// Simulates user registration
  Future<MockAuthResult> register({
    required String name,
    required String email,
    required String phone,
    required String password,
  }) async {
    await Future<void>.delayed(_networkDelay);

    // Validation
    if (name.isEmpty || email.isEmpty || phone.isEmpty || password.isEmpty) {
      return MockAuthResult(
        success: false,
        error: 'All fields are required',
      );
    }

    if (!email.contains('@')) {
      return MockAuthResult(
        success: false,
        error: 'Invalid email format',
      );
    }

    if (password.length < 6) {
      return MockAuthResult(
        success: false,
        error: 'Password must be at least 6 characters',
      );
    }

    // Check if user already exists
    if (_userDatabase.containsKey(email)) {
      return MockAuthResult(
        success: false,
        error: 'Email already registered',
      );
    }

    // Create new user
    final MockUser newUser = MockUser(
      id: DateTime.now().millisecondsSinceEpoch.toString(),
      name: name,
      email: email,
      phone: phone,
    );

    _userDatabase[email] = newUser;

    return MockAuthResult(
      success: true,
      user: newUser,
    );
  }

  /// Simulates password reset
  Future<MockAuthResult> forgotPassword(String email) async {
    await Future<void>.delayed(_networkDelay);

    if (email.isEmpty) {
      return MockAuthResult(
        success: false,
        error: 'Email is required',
      );
    }

    if (!email.contains('@')) {
      return MockAuthResult(
        success: false,
        error: 'Invalid email format',
      );
    }

    if (!_userDatabase.containsKey(email)) {
      return MockAuthResult(
        success: false,
        error: 'Email not found',
      );
    }

    // In real app, this would send an email
    return MockAuthResult(
      success: true,
      message: 'Password reset link sent to $email',
    );
  }

  /// Simulates guest continuation
  Future<MockAuthResult> continueAsGuest() async {
    await Future<void>.delayed(_networkDelay);

    return MockAuthResult(
      success: true,
      isGuest: true,
      user: MockUser.guest(),
    );
  }

  /// Simulates logout
  Future<bool> logout() async {
    await Future<void>.delayed(_networkDelay);
    return true;
  }
}

/// Mock user data model
class MockUser {
  final String id;
  final String name;
  final String email;
  final String phone;
  final bool isGuest;

  MockUser({
    required this.id,
    required this.name,
    required this.email,
    required this.phone,
    this.isGuest = false,
  });

  factory MockUser.guest() {
    return MockUser(
      id: 'guest',
      name: 'Guest User',
      email: 'guest@example.com',
      phone: '',
      isGuest: true,
    );
  }
}

/// Authentication result model
class MockAuthResult {
  final bool success;
  final MockUser? user;
  final String? error;
  final String? message;
  final bool isGuest;
  final bool rememberMe;

  MockAuthResult({
    required this.success,
    this.user,
    this.error,
    this.message,
    this.isGuest = false,
    this.rememberMe = false,
  });
}
