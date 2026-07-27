# Ironit Mobile Engineering Handbook

## 1. Engineering Principles

### Core Values

1. **Incremental Development**
   - Build one small, testable feature at a time
   - Each story must compile independently
   - Never combine multiple features in one implementation

2. **Always Deployable**
   - Code must remain in deployable state
   - Feature flags for incomplete features
   - No broken builds allowed

3. **Clarity Over Cleverness**
   - Write obvious, maintainable code
   - Avoid complex patterns when simple works
   - Prioritize readability

4. **Test-Driven Quality**
   - Write tests for critical paths
   - Test edge cases and error conditions
   - Maintain >80% test coverage for core logic

5. **Progressive Enhancement**
   - Start with basic functionality
   - Add polish incrementally
   - Ensure core features work without enhancements

### Decision Making

- **YAGNI Principle**: Don't implement until needed
- **KISS Principle**: Keep solutions simple
- **DRY Principle**: Avoid duplication, but don't force abstraction
- **Boy Scout Rule**: Leave code cleaner than you found it

## 2. Architecture Rules

### Clean Architecture Enforcement

✅ **Layer Boundaries**
- Presentation → Domain → Data
- Never reverse dependencies
- Use dependency inversion

✅ **Presentation Layer**
- Contains only UI logic
- No business rules
- No direct data access

✅ **Domain Layer**
- Pure business logic
- No framework dependencies
- Entities and use cases only

✅ **Data Layer**
- Repository interfaces in domain
- Implementations in data layer
- No UI dependencies

### Dependency Rules

❌ **FORBIDDEN**
- Presentation layer importing data layer
- Domain layer knowing about UI
- Circular dependencies between layers
- Bypassing repository pattern

✅ **ALLOWED**
- Domain layer defining interfaces
- Data layer implementing interfaces
- Presentation layer depending on domain
- Clean dependency injection

### Riverpod Architecture

```dart
// ✅ CORRECT
// Domain layer
abstract class UserRepository {
  Future<User> getUser(String id);
}

// Data layer
class UserRepositoryImpl implements UserRepository {
  @override
  Future<User> getUser(String id) => _api.getUser(id);
}

// Presentation layer
final userRepositoryProvider = Provider<UserRepository>((ref) {
  return UserRepositoryImpl();
});
```

## 3. UI Rules

### Design System Compliance

📖 **Follow `docs/design_system.md` religiously**

❌ **NEVER HARDCODE**
- Colors (`AppColors.primary` only)
- Spacing (`AppSpacing.medium` only)
- Typography (`AppTypography.bodyLarge` only)
- Radius (`AppRadius.card` only)
- Animation durations (`AppMotion.standard` only)

### Widget Creation Rules

1. **Reuse First**
   - Use existing widgets (PrimaryButton, AppScaffold, etc.)
   - Extend before creating new
   - Document why new widget is needed

2. **Size Limits**
   - Widgets < 100 lines preferred
   - Maximum 150 lines
   - Split into smaller widgets if larger

3. **Responsibility**
   - One purpose per widget
   - Clear single responsibility
   - Avoid god widgets

### Screen Requirements

✅ **MANDATORY FOR EVERY SCREEN**
- [ ] Loading state (use `LoadingWidget`)
- [ ] Empty state (use `EmptyStateWidget`)
- [ ] Error state (use `ErrorStateWidget`)
- [ ] Success state (visual feedback)
- [ ] Dark mode support
- [ ] Responsive layout (mobile/tablet)
- [ ] Accessibility (contrast, labels, scaling)
- [ ] Proper navigation (back button, deep linking)

### Code Structure

```dart
// ✅ GOOD
class ServiceCard extends StatelessWidget {
  final Service service;
  final VoidCallback onBook;

  const ServiceCard({
    super.key,
    required this.service,
    required this.onBook,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Column(
        children: [
          ServiceImage(service: service),
          ServiceInfo(service: service),
          PrimaryButton(
            onPressed: onBook,
            child: Text('Book Now'),
          ),
        ],
      ),
    );
  }
}

// ❌ BAD - Too complex, mixed responsibilities
class ServiceCardBad extends StatelessWidget {
  // ... 200 lines of mixed logic
}
```

