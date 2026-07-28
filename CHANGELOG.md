# Changelog

All notable changes to the Ironit Mobile project will be documented in this file.

The format is based on [Keep a Changelog](https://keepachangelog.com/en/1.0.0/),
and this project adheres to [Semantic Versioning](https://semver.org/spec/v2.0.0.html).

## [Unreleased]

## [0.2.0] - 2026-07-28
### Added
- Complete booking flow implementation with mock data
- Date selector widget with calendar integration
- Time slot selector with available slots display
- Address selector with multiple address options
- Service options selector with customization choices
- Notes field for special instructions
- Booking summary page with detailed breakdown
- Booking success page with confirmation details
- Bookings list page with booking history
- Booking detail page with comprehensive booking information
- Booking status timeline with visual progress tracking
- Enhanced booking cards with status chips and action buttons
- Booking draft state management with Riverpod
- Booking repository with mock implementation
- Domain models for Address, TimeSlot, ServiceOption, BookingDraft, BookingSummary
- Reusable booking widgets for consistent UI
- Price calculation and validation logic
- Form validation for booking flow
- Navigation between all booking screens
- Mock addresses and booking data
- TimelineStep model for booking status visualization

### Changed
- Updated service detail page to navigate to booking entry
- Enhanced router with all booking-related routes including booking detail
- Improved state management architecture
- Updated TODO.md to reflect completed stories
- Refactored provider structure for better organization
- Enhanced bookings page with better navigation to booking details
- Updated booking success page to navigate to booking detail
- Improved visual hierarchy and user experience across booking flow

### Fixed
- Resolved Riverpod provider syntax issues
- Fixed navigation between booking screens
- Corrected state management bugs
- Addressed analyzer warnings and formatting issues
- Fixed build and test configuration
- Resolved type annotation issues in booking providers
- Fixed deprecated API usage in booking pages
- Corrected unused imports in booking widgets

## [v0.1.1] - 2026-07-28

### Added
- **Platform Sprint 2 - Enterprise Tooling**
  - **Taskfile.yml**: Comprehensive enterprise-grade task automation
    - 50+ professional development tasks
    - Environment health checks
    - CI/CD pipeline automation
    - Build and test automation
    - Release preparation workflows
  - **Helper Scripts**: Professional shell scripts
    - `scripts/doctor.sh`: Comprehensive environment health check
    - `scripts/verify.sh`: GitHub Actions quality gates locally
    - `scripts/ci-local.sh`: Full CI pipeline execution
    - `scripts/build-apk.sh`: Flexible APK building with options
  - **Documentation Enhancements**
    - `CONTRIBUTING.md`: Comprehensive contribution guide
    - Updated `README.md` with tooling and version information
    - Enhanced project documentation structure

### Changed
- **CI/CD Improvements**
  - Updated GitHub Actions workflow to use Flutter 3.44.8 (from 3.19.5)
  - Enhanced workflow compatibility with current project requirements
  - Maintained all existing quality gates
- **Dependency Management**
  - Removed unused `flutter_dotenv` package
  - Cleaned up pubspec.yaml assets
  - Updated dependency versions in documentation
- **Code Quality Enhancements**
  - Fixed all Future.delayed type inference warnings (8 instances)
  - Resolved all use_build_context_synchronously warnings (3 instances)
  - Addressed all always_specify_types warnings (8 instances)
  - Achieved zero analyzer warnings (0/0)
  - Maintained 100% test pass rate (20/20 tests passing)
  - Improved BuildContext safety across async operations

### Fixed
- **Critical Bug Fixes**
  - Fixed BuildContext usage across async gaps in splash screen
  - Added proper mounted checks for all navigation operations
  - Resolved potential memory leaks in async callbacks
- **Configuration Issues**
  - Removed unused .env asset configuration
  - Fixed asset_does_not_exist analyzer warning
  - Updated environment configuration documentation
- **Type Safety Improvements**
  - Added explicit type annotations to all Future.delayed calls
  - Improved type inference throughout codebase
  - Enhanced null safety compliance

## [v0.1.2] - 2026-07-28

### Added
- **Story 4: Home Dashboard Implementation** ✅ COMPLETED
  - **Domain Models**: Service, Category, Promotion with full serialization
  - **Mock Data Layer**: Comprehensive mock repositories for all entities
  - **Repository Abstractions**: Clean Architecture interfaces and implementations
  - **Riverpod Providers**: State management for all data types
  - **Reusable Widgets**:
    - `ServiceCard`: Feature-rich service display with images, ratings, pricing
    - `CategoryCard`: Interactive category browsing with icons
    - `PromotionBanner`: Auto-scrolling promotional banners
  - **Loading/Empty/Error States**: Professional UI states for all scenarios
  - **Home Dashboard**: Complete dashboard with:
    - Greeting section with user location
    - Promotions carousel
    - Featured services grid
    - Category browsing
    - Popular services
    - Recently viewed services
    - Real-time search functionality
  - **Bottom Navigation**: 4-tab navigation (Home, Services, Bookings, Profile)
  - **Search Functionality**: Client-side search with real-time filtering

### Changed
- **Enhanced AppSpacing**: Added xxSmall (2.0) for finer spacing control
- **Updated Home Page**: Replaced placeholder with full-featured dashboard
- **Improved Router**: Home page now shows professional dashboard instead of placeholder

### Fixed
- **Type Safety**: Added proper Service model import in home page
- **Widget APIs**: Corrected usage of core widgets (LoadingWidget, ErrorStateWidget, EmptyStateWidget)
- **Null Safety**: Added proper null checks and conditional access throughout

## [v0.1.0] - 2026-07-27

### Added
- **Project Initialization**

## [v0.1.0] - 2026-07-27

### Added
- **Project Initialization**
  - Flutter project setup with Material 3
  - Clean Architecture foundation
  - Riverpod state management
  - GoRouter navigation
  - Multi-platform configuration (Android, iOS, Web)

- **Architecture Documentation**
  - Complete architecture audit (`docs/foundation_audit.md`)
  - Network foundation plan (`docs/network_foundation_plan.md`)
  - UI development roadmap (`docs/ui_development_plan.md`)

- **Design System**
  - Comprehensive design system (`docs/design_system.md`)
  - Color palette and typography
  - Component library specifications
  - Motion system and responsive rules
  - Accessibility guidelines

- **Engineering Standards**
  - Complete engineering handbook (`docs/PROJECT_RULES.md`)
  - Code quality rules
  - Testing requirements
  - Git workflow
  - Package management policy

- **Core Components**
  - Reusable widget library (PrimaryButton, SecondaryButton, AppScaffold, etc.)
  - Theme system (light/dark mode)
  - Basic navigation structure
  - Mock data infrastructure

- **Foundational Screens**
  - Splash screen with auto-navigation
  - Basic home screen structure
  - Error handling patterns
  - Loading state implementations

- **DevOps Foundation**
  - GitHub Actions CI/CD pipeline
  - Code formatting quality gate
  - Static analysis quality gate
  - Unit testing quality gate
  - Build verification quality gate
  - APK artifact upload
  - Dependency caching

- **Repository Standards**
  - CODEOWNERS file
  - Professional pull request template
  - Bug report issue template
  - Feature request issue template
  - Comprehensive README.md

### Changed
- **Sprint 1 - Story 1: Premium Splash & Welcome Experience** ✅ COMPLETED
  - Enhanced splash screen with premium branding and smooth animations
  - Added elegant welcome screen with feature highlights and CTAs
  - Updated navigation router with new routes (/welcome, /placeholder, /guest-placeholder)
  - Created placeholder screens for future authentication flows
  - Implemented fade and scale animations following design system
  - Ensured full responsive design support (mobile/tablet)
  - Added dark mode compatibility with proper theming
  - Implemented accessibility features (proper contrast, semantic widgets)
  - Followed Clean Architecture and engineering standards
  - Used existing design system components consistently

- **Sprint 1 - Story 2: Onboarding Flow** ✅ COMPLETED
  - Implemented 3-4 slide onboarding with PageView
  - Added skip button and navigation controls
  - Created smooth transitions between slides
  - Implemented get started CTA with auto-navigation
  - Added responsive layouts for all screen sizes
  - Ensured dark mode support
  - Added accessibility features
  - Implemented all required states

- **Sprint 1 - Story 3: Authentication Foundation** ✅ COMPLETED
  - Complete login screen with email/password validation
  - Registration screen with full form validation
  - Forgot password screen with success state
  - Mock authentication service
  - Reusable authentication components
  - Storage abstraction layer
  - Router updates with auth routes
  - Welcome screen navigation integration
  - Documentation updates

### Fixed
- **Code Quality Improvements**
  - Reduced analyzer warnings from 49 to 0
  - Maintained 100% test pass rate (20/20)
  - Improved type safety with strict analysis
  - Enhanced null safety throughout codebase
  - Fixed SharedPreferences initialization timing
  - Improved navigation flow with proper mounted checks
  - Ensured all form validation works correctly
  - Fixed theme compatibility issues in new components
  - Resolved MissingPluginException in splash screen

## [v0.2.0] - 2026-08-15 (Planned)

### Added
- Authentication UI (Login, Register, Forgot Password)
- Onboarding flow
- Welcome screen
- Enhanced home dashboard
- Service categories browsing
- Service detail pages
- Booking flow
- Order management
- User profile
- Settings and preferences

### Changed
- **Repository Hygiene Improvements**
  - Enhanced .gitignore with comprehensive patterns
  - Updated analysis_options.yaml with strict linting rules
  - Improved pubspec.yaml with metadata
  - Added proper versioning scheme
  - Updated CHANGELOG.md with release notes
  - Improved README.md with professional documentation

## [v0.2.0] - 2026-08-XX (Planned)

### Added
- Authentication UI (Login, Register, Forgot Password)
- Onboarding flow
- Welcome screen
- Enhanced home dashboard
- Service categories browsing
- Service detail pages
- Booking flow
- Order management
- User profile
- Settings and preferences

## [v0.3.0] - 2026-09-XX (Planned)

### Added
- Backend API integration
- Real authentication
- Repository implementations
- Network layer
- Local storage
- State persistence
- Error reporting
- Analytics integration

## [v0.4.0] - 2026-10-XX (Planned)

### Added
- Payment integration
- Maps and location services
- Push notification system
- Deep linking implementation
- Offline support
- Performance monitoring
- Crash reporting

## [v1.0.0] - 2026-11-XX (Planned)

### Added
- Production deployment
- App store listings (Google Play, App Store)
- Marketing materials
- User support system
- Feedback mechanisms
- Feature flags
- A/B testing

[Unreleased]: https://github.com/bandivenkatesh/ironit-mobile/compare/v0.1.0...HEAD
[v0.1.0]: https://github.com/bandivenkatesh/ironit-mobile/releases/tag/v0.1.0