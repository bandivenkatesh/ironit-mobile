# Contributing to Ironit Mobile

🎉 First off, thanks for taking the time to contribute! 🎉

We welcome contributions from everyone. By participating in this project, you agree to abide by our [Code of Conduct](CODE_OF_CONDUCT.md).

## 📋 Table of Contents

- [Getting Started](#-getting-started)
- [Development Workflow](#-development-workflow)
- [Code Quality Standards](#-code-quality-standards)
- [Commit Guidelines](#-commit-guidelines)
- [Pull Request Process](#-pull-request-process)
- [Testing](#-testing)
- [Documentation](#-documentation)
- [Issue Reporting](#-issue-reporting)
- [Feature Requests](#-feature-requests)
- [Community](#-community)

## 🚀 Getting Started

### Prerequisites

- Flutter SDK 3.44.8+
- Dart SDK 3.0.0+
- Git
- Java 17+ (for Android)
- Xcode (for iOS)

### Setup

1. **Fork the repository** on GitHub
2. **Clone your fork** locally:
   ```bash
   git clone https://github.com/your-username/ironit-mobile.git
   cd ironit-mobile
   ```
3. **Install dependencies**:
   ```bash
   flutter pub get
   ```
4. **Run the app**:
   ```bash
   flutter run
   ```

## 🔧 Development Workflow

### Branching Strategy

- **Main branch**: Always deployable, protected
- **Feature branches**: `feature/IR-123-description`
- **Bugfix branches**: `bugfix/IR-456-description`
- **Release branches**: `release/v1.2.0`

### Before You Code

1. **Check existing issues** to avoid duplicate work
2. **Discuss large changes** in a GitHub issue first
3. **Follow the engineering handbook** ([PROJECT_RULES.md](docs/PROJECT_RULES.md))
4. **Follow the design system** ([design_system.md](docs/design_system.md))

### Making Changes

1. **Create a new branch**:
   ```bash
   git checkout -b feature/IR-123-your-feature
   ```
2. **Implement your changes** following our architecture
3. **Write tests** for new functionality
4. **Run quality checks**:
   ```bash
   task verify  # Uses Taskfile for comprehensive checks
   ```
5. **Commit your changes** following our commit guidelines

## 🎯 Code Quality Standards

### Must Follow

- ✅ **Clean Architecture** principles
- ✅ **Riverpod** best practices
- ✅ **Material 3** design system
- ✅ **Null safety** everywhere
- ✅ **Type safety** with explicit types
- ✅ **Immutability** where possible
- ✅ **Proper error handling**
- ✅ **Accessibility** compliance
- ✅ **Responsive design**
- ✅ **Dark mode** support

### Quality Gates

All code must pass:
```bash
dart format .              # Formatting
flutter analyze           # Static analysis
flutter test              # Unit tests
task verify               # Full verification
```

### Code Style

- Use `final` and `const` appropriately
- Follow Dart effective style guide
- Use collection literals (`[]`, `{}`)
- Extract complex widgets into separate classes
- Keep methods small (< 30 lines)
- Keep widgets focused (< 150 lines)

## 📝 Commit Guidelines

### Commit Message Format

```
<type>(<scope>): <description>

[optional body]

[optional footer]
```

### Types

- `feat`: New feature
- `fix`: Bug fix
- `docs`: Documentation changes
- `style`: Formatting, missing semicolons, etc.
- `refactor`: Code refactoring
- `perf`: Performance improvements
- `test`: Adding missing tests
- `chore`: Maintenance tasks

### Examples

```
feat(auth): implement login validation

- Add email validation
- Add password validation
- Add form submission
- Update login state management

Refs: IR-123
```

```
fix(splash): add mounted checks for navigation

- Prevent BuildContext use across async gaps
- Add proper state management
- Update documentation

Closes: #456
```

## 🔀 Pull Request Process

1. **Push your branch** to your fork
2. **Open a Pull Request** against `main` branch
3. **Use the PR template** and fill all sections
4. **Link to relevant issues** using `Closes #123` or `Refs IR-456`
5. **Request review** from code owners
6. **Address feedback** promptly
7. **Wait for approval** and CI to pass
8. **Merge** using squash merge

### PR Requirements

- ✅ Linked to Jira ticket (if applicable)
- ✅ Clear description of changes
- ✅ Screenshots for UI changes
- ✅ Passing CI checks
- ✅ At least one approval
- ✅ No merge conflicts
- ✅ Updated documentation
- ✅ Updated CHANGELOG (if applicable)

## 🧪 Testing

### Test Requirements

- **Unit tests** for business logic
- **Widget tests** for UI components
- **Integration tests** for user flows
- **80%+ coverage** for core modules
- **Edge cases** covered
- **Error conditions** tested

### Running Tests

```bash
flutter test              # All tests
flutter test --coverage  # With coverage
task test                 # Using Taskfile
```

### Test Structure

```dart
group('ServiceCard Widget Tests', () {
  testWidgets('displays service name', (tester) async {
    await tester.pumpWidget(
      MaterialApp(
        home: ServiceCard(service: mockService),
      ),
    );

    expect(find.text(mockService.name), findsOneWidget);
  });

  testWidgets('calls onBook when button pressed', (tester) async {
    var called = false;
    await tester.pumpWidget(
      MaterialApp(
        home: ServiceCard(
          service: mockService,
          onBook: () => called = true,
        ),
      ),
    );

    await tester.tap(find.text('Book Now'));
    expect(called, isTrue);
  });
});
```

## 📚 Documentation

### Documentation Requirements

- **Complex logic** must be documented
- **Public APIs** must have docstrings
- **Architecture decisions** must be explained
- **Breaking changes** must be highlighted

### Documentation Updates

Update relevant documentation when you:
- Add new features
- Change existing behavior
- Modify public APIs
- Update dependencies

## 🐛 Issue Reporting

### Bug Report Requirements

- **Clear title** describing the issue
- **Steps to reproduce**
- **Expected vs actual behavior**
- **Environment details** (device, OS, app version)
- **Screenshots/videos** if applicable
- **Log files** if available

### Issue Triage

- `bug`: Confirmed bugs
- `enhancement`: Feature requests
- `documentation`: Documentation issues
- `question`: Questions and discussions
- `good first issue`: Beginner-friendly

## 💡 Feature Requests

### Feature Proposal Requirements

- **Clear problem statement**
- **Proposed solution**
- **Alternatives considered**
- **Priority assessment**
- **Estimated effort**
- **Impact analysis**

### Feature Review Process

1. **Discussion** in GitHub issue
2. **Architecture review** by maintainers
3. **Prioritization** in roadmap
4. **Implementation** in sprint
5. **Testing and QA**
6. **Documentation update**

## 🤝 Community

### Ways to Contribute

- **Code**: Implement features and fixes
- **Tests**: Improve test coverage
- **Docs**: Enhance documentation
- **Reviews**: Provide constructive feedback
- **Issues**: Report bugs and request features
- **Discussions**: Share ideas and insights

### Communication

- **GitHub Issues**: For bug reports and feature requests
- **Pull Requests**: For code contributions
- **Discussions**: For general questions and ideas

### Code of Conduct

Please follow our [Code of Conduct](CODE_OF_CONDUCT.md) in all interactions.

## 🎓 Learning Resources

- [Flutter Documentation](https://flutter.dev/docs)
- [Riverpod Documentation](https://riverpod.dev/)
- [Clean Architecture Guide](https://blog.cleancoder.com/uncle-bob/2012/08/13/the-clean-architecture.html)
- [Material 3 Design](https://m3.material.io/)

## 🙏 Acknowledgments

Thank you for contributing to Ironit Mobile! Your efforts help make this project better for everyone.

---

**Need help?** Open an issue or ask in discussions!

**© 2026 Ironit Technologies. All rights reserved.**