## 4. State Management Rules

### Riverpod Best Practices

✅ **DO**
- Keep providers focused (single responsibility)
- Separate UI state from business state
- Use appropriate provider types
- Document provider purpose

❌ **DON'T**
- Create global mutable state
- Mix UI and business logic
- Overuse StateNotifier
- Create unnecessary providers

### Provider Types Guide

| Use Case | Provider Type |
|----------|--------------|
| Configuration | `Provider` |
| Simple state | `StateProvider` |
| Complex state | `StateNotifierProvider` |
| Future data | `FutureProvider` |
| Stream data | `StreamProvider` |

### State Management Patterns

```dart
// ✅ CORRECT - Separated concerns
final userProfileProvider = FutureProvider<UserProfile>((ref) async {
  final repo = ref.watch(userRepositoryProvider);
  return repo.getUserProfile();
});

final userProfileUiStateProvider = StateNotifierProvider<UserProfileUiState, AsyncValue<UserProfile>>((ref) {
  return UserProfileUiState(ref.watch(userProfileProvider));
});

// ❌ BAD - Mixed concerns
final badUserProvider = StateNotifierProvider<BadUserNotifier, UserProfile?>((ref) {
  // Mixes UI and business logic
});
```

## 5. Navigation Rules

### GoRouter Standards

✅ **MUST FOLLOW**
- Centralized route configuration
- Type-safe navigation only
- No `Navigator.push` unless justified
- Deep linking support
- Error handling for invalid routes

### Route Organization

```dart
// ✅ CORRECT
class AppRouter {
  static final _rootNavigatorKey = GlobalKey<NavigatorState>();
  static final _shellNavigatorKey = GlobalKey<NavigatorState>();

  static final router = GoRouter(
    navigatorKey: _rootNavigatorKey,
    initialLocation: '/splash',
    routes: [
      GoRoute(
        path: '/splash',
        builder: (context, state) => const SplashPage(),
      ),
      ShellRoute(
        navigatorKey: _shellNavigatorKey,
        builder: (context, state, child) => AppScaffold(child: child),
        routes: [
          GoRoute(
            path: '/home',
            builder: (context, state) => const HomePage(),
          ),
          // ... other routes
        ],
      ),
    ],
    errorBuilder: (context, state) => ErrorPage(error: state.error),
  );
}

// ❌ BAD - Scattered navigation
class BadNavigation {
  static void navigate(BuildContext context, String route) {
    Navigator.push(context, MaterialPageRoute(builder: (context) => ...));
  }
}
```

### Navigation Best Practices

- **Use `context.go()`** for replacement navigation
- **Use `context.push()`** for stack navigation
- **Avoid deep nesting** (max 3 levels)
- **Handle errors** with custom error pages
- **Test all routes** with deep links

## 6. File Organization

### Responsibility Limits

| File Type | Max Lines | Max Responsibilities |
|-----------|-----------|---------------------|
| Widget | 150 | 1 |
| Screen | 200 | 1 (composition) |
| Provider | 80 | 1 |
| Repository | 100 | 1 |
| Service | 120 | 1 |
| Utility | 60 | 1 |

### Folder Structure Rules

```
features/
  service_booking/
    data/
      datasources/        # API, local storage
      dtos/              # Data transfer objects
      repositories/      # Repository implementations
    domain/
      entities/          # Business models
      repositories/      # Repository interfaces
      usecases/          # Business logic
    presentation/
      cubits/            # State management
      pages/             # Full screens
      widgets/           # Reusable components
      providers.dart     # Riverpod providers
```

### Naming Conventions

| Type | Pattern | Example |
|------|---------|---------|
| Widget | PascalCase + Widget | `ServiceCardWidget` |
| Screen | PascalCase + Page | `HomePage` |
| Provider | camelCase + Provider | `userProfileProvider` |
| Repository | PascalCase + Repository | `UserRepository` |
| Use Case | verb + noun | `GetUserProfile` |
| DTO | PascalCase + Dto | `UserProfileDto` |
| Entity | PascalCase | `UserProfile` |

