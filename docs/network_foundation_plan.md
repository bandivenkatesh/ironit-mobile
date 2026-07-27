# Ironit Mobile Network Foundation Implementation Plan

## Executive Summary

This document outlines a production-ready network architecture for the Ironit Mobile application that integrates seamlessly with the existing Clean Architecture foundation. The proposed solution leverages Dio with comprehensive error handling, interceptors, and dependency injection through Riverpod.

## Current State

### Existing Network Components

1. **DioClient** (`lib/core/network/dio_client.dart`)
   - Stub implementation with constructor injection
   - No actual functionality implemented
   - Basic class structure in place

2. **Environment Configuration** (`.env.example`)
   - Basic API configuration placeholders
   - `API_BASE_URL` and `API_TIMEOUT` defined
   - Environment variables structure established

3. **Logger Service** (`lib/core/services/logger_service.dart`)
   - Stub implementation using `logger` package
   - Ready for network logging integration

4. **Dependency Injection** (`lib/app/providers.dart`)
   - Riverpod provider structure in place
   - Empty providers list ready for network services

5. **Constants** (`lib/core/constants/app_constants.dart`)
   - Basic app constants defined
   - No network-specific constants

### Current Dependencies
- **Dio**: v5.4.0 (latest stable)
- **Logger**: v2.0.2
- **Flutter Dotenv**: v5.1.0
- **Riverpod**: v2.4.9

### Missing Components
- No request/response interceptors
- No error handling strategy
- No exception hierarchy
- No retry/timeout strategy
- No JSON serialization approach
- No testing infrastructure
- No authentication integration
- No environment management

## Problems

### Critical Gaps

1. **Incomplete DioClient Implementation**
   - No actual HTTP client functionality
   - No request configuration
   - No response handling

2. **Missing Error Handling**
   - No exception hierarchy
   - No failure models
   - No global error handling

3. **No Interceptors**
   - No request logging
   - No response logging
   - No error interceptors
   - No authentication interceptors

4. **No Environment Management**
   - No environment switching
   - No configuration management
   - No base URL management

5. **No Testing Strategy**
   - No mock client
   - No test utilities
   - No integration testing approach

6. **No JSON Serialization**
   - No model serialization
   - No DTO patterns
   - No type conversion

7. **No Dependency Injection**
   - No Riverpod providers for network
   - No service locator pattern
   - No scoped clients

## Proposed Architecture

### 1. DioClient Architecture

**Base Client Configuration**
```dart
class DioClient {
  final Dio dio;
  final LoggerService logger;
  final AppConstants constants;

  DioClient({
    required this.dio,
    required this.logger,
    required this.constants,
  }) {
    _setup();
  }

  void _setup() {
    dio.options = BaseOptions(
      baseUrl: constants.apiBaseUrl,
      connectTimeout: constants.connectTimeout,
      receiveTimeout: constants.receiveTimeout,
      sendTimeout: constants.sendTimeout,
      headers: {'Content-Type': 'application/json'},
      validateStatus: (status) => status! < 500,
    );

    _addInterceptors();
  }
}
```

### 2. Base API Configuration

**Environment-Aware Configuration**
```dart
class ApiConfig {
  final String baseUrl;
  final Duration connectTimeout;
  final Duration receiveTimeout;
  final Duration sendTimeout;
  final String environment;

  ApiConfig({
    required this.baseUrl,
    required this.connectTimeout,
    required this.receiveTimeout,
    required this.sendTimeout,
    required this.environment,
  });

  factory ApiConfig.fromEnv() {
    return ApiConfig(
      baseUrl: dotenv.env['API_BASE_URL']!,
      connectTimeout: Duration(milliseconds: int.parse(dotenv.env['API_TIMEOUT']!)),
      receiveTimeout: Duration(milliseconds: int.parse(dotenv.env['API_TIMEOUT']!)),
      sendTimeout: Duration(milliseconds: int.parse(dotenv.env['API_TIMEOUT']!)),
      environment: dotenv.env['APP_ENV']!,
    );
  }
}
```

### 3. Environment Configuration

