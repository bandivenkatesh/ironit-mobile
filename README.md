# Ironit Mobile

![Ironit Logo](assets/images/logo.png)

**Premium On-Demand Ironing Service for Hyderabad**

[![Flutter CI](https://github.com/bandivenkatesh/ironit-mobile/actions/workflows/flutter-ci.yml/badge.svg)](https://github.com/bandivenkatesh/ironit-mobile/actions/workflows/flutter-ci.yml)
[![License: MIT](https://img.shields.io/badge/License-MIT-yellow.svg)](https://opensource.org/licenses/MIT)
[![Flutter Version](https://img.shields.io/badge/Flutter-3.44.8-blue.svg)](https://flutter.dev)
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
| **Framework** | Flutter | 3.44.8 |
| **Language** | Dart | 3.0.0+ |
| **State Management** | Riverpod | 2.6.1 |
| **Navigation** | GoRouter | 13.2.5 |
| **Networking** | Dio | 5.11.0 |
| **Logging** | Logger | 2.7.0 |
| **Storage** | SharedPreferences | 2.5.5 |
| **Testing** | Flutter Test | SDK |
| **Linting** | Flutter Lints | 3.0.2 |

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

- Flutter SDK 3.44.8+
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
   # Environment variables are optional (remove flutter_dotenv if unused)
   # cp .env.example .env
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

## 🛠️ Development Tooling

### Taskfile (Enterprise Automation)

We use [Task](https://taskfile.dev/) for professional development automation:

```bash
# Install Task (if not installed)
brew install go-task/tap/go-task  # macOS
# or
sudo snap install task --classic   # Linux

# Available commands:
task help          # Show all available commands
task doctor        # Environment health check
task verify        # Run GitHub Actions quality gates locally
task ci-local      # Full CI pipeline locally
task build         # Build debug APK
task test          # Run all tests
task format        # Format code
task analyze       # Static analysis
```

### Helper Scripts

```bash
./scripts/doctor.sh      # Comprehensive environment check
./scripts/verify.sh      # GitHub Actions verification
./scripts/ci-local.sh     # Full CI pipeline
./scripts/build-apk.sh   # Build APK with options
```

## 📦 Project Tooling

- **Taskfile.yml**: Enterprise-grade task automation
- **scripts/**: Reusable shell scripts for common operations
- **Task**: Professional task runner
- **GitHub Actions**: CI/CD pipeline
- **Flutter CLI**: Core development tools

## 🗺️ Roadmap

### Current Status: Platform Sprint 2 ✅ COMPLETED

| Phase | Status | Target Date |
|-------|--------|-------------|
| 1. Foundation | ✅ Completed | 2026-07-27 |
| 2. Platform Enhancement | ✅ Completed | 2026-07-28 |
| 3. Authentication | ⏳ In Progress | 2026-08-15 |
| 4. Core Experience | ⏳ Planned | 2026-09-01 |
| 5. User Experience | ⏳ Planned | 2026-09-15 |
| 6. Backend Integration | ⏳ Planned | 2026-10-01 |
| 7. Production Readiness | ⏳ Planned | 2026-10-15 |

**Next Milestone**: Authentication UI (Story 4)
**Platform Sprint 2 Achievements**:
- ✅ Enterprise Taskfile automation
- ✅ Professional helper scripts
- ✅ CI/CD pipeline enhancements
- ✅ Code quality improvements
- ✅ Documentation updates
- ✅ Dependency cleanup

## 📈 Versioning

We follow [Semantic Versioning](https://semver.org/spec/v2.0.0.html):

- **v0.1.0**: Foundation complete
- **v0.1.1**: Platform enhancements (Current)
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
- [Taskfile Documentation](Taskfile.yml)
- [Contributing Guide](CONTRIBUTING.md)

## 🔒 License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.

## 📬 Contact

- **Project Lead**: Venkatesh Bandi
- **Email**: venkatesh@ironit.com
- **GitHub**: [@bandivenkatesh](https://github.com/bandivenkatesh)

---

**© 2026 Ironit Technologies. All rights reserved.**

*Perfectly pressed clothes, delivered with precision and care.*