### When to Split

**SPLIT WHEN:**
- Widget exceeds 150 lines
- Mixed responsibilities detected
- Reusable component identified
- Complex logic emerges
- Testing becomes difficult

**DON'T SPLIT WHEN:**
- Simple composition widget
- Single-purpose component
- Clear, focused responsibility
- Testing remains easy

## 7. Code Quality

### Flutter Best Practices

✅ **ALWAYS**
- Use `const` constructors
- Prefer `final` over `var`
- Use collection literals (`[]`, `{}`)
- Extract widget methods for complex builds
- Use `...` for list spreading

❌ **NEVER**
- Hardcode magic numbers
- Use `dynamic` type
- Create deep widget trees unnecessarily
- Ignore linter warnings
- Use `new` keyword

### Code Formatting

```dart
// ✅ GOOD
class ExampleWidget extends StatelessWidget {
  final String title;
  final VoidCallback onPressed;

  const ExampleWidget({
    super.key,
    required this.title,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      child: Text(title),
    );
  }
}

// ❌ BAD
class bad_example extends StatelessWidget {
  String title; VoidCallback onPressed;
  bad_example({Key? key, required this.title, required this.onPressed}) : super(key: key);
  @override Widget build(BuildContext context) => ElevatedButton(onPressed:onPressed,child:Text(title));
}
```

### Documentation Rules

**DOCUMENT WHEN:**
- Complex algorithms
- Non-obvious logic
- Public API methods
- Business rules
- Edge cases

**DON'T DOCUMENT:**
- Obvious getters/setters
- Simple widgets
- Standard patterns
- Self-explanatory code

```dart
/// ✅ GOOD - Complex logic documented
/// Calculates optimal ironing route using genetic algorithm.
/// Considers distance, traffic, and service windows.
/// O(n log n) complexity.
List<ServiceStop> calculateRoute(List<ServiceRequest> requests) {
  // Implementation...
}

/// ❌ BAD - Obvious documentation
/// Returns the user's name
String get name => _name;
```

## 8. Performance Rules

### Build Method Optimization

✅ **DO**
- Move heavy computation out of `build()`
- Use `const` widgets when possible
- Extract complex widgets to separate classes
- Use `ListView.builder` for long lists
- Cache expensive operations

❌ **DON'T**
- Perform I/O in `build()`
- Create objects in `build()` unnecessarily
- Use `Column` with many children (use `ListView`)
- Rebuild entire tree for small changes
- Ignore performance warnings

### Animation Performance

✅ **60 FPS REQUIREMENTS**
- Use `RepaintBoundary` for complex widgets
- Avoid `Opacity` animations on large widgets
- Use `Transform` instead of layout changes
- Test on low-end devices
- Profile with Flutter DevTools

```dart
// ✅ GOOD - Optimized animation
AnimatedBuilder(
  animation: _controller,
  builder: (context, child) {
    return Transform.translate(
      offset: Offset(0, _controller.value * 100),
      child: child,
    );
  },
  child: const HeavyWidget(), // Cached
)

// ❌ BAD - Expensive animation
Opacity(
  opacity: _controller.value,
  child: const ComplexWidgetTree(), // Rebuilds entire tree
)
```

### Memory Management

- **Dispose controllers** in `dispose()`
- **Cancel streams** when no longer needed
- **Clear caches** appropriately
- **Avoid memory leaks** in long-lived objects
- **Test with memory profiling**

## 9. Testing Rules

### Testing Workflow

1. **Write Tests First** (when possible)
2. **Implement Feature**
3. **Run `dart format`**
4. **Run `flutter analyze`**
5. **Run `flutter test`**
6. **Fix All Issues**

### Test Requirements

✅ **MANDATORY**
- No analyzer warnings (`flutter analyze`)
- No formatter issues (`dart format`)
- All existing tests pass
- New tests for new functionality
- Edge case coverage

### Test Types