**Multi-Environment Support**
```dart
enum AppEnvironment { development, staging, production }

class EnvironmentConfig {
  static const _envFiles = {
    AppEnvironment.development: '.env.development',
    AppEnvironment.staging: '.env.staging',
    AppEnvironment.production: '.env',
  };

  static Future<void> load(AppEnvironment environment) async {
    await dotenv.load(fileName: _envFiles[environment]);
  }
}
```

### 4. Request Interceptors

**Comprehensive Request Processing**
```dart
class RequestInterceptor extends Interceptor {
  final LoggerService logger;
  final AuthService authService;

  RequestInterceptor({
    required this.logger,
    required this.authService,
  });

  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    // Add authentication token
    final token = authService.currentToken;
    if (token != null) {
      options.headers['Authorization'] = 'Bearer $token';
    }

    // Add request ID for tracing
    options.headers['X-Request-ID'] = Uuid().v4();

    // Log request
    logger.info('Request: ${options.method} ${options.path}');

    super.onRequest(options, handler);
  }
}
```

### 5. Response Interceptors

**Response Processing Pipeline**
```dart
class ResponseInterceptor extends Interceptor {
  final LoggerService logger;

  ResponseInterceptor({required this.logger});

  @override
  void onResponse(Response response, ResponseInterceptorHandler handler) {
    // Log successful response
    logger.info('Response: ${response.statusCode} ${response.requestOptions.path}');

    // Handle pagination if needed
    // Transform response data if needed

    super.onResponse(response, handler);
  }
}
```

### 6. Error Interceptors

**Global Error Handling**
```dart
class ErrorInterceptor extends Interceptor {
  final LoggerService logger;

  ErrorInterceptor({required this.logger});

  @override
  void onError(DioException err, ErrorInterceptorHandler handler) {
    final error = _mapDioError(err);
    logger.error('API Error: ${error.message}', error: err);

    // Handle specific error types
    if (error is NetworkFailure) {
      // Show offline banner
    } else if (error is AuthFailure) {
      // Trigger re-authentication
    }

    handler.reject(error);
  }

  ApiFailure _mapDioError(DioException error) {
    // Map Dio errors to custom failure types
  }
}
```

### 7. Exception Hierarchy

**Structured Error Handling**
```dart
// Base Exception
class ApiException implements Exception {
  final String message;
  final int? statusCode;
  final dynamic data;

  ApiException({required this.message, this.statusCode, this.data});
}

// Specific Exceptions
class NetworkException extends ApiException {}
class AuthException extends ApiException {}
class ServerException extends ApiException {}
class ValidationException extends ApiException {}
class NotFoundException extends ApiException {}
class ConflictException extends ApiException {}
class RateLimitException extends ApiException {}
class UnknownException extends ApiException {}
```

### 8. Failure Hierarchy

**Functional Error Models**
```dart
sealed class ApiFailure {
  final String message;
  final int? statusCode;
  final dynamic data;

  ApiFailure({required this.message, this.statusCode, this.data});
}

class NetworkFailure extends ApiFailure {}
class AuthFailure extends ApiFailure {}
class ServerFailure extends ApiFailure {}
class ValidationFailure extends ApiFailure {}
class NotFoundFailure extends ApiFailure {}
class ConflictFailure extends ApiFailure {}
class RateLimitFailure extends ApiFailure {}
class UnknownFailure extends ApiFailure {}
```

### 9. API Response Handling

**Type-Safe Response Models**
```dart
class ApiResponse<T> {
  final T? data;
  final ApiFailure? error;
  final int statusCode;
  final bool success;

  ApiResponse.success({required this.data, required this.statusCode})
      : success = true,
        error = null;

  ApiResponse.failure({required this.error, required this.statusCode})
      : success = false,
        data = null;
}

class PaginatedResponse<T> {
  final List<T> data;
  final int page;
  final int perPage;
  final int total;
  final int totalPages;

  PaginatedResponse({
    required this.data,
    required this.page,
    required this.perPage,
    required this.total,
    required this.totalPages,
  });
}
```

