# Ironit Mobile UI-First Development Plan

## Executive Summary

This document outlines a rapid UI-first implementation strategy to deliver a beautiful, fully navigable Flutter application for demonstration purposes. The plan leverages existing architecture and focuses on visible features using mock data, enabling quick progress without backend dependencies.

## 1. Current UI Status

### Existing Screens

1. **Splash Screen** (`lib/features/splash/presentation/pages/splash_page.dart`)
   - ✅ Functional with auto-navigation to home
   - ✅ Loading indicator
   - ❌ Basic visual design (just CircularProgressIndicator)

2. **Home Screen** (`lib/features/home/presentation/pages/home_page.dart`)
   - ✅ Basic scaffold structure
   - ✅ Centered "Ironit" text
   - ❌ No actual content or functionality
   - ❌ Placeholder design only

### Available Reusable Widgets

1. **PrimaryButton** - Feature-rich filled button with:
   - Loading states
   - Disabled states
   - Full-width support
   - Icon support
   - Material 3 theming

2. **SecondaryButton** - Outline button variant with:
   - Same features as PrimaryButton
   - Different visual style
   - Consistent theming

3. **AppTextField** - Themed text input with:
   - Hint text
   - Error states
   - Label support
   - Validation indicators
   - Material 3 styling

4. **AppScaffold** - Base layout component with:
   - SafeArea handling
   - Keyboard dismissal
   - AppBar support
   - Bottom navigation support
   - Theme integration

5. **EmptyStateWidget** - Empty state display with:
   - Customizable icon
   - Title and subtitle
   - Action button support
   - Centered layout

6. **ErrorStateWidget** - Error state display with:
   - Error icon
   - Error message
   - Retry button
   - Centered layout

7. **LoadingWidget** - Loading indicator with:
   - Circular progress indicator
   - Centered layout
   - Theme integration

### Current Navigation

- ✅ GoRouter configured
- ✅ Basic routes: `/` (splash) → `/home`
- ✅ Type-safe navigation
- ❌ Limited route coverage
- ❌ No nested navigation
- ❌ No route guards

## 2. Missing Screens for MVP

### Core Application Screens

1. **Welcome Screen** - Introduction to the app
2. **Onboarding Screen** - Feature highlights (3-4 slides)
3. **Login Screen** - Email/password login with mock auth
4. **Register Screen** - User registration form
5. **Forgot Password Screen** - Password recovery flow
6. **Home Screen Enhancement** - Service categories and promotions
7. **Service Categories Screen** - Browse ironing services
8. **Service Detail Screen** - Individual service information
9. **Booking Screen** - Schedule ironing service
10. **Booking Confirmation Screen** - Order summary
11. **Orders Screen** - Order history and status
12. **Order Detail Screen** - Individual order information
13. **Profile Screen** - User profile management
14. **Settings Screen** - App preferences and configuration
15. **About Screen** - App information and contact

### Priority Order for Implementation

1. **Welcome Screen** (High) - First impression
2. **Onboarding Screen** (High) - User education
3. **Login/Register Screens** (High) - User access
4. **Enhanced Home Screen** (Critical) - Main app entry
5. **Service Categories Screen** (High) - Core functionality
6. **Service Detail Screen** (High) - Service information
7. **Booking Screen** (High) - Primary conversion
8. **Booking Confirmation** (Medium) - User reassurance
9. **Orders Screen** (Medium) - User history
10. **Profile/Settings** (Low) - Secondary features

## 3. Navigation Flow

### User Journey Map

```
[Splash] → [Welcome] → [Onboarding] → [Login/Register] → [Home]
    ↓
[Home] → [Service Categories] → [Service Detail] → [Booking] → [Confirmation]
    ↓
[Home] → [Orders] → [Order Detail]
    ↓
[Home] → [Profile] → [Settings/About]
```

### Detailed Navigation Paths

1. **First Launch Flow**
   - Splash → Welcome → Onboarding → Login → Home

2. **Authenticated User Flow**
   - Splash → Home (auto-login with mock)

3. **Service Booking Flow**
   - Home → Service Categories → Service Detail → Booking → Confirmation → Home

