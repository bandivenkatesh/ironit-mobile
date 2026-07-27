/// Authentication state management
/// Tracks user login status and basic profile information
class AuthState {
  final bool isLoggedIn;
  final bool isGuest;
  final String? userId;
  final String? userName;
  final String? userEmail;

  const AuthState({
    this.isLoggedIn = false,
    this.isGuest = false,
    this.userId,
    this.userName,
    this.userEmail,
  });

  /// Initial (unauthenticated) state
  static const AuthState unauthenticated = AuthState();

  /// Create authenticated state
  factory AuthState.authenticated({
    required String userId,
    required String userName,
    required String userEmail,
    bool rememberMe = false,
  }) {
    return AuthState(
      isLoggedIn: true,
      isGuest: false,
      userId: userId,
      userName: userName,
      userEmail: userEmail,
    );
  }

  /// Create guest state
  factory AuthState.guest() {
    return const AuthState(
      isLoggedIn: true,
      isGuest: true,
      userName: 'Guest',
      userEmail: 'guest@example.com',
    );
  }

  /// Check if user is authenticated (either logged in or guest)
  bool get isAuthenticated => isLoggedIn;

  /// Copy with new values
  AuthState copyWith({
    bool? isLoggedIn,
    bool? isGuest,
    String? userId,
    String? userName,
    String? userEmail,
  }) {
    return AuthState(
      isLoggedIn: isLoggedIn ?? this.isLoggedIn,
      isGuest: isGuest ?? this.isGuest,
      userId: userId ?? this.userId,
      userName: userName ?? this.userName,
      userEmail: userEmail ?? this.userEmail,
    );
  }

  /// Convert to map for storage
  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'isLoggedIn': isLoggedIn,
      'isGuest': isGuest,
      'userId': userId,
      'userName': userName,
      'userEmail': userEmail,
    };
  }

  /// Create from map
  factory AuthState.fromMap(Map<String, dynamic> map) {
    return AuthState(
      isLoggedIn: map['isLoggedIn'] ?? false,
      isGuest: map['isGuest'] ?? false,
      userId: map['userId'],
      userName: map['userName'],
      userEmail: map['userEmail'],
    );
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is AuthState &&
          runtimeType == other.runtimeType &&
          isLoggedIn == other.isLoggedIn &&
          isGuest == other.isGuest &&
          userId == other.userId &&
          userName == other.userName &&
          userEmail == other.userEmail;

  @override
  int get hashCode =>
      isLoggedIn.hashCode ^
      isGuest.hashCode ^
      userId.hashCode ^
      userName.hashCode ^
      userEmail.hashCode;
}