### 10. Timeout Strategy

**Adaptive Timeout Management**
```dart
class TimeoutConfig {
  static const int connectTimeout = 15000; // 15s
  static const int receiveTimeout = 30000; // 30s
  static const int sendTimeout = 30000; // 30s

  // Adaptive timeout based on network conditions
  static Duration getConnectTimeout(NetworkStatus status) {
    return status == NetworkStatus.slow
        ? Duration(milliseconds: 30000)
        : Duration(milliseconds: connectTimeout);
  }
}
```

### 11. Retry Strategy

**Intelligent Retry Mechanism**
```dart
class RetryInterceptor extends Interceptor {
  final Dio dio;
  final int maxRetries;
  final Duration retryDelay;

  RetryInterceptor({
    required this.dio,
    this.maxRetries = 3,
    this.retryDelay = const Duration(seconds: 1),
  });

  @override
  void onError(DioException err, ErrorInterceptorHandler handler) async {
    if (_shouldRetry(err)) {
      for (int i = 0; i < maxRetries; i++) {
        await Future.delayed(retryDelay * (i + 1));

        try {
          final response = await dio.request(
            err.requestOptions.path,
            data: err.requestOptions.data,
            queryParameters: err.requestOptions.queryParameters,
            options: Options(
              method: err.requestOptions.method,
              headers: err.requestOptions.headers,
            ),
          );
          return handler.resolve(response);
        } catch (e) {
          if (i == maxRetries - 1) {
            return handler.reject(err);
          }
        }
      }
    }

    handler.reject(err);
  }

  bool _shouldRetry(DioException error) {
    return error.type == DioExceptionType.connectionTimeout ||
           error.type == DioExceptionType.receiveTimeout ||
           error.type == DioExceptionType.sendTimeout ||
           (error.response?.statusCode == 503);
  }
}
```

### 12. Logging Strategy

**Comprehensive Network Logging**
```dart
class NetworkLogger {
  final LoggerService logger;

  NetworkLogger({required this.logger});

  void logRequest(RequestOptions options) {
    logger.info('''
[REQUEST] ${options.method} ${options.uri}
Headers: ${options.headers}
Body: ${options.data}
''');
  }

  void logResponse(Response response) {
    logger.info('''
[RESPONSE] ${response.statusCode} ${response.requestOptions.uri}
Body: ${response.data}
''');
  }

  void logError(DioException error) {
    logger.error('''
[ERROR] ${error.type} ${error.requestOptions.uri}
Message: ${error.message}
Response: ${error.response?.data}
''', error: error);
  }
}
```

### 13. JSON Serialization Approach

**Type-Safe Serialization**
```dart
// Base Model
abstract class ApiModel {
  Map<String, dynamic> toJson();
  factory ApiModel.fromJson(Map<String, dynamic> json);
}

// JSON Converter
class JsonConverter {
  static T fromJson<T>(dynamic json, T Function(Map<String, dynamic>) fromJson) {
    if (json is Map<String, dynamic>) {
      return fromJson(json);
    } else if (json is String) {
      return fromJson(jsonDecode(json) as Map<String, dynamic>);
    }
    throw FormatException('Invalid JSON format');
  }

  static String toJson(dynamic object) {
    if (object is ApiModel) {
      return jsonEncode(object.toJson());
    }
    return jsonEncode(object);
  }
}

// DTO Pattern
class UserDto extends ApiModel {
  final String id;
  final String name;
  final String email;

  UserDto({required this.id, required this.name, required this.email});

  @override
  Map<String, dynamic> toJson() => {
    'id': id,
    'name': name,
    'email': email,
  };

  @override
  factory UserDto.fromJson(Map<String, dynamic> json) {
    return UserDto(
      id: json['id'] as String,
      name: json['name'] as String,
      email: json['email'] as String,
    );
  }
}
```

### 14. Dependency Injection Approach