4. **Order Management Flow**
   - Home → Orders → Order Detail → Back to Orders

5. **Profile Management Flow**
   - Home → Profile → Settings/About → Back to Profile

### Route Configuration Plan

```dart
GoRouter(
  routes: [
    GoRoute(path: '/', builder: (_, __) => SplashPage()),
    GoRoute(path: '/welcome', builder: (_, __) => WelcomePage()),
    GoRoute(path: '/onboarding', builder: (_, __) => OnboardingPage()),
    GoRoute(path: '/login', builder: (_, __) => LoginPage()),
    GoRoute(path: '/register', builder: (_, __) => RegisterPage()),
    GoRoute(path: '/home', builder: (_, __) => HomePage()),
    GoRoute(path: '/services', builder: (_, __) => ServiceCategoriesPage()),
    GoRoute(path: '/service/:id', builder: (_, __) => ServiceDetailPage()),
    GoRoute(path: '/booking', builder: (_, __) => BookingPage()),
    GoRoute(path: '/confirmation', builder: (_, __) => ConfirmationPage()),
    GoRoute(path: '/orders', builder: (_, __) => OrdersPage()),
    GoRoute(path: '/order/:id', builder: (_, __) => OrderDetailPage()),
    GoRoute(path: '/profile', builder: (_, __) => ProfilePage()),
    GoRoute(path: '/settings', builder: (_, __) => SettingsPage()),
    GoRoute(path: '/about', builder: (_, __) => AboutPage()),
  ],
  redirect: (context, state) {
    // Mock auth logic - redirect to login if not "authenticated"
    final isAuthenticated = MockAuth.isAuthenticated;
    final isAuthRoute = state.location.startsWith('/login') ||
                       state.location.startsWith('/register') ||
                       state.location.startsWith('/welcome') ||
                       state.location.startsWith('/onboarding');

    if (!isAuthenticated && !isAuthRoute && state.location != '/') {
      return '/login';
    }
    return null;
  },
)
```

## 4. Mock Data Strategy

### Data Requirements by Screen

1. **Welcome Screen**
   - App name, tagline, hero image
   - Primary CTA buttons

2. **Onboarding Screen**
   - 3-4 feature highlight slides
   - Title, description, image for each

3. **Login Screen**
   - Mock email/password validation
   - Mock authentication success/failure

4. **Home Screen**
   - Service categories (5-6 items)
   - Promotional banners (2-3 items)
   - User greeting

5. **Service Categories**
   - Category list with icons
   - Mock service data

6. **Service Detail**
   - Service description, pricing
   - Images, features, reviews

7. **Booking Screen**
   - Date/time selection
   - Address input
   - Service options

8. **Orders Screen**
   - Order history (5-10 mock orders)
   - Status indicators

### Mock Data Implementation

```dart
// lib/core/mock/mock_data.dart
class MockData {
  // User data
  static final currentUser = User(
    id: '1',
    name: 'John Doe',
    email: 'john@example.com',
    phone: '+1 234 567 890',
    address: '123 Main St, Hyderabad',
  );

  // Services
  static final services = [
    Service(
      id: '1',
      name: 'Shirt Ironing',
      description: 'Professional shirt ironing service',
      price: 299,
      duration: 24,
      image: 'assets/images/shirt_ironing.jpg',
      category: 'clothing',
    ),
    // More services...
  ];

  // Orders
  static final orders = [
    Order(
      id: '1',
      service: services[0],
      status: OrderStatus.completed,
      date: DateTime.now().subtract(Duration(days: 2)),
      price: 598,
      address: currentUser.address,
    ),
    // More orders...
  ];

  // Auth
  static bool isAuthenticated = false;
  static const validCredentials = {
    'email': 'demo@example.com',
    'password': 'password123',
  };
}

// Usage in screens
final services = MockData.services;
final currentUser = MockData.currentUser;
```

### Mock Service Layer