| Type | When to Use | Example |
|------|-------------|---------|
| Unit | Pure functions, utilities | `calculatePrice()` |
| Widget | Single widgets | `ServiceCard` tests |
| Integration | User flows | Login → Home navigation |
| Golden | Visual regression | Screenshot comparisons |

### Test Structure

```dart
// ✅ GOOD TEST
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

// ❌ BAD TEST
testWidgets('service card test', (tester) async {
  // Vague, untyped, no structure
  await tester.pumpWidget(ServiceCard(service: someService));
  await tester.tap(find.byType(ElevatedButton));
});
```

## 10. Mock Data Rules

### Mock Data Principles

✅ **DO**
- Keep mock data separate from UI
- Create dedicated mock classes
- Mimic real API structure
- Simulate network delays
- Handle edge cases

❌ **DON'T**
- Hardcode values in widgets
- Create fake API calls in presentation
- Mix mock and real data
- Ignore error states

### Mock Implementation

```dart
// ✅ CORRECT
// lib/core/mock/mock_services.dart
class MockServiceService {
  static Future<List<Service>> getServices() async {
    await Future.delayed(const Duration(milliseconds: 500)); // Simulate network
    return [
      Service(id: '1', name: 'Shirt Ironing', price: 299),
      Service(id: '2', name: 'Pants Ironing', price: 399),
    ];
  }
}

// lib/features/home/presentation/home_page.dart
class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<Service>>(
      future: MockServiceService.getServices(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const LoadingWidget();
        }
        if (snapshot.hasError) {
          return ErrorStateWidget(
            message: 'Failed to load services',
            onRetry: () => context.refresh(homePageProvider),
          );
        }
        return ServiceList(services: snapshot.data!);
      },
    );
  }
}

// ❌ BAD - Mixed concerns
class BadHomePage extends StatelessWidget {
  final services = [ // Hardcoded in UI
    {'name': 'Shirt', 'price': 299},
    {'name': 'Pants', 'price': 399},
  ];

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: services.length,
      itemBuilder: (context, index) => ListTile(
        title: Text(services[index]['name'] as String),
      ),
    );
  }
}
```

## 11. Git Rules

### Commit Standards

✅ **GOOD COMMITS**
- Small, focused changes
- Clear, descriptive messages
- Follow convention: `type(scope): description`
- One feature per commit
- No mixing refactoring with features

❌ **BAD COMMITS**
- "Fixed bugs"
- "WIP"
- "Various changes"
- Mixing multiple features
- Breaking existing functionality

### Commit Message Format

```
feat(auth): implement login screen
- Add login form with email/password fields
- Implement validation
- Add navigation to home screen
- Include loading and error states

Refs: IR-123
```

### Branch Strategy

- **Main**: Always deployable
- **Feature**: `feature/IR-123-login-screen`
- **Bugfix**: `bugfix/IR-456-crash-fix`
- **Release**: `release/v1.2.0`

### Pull Request Rules

✅ **REQUIRED**
- Linked to Jira ticket
- Clear description of changes
- Screenshots for UI changes
- Passing CI checks
- At least one approval
- No merge conflicts

## 12. Package Rules

### Package Introduction Process

1. **Justify Need** - Why existing solutions don't work
2. **Evaluate Options** - Compare 2-3 alternatives
3. **Check Maintenance** - Last commit, issue response time
4. **Bundle Impact** - Size increase, method count
5. **Team Approval** - Architecture review

### Package Evaluation Checklist

| Criteria | Requirement |
|----------|-------------|
| Maintenance | Active development, recent commits |
| Community | >100 stars, good issue response |
| Documentation | Complete, clear examples |
| Testing | Comprehensive test coverage |
| Compatibility | Flutter stable channel support |
| License | MIT, BSD, or Apache 2.0 |
| Size | <500KB impact |

### Approved Packages

| Category | Package | Purpose |
|----------|---------|---------|
| State | flutter_riverpod | State management |
| Navigation | go_router | Routing |
| Network | dio | HTTP client |
| Logging | logger | Logging |
| Environment | flutter_dotenv | Environment variables |
| Testing | mockito | Mocking |
| Testing | golden_toolkit | Golden tests |