**Riverpod Integration**
```dart
// Providers
final dioProvider = Provider<Dio>((ref) {
  return Dio();
});

final loggerServiceProvider = Provider<LoggerService>((ref) {
  return LoggerService(Logger());
});

final apiConfigProvider = Provider<ApiConfig>((ref) {
  return ApiConfig.fromEnv();
});

final dioClientProvider = Provider<DioClient>((ref) {
  return DioClient(
    dio: ref.watch(dioProvider),
    logger: ref.watch(loggerServiceProvider),
    constants: ref.watch(apiConfigProvider),
  );
});

// Repository Provider Example
final userRepositoryProvider = Provider<UserRepository>((ref) {
  return UserRepositoryImpl(
    dioClient: ref.watch(dioClientProvider),
  );
});
```

### 15. Testing Strategy

**Comprehensive Testing Approach**
```dart
// Mock Client
class MockDioClient extends Mock implements DioClient {}

// Test Utilities
class NetworkTestUtils {
  static Dio createTestDio({
    List<Interceptor> interceptors = const [],
    String baseUrl = 'http://localhost:8080',
  }) {
    final dio = Dio(BaseOptions(baseUrl: baseUrl));
    dio.interceptors.addAll(interceptors);
    return dio;
  }

  static Map<String, dynamic> createMockResponse({
    dynamic data,
    int statusCode = 200,
    String statusMessage = 'OK',
  }) {
    return {
      'data': data,
      'statusCode': statusCode,
      'statusMessage': statusMessage,
    };
  }
}

// Test Cases
void main() {
  group('DioClient Tests', () {
    late DioClient client;
    late MockDio mockDio;

    setUp(() {
      mockDio = MockDio();
      client = DioClient(dio: mockDio, logger: MockLoggerService(), constants: MockApiConfig());
    });

    test('GET request should return data', () async {
      // Arrange
      when(mockDio.get(any)).thenAnswer((_) async => Response(
        requestOptions: RequestOptions(path: '/users'),
        data: {'id': '1', 'name': 'Test User'},
        statusCode: 200,
      ));

      // Act
      final response = await client.get('/users');

      // Assert
      expect(response.data, isA<Map<String, dynamic>>());
      expect(response.data['name'], 'Test User');
    });

    test('POST request should handle errors', () async {
      // Arrange
      when(mockDio.post(any)).thenThrow(DioException(
        requestOptions: RequestOptions(path: '/users'),
        response: Response(
          requestOptions: RequestOptions(path: '/users'),
          statusCode: 400,
          data: {'error': 'Invalid data'},
        ),
      ));

      // Act & Assert
      expect(
        () => client.post('/users', data: {}),
        throwsA(isA<ValidationException>()),
      );
    });
  });
}
```

## File Changes

### Files to Create

1. **`lib/core/network/api_config.dart`**
   - **Purpose**: Centralized API configuration management
   - **Why**: Separates configuration from client implementation
   - **Content**: Environment-aware configuration, timeout settings

2. **`lib/core/network/api_exception.dart`**
   - **Purpose**: Custom exception hierarchy
   - **Why**: Standardized error handling across the app
   - **Content**: Base and specific exception classes

3. **`lib/core/network/api_failure.dart`**
   - **Purpose**: Functional failure models
   - **Why**: Clean architecture compliance
   - **Content**: Sealed failure hierarchy

4. **`lib/core/network/api_response.dart`**
   - **Purpose**: Type-safe response models
   - **Why**: Consistent API response handling
   - **Content**: Success/failure response patterns

5. **`lib/core/network/interceptors/request_interceptor.dart`**
   - **Purpose**: Request preprocessing
   - **Why**: Authentication, headers, logging
   - **Content**: Token injection, request logging

6. **`lib/core/network/interceptors/response_interceptor.dart`**
   - **Purpose**: Response processing
   - **Why**: Data transformation, logging
   - **Content**: Response logging, data parsing

7. **`lib/core/network/interceptors/error_interceptor.dart`**
   - **Purpose**: Global error handling
   - **Why**: Consistent error management
   - **Content**: Error mapping, logging

8. **`lib/core/network/interceptors/retry_interceptor.dart`**
   - **Purpose**: Intelligent retry mechanism
   - **Why**: Improved reliability
   - **Content**: Adaptive retry logic