```dart
// lib/core/mock/mock_service.dart
class MockAuthService {
  static Future<bool> login(String email, String password) async {
    await Future.delayed(Duration(seconds: 1)); // Simulate network
    if (email == MockData.validCredentials['email'] &&
        password == MockData.validCredentials['password']) {
      MockData.isAuthenticated = true;
      return true;
    }
    return false;
  }

  static Future<void> logout() async {
    await Future.delayed(Duration(milliseconds: 500));
    MockData.isAuthenticated = false;
  }

  static Future<User> getCurrentUser() async {
    await Future.delayed(Duration(milliseconds: 300));
    return MockData.currentUser;
  }
}

class MockServiceService {
  static Future<List<Service>> getServices() async {
    await Future.delayed(Duration(seconds: 1));
    return MockData.services;
  }

  static Future<Service> getService(String id) async {
    await Future.delayed(Duration(milliseconds: 500));
    return MockData.services.firstWhere((s) => s.id == id);
  }
}

class MockOrderService {
  static Future<List<Order>> getOrders() async {
    await Future.delayed(Duration(seconds: 1));
    return MockData.orders;
  }

  static Future<Order> createOrder(Order order) async {
    await Future.delayed(Duration(seconds: 1));
    MockData.orders.insert(0, order);
    return order;
  }
}
```

## 5. Screen Build Order

### Fastest Implementation Sequence

**Phase 1: Foundation (4-6 hours)**
1. **Enhance Home Screen** (2 hours)
   - Add service categories grid
   - Add promotional banners
   - Implement mock data loading
   - Add user greeting

2. **Create Welcome Screen** (1 hour)
   - Hero image with app logo
   - Tagline and description
   - Login/Register buttons
   - Simple gradient background

3. **Create Onboarding Screen** (2 hours)
   - PageView with 3 slides
   - Skip button
   - Next/Back navigation
   - Get Started CTA

**Phase 2: Authentication (3-4 hours)**
4. **Create Login Screen** (2 hours)
   - Email/Password fields (using AppTextField)
   - Login button (using PrimaryButton)
   - Forgot password link
   - Mock validation and auth

5. **Create Register Screen** (2 hours)
   - Name, Email, Password fields
   - Register button
   - Login link
   - Mock form validation

**Phase 3: Core Features (6-8 hours)**
6. **Create Service Categories Screen** (2 hours)
   - Grid of service categories
   - Search functionality
   - Category filtering
   - Mock data integration

7. **Create Service Detail Screen** (3 hours)
   - Service images carousel
   - Description and pricing
   - Features list
   - Book Now button
   - Reviews section

8. **Create Booking Screen** (3 hours)
   - Date/time picker
   - Address form
   - Service options
   - Price summary
   - Confirm button

**Phase 4: Supporting Features (4-6 hours)**
9. **Create Orders Screen** (2 hours)
   - Order list with status
   - Filter by status
   - Pull-to-refresh
   - Mock order data

10. **Create Profile Screen** (2 hours)
    - User information display
    - Edit profile button
    - Settings and About links
    - Logout functionality

11. **Create Settings/About Screens** (1 hour each)
    - App version, contact info
    - Theme switching (if time permits)
    - Privacy policy link

**Phase 5: Polish (2-4 hours)**
12. **Add Animations** (2 hours)
    - Page transitions
    - Button animations
    - Loading indicators

13. **Responsive Adjustments** (1 hour)
    - Mobile/tablet layouts
    - Orientation handling

14. **Final Testing** (1 hour)
    - Navigation flow verification
    - Mock data validation
    - UI consistency check

## 6. Reusable Widgets

### Existing Widgets to Reuse

1. **PrimaryButton** - Use for all primary CTAs
2. **SecondaryButton** - Use for secondary actions
3. **AppTextField** - Use for all form inputs
4. **AppScaffold** - Use as base for all screens
5. **EmptyStateWidget** - Use for empty lists
6. **ErrorStateWidget** - Use for error displays
7. **LoadingWidget** - Use for loading states

### New Widgets to Create

1. **ServiceCard** - Reusable service display
   - Image, title, price, rating
   - Consistent styling
   - Navigation support

2. **CategoryChip** - Filter chip for categories
   - Selected/unselected states
   - Icon support
   - Compact design

3. **OrderCard** - Order summary display
   - Status indicator
   - Service info
   - Date and price
   - Action buttons

4. **RatingDisplay** - Star rating component
   - Read-only and interactive
   - Half-star support
   - Size variants