### Adding New Packages

```yaml
# ✅ GOOD - Justified addition
# Added for image caching to improve performance
# Evaluated alternatives: cached_network_image, flutter_cache_manager
# Chosen for better memory management and simpler API
dependencies:
  cached_network_image: ^3.3.0
```

## 13. ACT MODE Rules

### Implementation Discipline

🛑 **STOP AND ASK IF:**
- Story scope is unclear
- Architecture changes needed
- Breaking existing functionality
- Unsure about approach
- Estimated time exceeds 4 hours

✅ **FOLLOW ALWAYS:**
- Implement only requested story
- Don't build future stories
- Don't refactor unrelated code
- Don't modify architecture
- Don't add "nice to have" features

### Story Implementation Checklist

1. [ ] Understand requirements completely
2. [ ] Check existing codebase
3. [ ] Follow design system
4. [ ] Implement minimal viable solution
5. [ ] Add proper error handling
6. [ ] Implement all required states
7. [ ] Write necessary tests
8. [ ] Run formatter and analyzer
9. [ ] Test manually
10. [ ] Request review

### Common Pitfalls

❌ **SCOPE CREEP**
- "While I'm here, I'll also..."
- Adding unrelated features
- Over-engineering simple requirements

❌ **ARCHITECTURE VIOLATIONS**
- Bypassing repository pattern
- Mixing layers
- Creating circular dependencies

❌ **QUALITY SHORTCUTS**
- Skipping tests
- Ignoring linter warnings
- Hardcoding values
- Not implementing error states

## 14. Definition of Done

### Story Completion Checklist

✅ **FUNCTIONAL**
- [ ] Feature works as specified
- [ ] All user flows covered
- [ ] Edge cases handled
- [ ] Error conditions managed
- [ ] Loading states implemented

✅ **UI/UX**
- [ ] Follows design system exactly
- [ ] Responsive (mobile/tablet)
- [ ] Dark mode support
- [ ] Accessibility compliant
- [ ] Animations smooth (60fps)
- [ ] All states implemented (loading, empty, error)

✅ **CODE QUALITY**
- [ ] No analyzer warnings (`flutter analyze`)
- [ ] No formatter issues (`dart format`)
- [ ] Follows naming conventions
- [ ] Proper file organization
- [ ] No duplicated code
- [ ] Meaningful names
- [ ] Small methods/widgets

✅ **TESTING**
- [ ] All existing tests pass
- [ ] New tests for new functionality
- [ ] Edge cases covered
- [ ] Widget tests for UI components
- [ ] Integration tests for flows

✅ **PERFORMANCE**
- [ ] No jank in animations
- [ ] Smooth scrolling
- [ ] Efficient builds
- [ ] No memory leaks
- [ ] Optimized images

✅ **DOCUMENTATION**
- [ ] Complex logic documented
- [ ] Public APIs documented
- [ ] README updated if needed
- [ ] CHANGELOG updated if needed

### Final Verification

```bash
# Run before every PR
flutter format .
flutter analyze
flutter test
git add .
git commit -m "feat: implement feature per IR-123"
git push
```

## Engineering Excellence

### Continuous Improvement

1. **Code Reviews** - Every PR gets reviewed
2. **Retrospectives** - After every sprint
3. **Tech Debt Tracking** - Maintain backlog
4. **Performance Monitoring** - Profile regularly
5. **Documentation Updates** - Keep docs current

### Metrics

| Metric | Target |
|--------|--------|
| Test Coverage | >80% |
| Build Success | 100% |
| Analyzer Warnings | 0 |
| PR Review Time | <24 hours |
| Merge Time | <48 hours |

### Culture

**We Value:**
- Working software over documentation
- Collaboration over heroics
- Quality over speed
- Learning over blame
- Users over internal preferences

**We Don't Tolerate:**
- Broken builds
- Undocumented breaking changes
- Ignored code reviews
- Scope creep without discussion
- Technical debt accumulation

---

**This handbook is living document. Update as project evolves.**
**Last Updated: July 27, 2026**
**Version: 1.0**