9. **`lib/core/network/models/api_model.dart`**
   - **Purpose**: Base model interface
   - **Why**: Consistent serialization
   - **Content**: JSON conversion contracts

10. **`lib/core/network/models/paginated_response.dart`**
    - **Purpose**: Pagination support
    - **Why**: API pagination patterns
    - **Content**: Pagination metadata

11. **`lib/core/network/services/network_logger.dart`**
    - **Purpose**: Network-specific logging
    - **Why**: Debugging and monitoring
    - **Content**: Request/response logging

12. **`lib/core/network/services/network_monitor.dart`**
    - **Purpose**: Connectivity monitoring
    - **Why**: Offline handling
    - **Content**: Network status tracking

13. **`lib/core/network/utils/json_converter.dart`**
    - **Purpose**: JSON serialization
    - **Why**: Type-safe data conversion
    - **Content**: JSON parsing utilities

14. **`lib/core/constants/api_constants.dart`**
    - **Purpose**: API-related constants
    - **Why**: Centralized configuration
    - **Content**: Endpoints, headers, timeouts

15. **`lib/core/constants/error_messages.dart`**
    - **Purpose**: Error message constants
    - **Why**: Consistent user messaging
    - **Content**: User-friendly error messages

### Files to Modify

1. **`lib/core/network/dio_client.dart`**
   - **Changes**: Complete implementation
   - **Why**: Add actual functionality
   - **Add**: Constructor, setup, request methods

2. **`lib/core/constants/app_constants.dart`**
   - **Changes**: Add network constants
   - **Why**: Centralize configuration
   - **Add**: API base URLs, timeouts

3. **`lib/core/services/logger_service.dart`**
   - **Changes**: Complete implementation
   - **Why**: Enable network logging
   - **Add**: Logging methods

4. **`lib/app/providers.dart`**
   - **Changes**: Add network providers
   - **Why**: Dependency injection
   - **Add**: Dio, DioClient, interceptors

5. **`.env.example`**
   - **Changes**: Add more configuration
   - **Why**: Environment management
   - **Add**: Retry settings, logging levels

### Files to Remove

None - All existing files should be enhanced rather than removed

## Risks

### Implementation Risks

1. **Complexity Overhead**
   - **Risk**: Over-engineering for current needs
   - **Mitigation**: Implement incrementally, start with core functionality

2. **Performance Impact**
   - **Risk**: Interceptors adding latency
   - **Mitigation**: Profile and optimize critical paths

3. **Dependency Conflicts**
   - **Risk**: Version conflicts with existing packages
   - **Mitigation**: Test integration thoroughly

4. **Error Handling Complexity**
   - **Risk**: Overly complex exception hierarchy
   - **Mitigation**: Start with basic exceptions, expand as needed

5. **Testing Complexity**
   - **Risk**: Difficult to mock and test
   - **Mitigation**: Provide comprehensive test utilities

6. **Authentication Integration**
   - **Risk**: Token management complexity
   - **Mitigation**: Design modular auth interceptors

### Operational Risks

1. **Network Reliability**
   - **Risk**: Poor network conditions
   - **Mitigation**: Implement robust retry and offline strategies

2. **API Changes**
   - **Risk**: Backend API modifications
   - **Mitigation**: Versioned API endpoints, comprehensive testing

3. **Security Vulnerabilities**
   - **Risk**: Sensitive data exposure
   - **Mitigation**: Proper encryption, secure storage

4. **Rate Limiting**
   - **Risk**: API rate limit issues
   - **Mitigation**: Implement rate limit detection and handling

## Alternatives Considered

### 1. Http Package Instead of Dio
- **Rejected**: Dio provides better features (interceptors, timeout, cancellation)
- **Reason**: More production-ready for complex applications

### 2. Chopper Instead of Dio
- **Rejected**: Adds code generation complexity
- **Reason**: Dio is simpler and more flexible for our needs

### 3. Retrofit with Dio
- **Rejected**: Code generation overhead
- **Reason**: Manual implementation provides more control