5. **ImageCarousel** - Service image slider
   - Dots indicator
   - Auto-play option
   - Full-screen support

6. **DateTimePicker** - Custom date/time selector
   - Calendar view
   - Time slots
   - Availability highlighting

7. **FeatureList** - Service features display
   - Icon + text items
   - Compact layout
   - Themed icons

### Widget Creation Priority

1. **ServiceCard** (Immediate) - Needed for home and categories
2. **CategoryChip** (Immediate) - Needed for categories screen
3. **OrderCard** (Phase 4) - Needed for orders screen
4. **ImageCarousel** (Phase 3) - Needed for service detail
5. **DateTimePicker** (Phase 3) - Needed for booking
6. **RatingDisplay** (Phase 3) - Needed for service detail
7. **FeatureList** (Phase 3) - Needed for service detail

## 7. Architecture Validation

### Compliance with Existing Architecture

✅ **Clean Architecture Layers**
- Presentation layer (screens) will use existing widgets
- No domain layer changes required
- No data layer implementation needed (using mocks)

✅ **Riverpod Integration**
- Existing provider structure can remain unchanged
- Mock services can be added to providers when needed
- No breaking changes to DI system

✅ **GoRouter Compatibility**
- Current router structure supports all new routes
- No changes to existing navigation patterns
- Type-safe routing maintained

✅ **Material 3 Theming**
- All new screens will use existing theme
- Widgets automatically inherit theme styles
- No theme modifications required

✅ **Widget Library**
- Existing widgets cover 80% of UI needs
- New widgets follow same patterns
- Consistent styling maintained

### No Architecture Changes Required

The proposed UI implementation:
- Uses existing widget library
- Leverages current routing system
- Maintains Clean Architecture principles
- Preserves Riverpod state management
- Follows Material 3 design system
- Requires no infrastructure changes

## 8. Sprint Plan

### Sprint 1: Foundation (1 day)

**Story 1: Enhance Home Screen**
- ✅ Add service categories grid using ServiceCard
- ✅ Add promotional banners
- ✅ Implement mock data loading
- ✅ Add user greeting with mock user
- ✅ Test navigation to service categories

**Story 2: Create Welcome Screen**
- ✅ Design hero section with app logo
- ✅ Add tagline and description
- ✅ Implement Login/Register buttons
- ✅ Add gradient background
- ✅ Test navigation to auth screens

**Story 3: Create Onboarding Screen**
- ✅ Implement PageView with 3 slides
- ✅ Add skip button functionality
- ✅ Implement next/back navigation
- ✅ Add get started CTA
- ✅ Test auto-navigation to login

### Sprint 2: Authentication (1 day)

**Story 4: Create Login Screen**
- ✅ Design login form with AppTextField
- ✅ Implement email/password validation
- ✅ Add login button with PrimaryButton
- ✅ Implement mock authentication
- ✅ Test successful/failed login flows

**Story 5: Create Register Screen**
- ✅ Design registration form
- ✅ Implement form validation
- ✅ Add register button
- ✅ Implement mock registration
- ✅ Test navigation to home

### Sprint 3: Core Features (2 days)

**Story 6: Create Service Categories Screen**
- ✅ Design category grid layout
- ✅ Implement CategoryChip filtering
- ✅ Add search functionality
- ✅ Integrate mock service data
- ✅ Test navigation to service detail

**Story 7: Create Service Detail Screen**
- ✅ Implement ImageCarousel
- ✅ Add service description and pricing
- ✅ Create features list with FeatureList
- ✅ Add rating display with RatingDisplay
- ✅ Test navigation to booking

**Story 8: Create Booking Screen**
- ✅ Implement DateTimePicker
- ✅ Add address form fields
- ✅ Create service options selection
- ✅ Add price summary section
- ✅ Test navigation to confirmation

### Sprint 4: Supporting Features (1 day)

**Story 9: Create Orders Screen**
- ✅ Design order list layout
- ✅ Implement OrderCard component
- ✅ Add status filtering
- ✅ Integrate mock order data
- ✅ Test navigation to order detail

