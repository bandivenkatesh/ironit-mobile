# Ironit Mobile

![Ironit Logo](assets/images/logo.png)

**Premium On-Demand Ironing Service for Hyderabad**

[![Flutter CI](https://github.com/bandivenkatesh/ironit-mobile/actions/workflows/flutter-ci.yml/badge.svg)](https://github.com/bandivenkatesh/ironit-mobile/actions/workflows/flutter-ci.yml)
[![License: MIT](https://img.shields.io/badge/License-MIT-yellow.svg)](https://opensource.org/licenses/MIT)
[![Flutter Version](https://img.shields.io/badge/Flutter-3.19.5-blue.svg)](https://flutter.dev)
[![Platform](https://img.shields.io/badge/Platform-Android%20%7C%20iOS%20%7C%20Web-green.svg)](https://flutter.dev/multi-platform)

## 📱 Project Overview

Ironit Mobile is a premium, production-quality Flutter application that provides on-demand ironing services in Hyderabad. Built with Clean Architecture, Riverpod state management, and Material 3 design, Ironit delivers a seamless user experience with professional-grade code quality.

## 🏗️ Architecture

### Clean Architecture Implementation

```
┌─────────────────────────────────────────────────┐
│                 Presentation Layer                │
│  (UI, Widgets, State Management, Navigation)    │
└─────────────────────────────────────────────────┘
                      ↓
┌─────────────────────────────────────────────────┐
│                   Domain Layer                   │
│  (Business Logic, Entities, Use Cases, Repos)    │
└─────────────────────────────────────────────────┘
                      ↓
┌─────────────────────────────────────────────────┐
│                    Data Layer                    │
│  (API Clients, Repository Implementations, DTOs) │
└─────────────────────────────────────────────────┘
```

### Key Technologies

- **State Management**: Riverpod
- **Navigation**: GoRouter
- **Networking**: Dio
- **Dependency Injection**: Riverpod Providers
- **Local Storage**: SharedPreferences
- **Environment**: Flutter DotEnv
- **Logging**: Logger

## 📁 Folder Structure

```
lib/
├── app/                  # App initialization and providers
├── core/                 # Core functionality and utilities
│   ├── constants/        # App-wide constants
│   ├── network/          # Network clients and interceptors
│   ├── router/           # Navigation and routing
│   ├── services/         # Core services (logging, etc.)
│   ├── storage/          # Local storage abstractions
│   ├── theme/            # App theme and styling
│   └── widgets/          # Reusable UI components
├── features/             # Feature modules
│   ├── auth/             # Authentication feature
│   │   ├── data/         # Data layer (repositories, DTOs)
│   │   ├── domain/       # Domain layer (entities, use cases)
│   │   └── presentation/ # Presentation layer (widgets, pages)
│   ├── home/             # Home feature
│   ├── onboarding/       # Onboarding feature
│   ├── splash/           # Splash feature
│   └── welcome/          # Welcome feature
└── l10n/                # Localization (future)
```

## 🛠️ Tech Stack

| Category | Technology | Version |
|----------|------------|---------|
| **Framework** | Flutter | 3.19.5 |
| **Language** | Dart | 3.0.0+ |
| **State Management** | Riverpod | 2.4.9 |
| **Navigation** | GoRouter | 13.0.0 |
| **Networking** | Dio | 5.4.0 |
| **Logging** | Logger | 2.0.2 |
| **Environment** | Flutter DotEnv | 5.1.0 |
| **Storage** | SharedPreferences | 2.2.2 |
| **Testing** | Flutter Test | SDK |
| **Linting** | Flutter Lints | 3.0.0 |

## 📸 Screenshots

### Current Implementation (Sprint 1 - Foundation)

| Splash Screen | Welcome Screen | Login Screen |
|---------------|----------------|--------------|
| ![Splash](docs/screenshots/splash.png) | ![Welcome](docs/screenshots/welcome.png) | ![Login](docs/screenshots/login.png) |

| Register Screen | Forgot Password | Onboarding |
|-----------------|------------------|------------|
| ![Register](docs/screenshots/register.png) | ![Forgot Password](docs/screenshots/forgot_password.png) | ![Onboarding](docs/screenshots/onboarding.png) |

## 🚀 Getting Started

### Prerequisites

- Flutter SDK 3.19.5+
- Dart SDK 3.0.0+
- Java 17+ (for Android builds)
- Xcode (for iOS builds)
- Git

### Installation

1. **Clone the repository**:
   ```bash
   git clone https://github.com/bandivenkatesh/ironit-mobile.git
   cd ironit-mobile
   ```

2. **Install dependencies**:
   ```bash
   flutter pub get
   ```

3. **Set up environment**:
   ```bash
   cp .env.example .env
   # Edit .env with your configuration
   ```

4. **Run the app**:
   ```bash
   flutter run
   ```

## 🔧 Build

### Android

```bash
flutter build apk --release
# or
flutter build appbundle --release
```

### iOS

```bash
flutter build ios --release
# Requires Xcode and macOS
```

### Web

```bash
flutter build web --release
```

## 🧪 Testing

### Run all tests
```bash
flutter test
```

### Run specific test
```bash
flutter test test/widget_test.dart
```

### Test coverage
```bash
flutter test --coverage
```

## 🤖 CI/CD Pipeline

Our GitHub Actions pipeline ensures code quality with:

1. **Code Formatting**: `dart format --set-exit-if-changed .`
2. **Static Analysis**: `flutter analyze`
3. **Unit Testing**: `flutter test`
4. **Build Verification**: `flutter build apk --debug`
5. **Artifact Upload**: Debug APK for testing

**Quality Gates**:
- ✅ Formatting must pass
- ✅ Analysis must have zero warnings
- ✅ All tests must pass
- ✅ Build must succeed

## 🗺️ Roadmap

### Current Status: Sprint 1 ✅ COMPLETED

| Phase | Status | Target Date |
|-------|--------|-------------|
| 1. Foundation | ✅ Completed | 2026-07-27 |
| 2. Authentication | ⏳ In Progress | 2026-08-15 |
| 3. Core Experience | ⏳ Planned | 2026-09-01 |
| 4. User Experience | ⏳ Planned | 2026-09-15 |
| 5. Backend Integration | ⏳ Planned | 2026-10-01 |
| 6. Production Readiness | ⏳ Planned | 2026-10-15 |

**Next Milestone**: Authentication UI (Story 4)

## 📈 Versioning

We follow [Semantic Versioning](https://semver.org/spec/v2.0.0.html):

- **v0.1.0**: Foundation complete (Current)
- **v0.2.0**: Authentication UI (Planned)
- **v0.3.0**: Core booking flow (Planned)
- **v1.0.0**: Production launch (Planned)

## 📝 Changelog

See [CHANGELOG.md](CHANGELOG.md) for detailed release notes.

## 🤝 Contributing

We welcome contributions! Please follow our:

1. **Engineering Handbook**: [docs/PROJECT_RULES.md](docs/PROJECT_RULES.md)
2. **Design System**: [docs/design_system.md](docs/design_system.md)
3. **Pull Request Template**: [.github/PULL_REQUEST_TEMPLATE.md](.github/PULL_REQUEST_TEMPLATE.md)

### Development Workflow

1. Fork the repository
2. Create a feature branch: `feature/IR-123-description`
3. Implement your changes
4. Run quality checks:
   ```bash
   dart format .
   flutter analyze
   flutter test
   ```
5. Submit a pull request

## 📚 Documentation

- [Engineering Handbook](docs/PROJECT_RULES.md)
- [Design System](docs/design_system.md)
- [Roadmap](docs/ROADMAP.md)
- [Architecture Audit](docs/foundation_audit.md)
- [Network Foundation Plan](docs/network_foundation_plan.md)
- [UI Development Plan](docs/ui_development_plan.md)

## 🔒 License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.

## 📬 Contact

- **Project Lead**: Venkatesh Bandi
- **Email**: venkatesh@ironit.com
- **GitHub**: [@bandivenkatesh](https://github.com/bandivenkatesh)

---

**© 2026 Ironit Technologies. All rights reserved.**

*Perfectly pressed clothes, delivered with precision and care.*