### 4. No Interceptors
- **Rejected**: Would require manual error handling everywhere
- **Reason**: Interceptors provide centralized control

### 5. Global Exception Handler Only
- **Rejected**: Less granular error handling
- **Reason**: Custom exception hierarchy provides better type safety

### 6. No Retry Mechanism
- **Rejected**: Poor user experience on transient failures
- **Reason**: Retry improves reliability without significant complexity

## Implementation Order

### Milestone 1: Core Infrastructure (Week 1)
1. **Create API Configuration**
   - Implement `ApiConfig` and environment management
   - Set up `.env` files for all environments

2. **Complete DioClient**
   - Implement base client with configuration
   - Add basic request methods (GET, POST, PUT, DELETE)

3. **Basic Error Handling**
   - Implement exception hierarchy
   - Add error interceptor

4. **Dependency Injection**
   - Set up Riverpod providers
   - Integrate with existing provider structure

### Milestone 2: Enhanced Features (Week 2)
1. **Request Interceptors**
   - Implement authentication interceptor
   - Add request logging

2. **Response Processing**
   - Implement response interceptor
   - Add response logging

3. **Retry Mechanism**
   - Implement retry interceptor
   - Add adaptive timeout

4. **JSON Serialization**
   - Implement JSON converter
   - Add base model interface

### Milestone 3: Testing & Integration (Week 3)
1. **Testing Infrastructure**
   - Create mock client
   - Implement test utilities

2. **Unit Tests**
   - Test DioClient functionality
   - Test interceptors

3. **Integration Tests**
   - Test with real API endpoints
   - Verify error handling

4. **Documentation**
   - Add usage examples
   - Document error handling patterns

### Milestone 4: Advanced Features (Week 4)
1. **Authentication Integration**
   - Implement token refresh
   - Add auth interceptors

2. **Pagination Support**
   - Implement paginated response
   - Add pagination utilities

3. **Performance Optimization**
   - Profile network calls
   - Optimize interceptors

4. **Monitoring**
   - Add analytics integration
   - Implement error reporting

## Definition of Done

### Core Network Layer
- ✅ DioClient fully implemented with all HTTP methods
- ✅ Environment configuration working for all environments
- ✅ All interceptors implemented and tested
- ✅ Exception hierarchy complete with proper mapping
- ✅ Dependency injection via Riverpod configured
- ✅ Comprehensive logging implemented
- ✅ Timeout and retry strategies configured
- ✅ JSON serialization working for all models

### Testing
- ✅ Unit tests for all network components
- ✅ Integration tests with mock API
- ✅ Error handling tests for all scenarios
- ✅ Performance tests for critical paths
- ✅ Test coverage > 90%

### Documentation
- ✅ Usage examples for all major features
- ✅ Error handling documentation
- ✅ Testing guidelines
- ✅ Integration guide for new features

### Integration
- ✅ Integrated with existing app structure
- ✅ Working with Riverpod providers
- ✅ Compatible with existing theme and routing
- ✅ No breaking changes to existing code

## Future Integration

### Authentication System
**Integration Points:**
- **Token Management**: Auth interceptor injects tokens
- **Refresh Tokens**: Automatic token refresh on 401
- **Session Management**: Clear tokens on logout
- **Biometric Auth**: Secure token storage

**Implementation:**
```dart
class AuthInterceptor extends Interceptor {
  final AuthService authService;

  AuthInterceptor({required this.authService});

  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) async {
    final token = await authService.getFreshToken();
    options.headers['Authorization'] = 'Bearer $token';
    super.onRequest(options, handler);
  }

  @override
  void onError(DioException err, ErrorInterceptorHandler handler) async {
    if (err.response?.statusCode == 401) {
      try {
        await authService.refreshToken();
        // Retry original request
        return handler.resolve(await _retryRequest(err.requestOptions));
      } catch (e) {
        authService.logout();
      }
    }
    super.onError(err, handler);
  }
}
```

### Refresh Tokens
**Strategy:**
- Automatic refresh on 401 responses
- Transparent to calling code
- Secure token storage
- Failed refresh triggers logout