**Story 10: Create Profile Screen**
- ✅ Display user information
- ✅ Add edit profile button
- ✅ Implement settings/about links
- ✅ Add logout functionality
- ✅ Test navigation flows

### Sprint 5: Polish & Testing (1 day)

**Story 11: Add Animations**
- ✅ Implement page transitions
- ✅ Add button animations
- ✅ Create loading indicators
- ✅ Test animation performance

**Story 12: Responsive Adjustments**
- ✅ Mobile layout optimization
- ✅ Tablet layout support
- ✅ Orientation handling
- ✅ Test on multiple devices

**Story 13: Final Testing**
- ✅ Verify all navigation flows
- ✅ Validate mock data integration
- ✅ Check UI consistency
- ✅ Test error states
- ✅ Performance testing

## 9. Definition of Done

### For Each Screen

**Visual Requirements**
- ✅ Follows Material 3 design guidelines
- ✅ Uses existing theme colors and typography
- ✅ Consistent spacing and padding
- ✅ Proper icon usage
- ✅ Accessible color contrast

**Navigation Requirements**
- ✅ Proper route configuration in GoRouter
- ✅ Back button functionality
- ✅ Deep linking support (where applicable)
- ✅ Error handling for invalid routes
- ✅ Loading states during navigation

**Responsive Behavior**
- ✅ Mobile layout (360-480px width)
- ✅ Tablet layout (600-840px width)
- ✅ Portrait and landscape support
- ✅ Keyboard handling (no overflow)
- ✅ Safe area insets

**Mock Data Requirements**
- ✅ Realistic mock data structure
- ✅ Simulated network delays (500ms-1s)
- ✅ Error state simulation
- ✅ Empty state handling
- ✅ Loading state handling

**Testing Requirements**
- ✅ Manual navigation testing
- ✅ UI consistency verification
- ✅ Mock data validation
- ✅ Error state testing
- ✅ Performance testing (60fps)

### Specific Screen Criteria

**Welcome Screen**
- ✅ Hero image with app logo (200x200)
- ✅ Tagline: "Premium Ironing Services"
- ✅ Description: "On-demand ironing at your doorstep"
- ✅ Login button navigates to /login
- ✅ Register button navigates to /register

**Home Screen**
- ✅ User greeting: "Hello, [Name]!"
- ✅ 6 service categories in grid
- ✅ 2 promotional banners
- ✅ Quick booking button
- ✅ Navigation to all major sections

**Service Detail Screen**
- ✅ Image carousel with 3-5 images
- ✅ Service name, price, rating
- ✅ Detailed description
- ✅ Features list (5-7 items)
- ✅ Book Now button navigates to booking

**Booking Screen**
- ✅ Date picker with available slots
- ✅ Time selection (30-minute increments)
- ✅ Address form with validation
- ✅ Service options checkboxes
- ✅ Price calculation (updates dynamically)

## Implementation Strategy Summary

### Speed-First Approach

1. **Reuse Existing Components** (80% coverage)
   - Leverage all existing widgets
   - Follow established patterns
   - Minimize new code

2. **Mock Everything** (No backend dependency)
   - Static mock data files
   - Simulated network delays
   - Mock service layer
   - No authentication logic

3. **Incremental Implementation** (Small, testable steps)
   - Each screen takes 1-3 hours
   - Immediate visual feedback
   - Continuous testing

4. **Parallel Development** (Independent screens)
   - Screens can be built in any order
   - Mock data enables isolation
   - No blocking dependencies

### Expected Timeline

- **Day 1**: Foundation screens (Home, Welcome, Onboarding)
- **Day 2**: Authentication screens (Login, Register)
- **Day 3-4**: Core features (Services, Booking)
- **Day 5**: Supporting features (Orders, Profile)
- **Day 6**: Polish and testing

**Total**: 6 days to production-ready demo

### Success Metrics

- ✅ 12+ fully functional screens
- ✅ Smooth navigation between all screens
- ✅ Professional, consistent UI
- ✅ No visual bugs or glitches
- ✅ 60fps performance on target devices
- ✅ Ready for Android emulator demo

This plan delivers a beautiful, fully navigable application using only mock data and existing architecture, enabling rapid demonstration without backend dependencies.