### Repositories
**Integration Pattern:**
```dart
class UserRepositoryImpl implements UserRepository {
  final DioClient _client;

  UserRepositoryImpl({required DioClient client}) : _client = client;

  @override
  Future<ApiResponse<User>> getUser(String id) async {
    try {
      final response = await _client.get('/users/$id');
      final user = UserDto.fromJson(response.data).toDomain();
      return ApiResponse.success(data: user);
    } on ApiException catch (e) {
      return ApiResponse.failure(error: e.toFailure());
    }
  }
}
```

### AI APIs
**Special Considerations:**
- Large payload handling
- Streaming responses
- Rate limiting awareness
- Cost monitoring

**Implementation:**
```dart
class AiApiClient {
  final DioClient _client;

  AiApiClient({required DioClient client}) : _client = client;

  Future<Stream<String>> streamCompletion(CompletionRequest request) async {
    final response = await _client.post(
      '/ai/completions',
      data: request.toJson(),
      options: Options(responseType: ResponseType.stream),
    );

    return response.data.stream
      .transform(utf8.decoder)
      .transform(LineSplitter())
      .where((line) => line.isNotEmpty)
      .map((line) => line.startsWith('data:') ? line.substring(5) : line)
      .where((line) => line != '[DONE]')
      .map((line) => jsonDecode(line)['choices'][0]['text']);
  }
}
```

### Analytics
**Integration Points:**
- Request/response logging
- Error tracking
- Performance monitoring
- Usage analytics

**Implementation:**
```dart
class AnalyticsInterceptor extends Interceptor {
  final AnalyticsService analytics;

  AnalyticsInterceptor({required this.analytics});

  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    analytics.trackNetworkRequest(
      endpoint: options.path,
      method: options.method,
      timestamp: DateTime.now(),
    );
    super.onRequest(options, handler);
  }

  @override
  void onResponse(Response response, ResponseInterceptorHandler handler) {
    analytics.trackNetworkResponse(
      endpoint: response.requestOptions.path,
      statusCode: response.statusCode,
      duration: DateTime.now().difference(response.requestOptions.extra['startTime']),
    );
    super.onResponse(response, handler);
  }

  @override
  void onError(DioException err, ErrorInterceptorHandler handler) {
    analytics.trackNetworkError(
      endpoint: err.requestOptions.path,
      errorType: err.type.name,
      statusCode: err.response?.statusCode,
    );
    super.onError(err, handler);
  }
}
```

### Offline Mode
**Strategy:**
- Request queueing
- Automatic retry when online
- Conflict resolution
- Data synchronization

**Implementation:**
```dart
class OfflineInterceptor extends Interceptor {
  final NetworkMonitor networkMonitor;
  final OfflineQueue offlineQueue;

  OfflineInterceptor({
    required this.networkMonitor,
    required this.offlineQueue,
  });

  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    if (!networkMonitor.isConnected) {
      // Queue request for later
      offlineQueue.add(options);
      handler.reject(DioException(
        requestOptions: options,
        error: NetworkFailure(message: 'Offline - request queued'),
      ));
    } else {
      // Process queued requests
      offlineQueue.process().catchError((_) {});
      super.onRequest(options, handler);
    }
  }
}
```

## Conclusion

This network foundation plan provides a comprehensive, production-ready architecture that integrates seamlessly with Ironit Mobile's existing Clean Architecture foundation. The proposed solution addresses all current gaps while maintaining flexibility for future requirements.

**Key Benefits:**
- **Modular Design**: Each component can be implemented and tested independently
- **Clean Architecture Compliance**: Separates concerns and dependencies properly
- **Extensibility**: Designed to support future requirements like authentication and offline mode
- **Testability**: Comprehensive testing strategy ensures reliability
- **Maintainability**: Clear separation of concerns and good documentation

**Implementation Timeline**: 4 weeks with a dedicated developer, following the milestones outlined above. The architecture is designed to grow with the application, supporting everything from basic API calls to complex features like real-time AI integration and offline functionality.