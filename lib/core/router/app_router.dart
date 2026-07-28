// App router configuration
import 'package:go_router/go_router.dart';
import 'package:flutter/material.dart';

import '../../features/splash/presentation/pages/splash_page.dart';
import '../../features/onboarding/presentation/pages/onboarding_page.dart';
import '../../features/welcome/presentation/pages/welcome_page.dart';
import '../../features/auth/presentation/pages/login_page.dart';
import '../../features/auth/presentation/pages/register_page.dart';
import '../../features/auth/presentation/pages/forgot_password_page.dart';
import '../../features/placeholder/presentation/pages/placeholder_page.dart';
import '../../features/home/presentation/pages/home_page.dart';
import '../../features/services/presentation/pages/services_page.dart';
import '../../features/services/presentation/pages/service_detail_page.dart';
import '../../features/bookings/presentation/pages/booking_entry_page.dart';
import '../../features/bookings/presentation/pages/booking_summary_page.dart';
import '../../features/bookings/presentation/pages/booking_success_page.dart';
import '../../features/bookings/presentation/pages/bookings_page.dart';
import '../../features/home/domain/models/service.dart';

class AppRouter {
  static final GoRouter router = GoRouter(
    routes: <RouteBase>[
      GoRoute(
        path: '/',
        builder: (BuildContext context, GoRouterState state) {
          return const SplashPage();
        },
      ),
      GoRoute(
        path: '/onboarding',
        builder: (BuildContext context, GoRouterState state) {
          return const OnboardingPage();
        },
      ),
      GoRoute(
        path: '/welcome',
        builder: (BuildContext context, GoRouterState state) {
          return const WelcomePage();
        },
      ),
      GoRoute(
        path: '/login',
        builder: (BuildContext context, GoRouterState state) {
          return const LoginPage();
        },
      ),
      GoRoute(
        path: '/register',
        builder: (BuildContext context, GoRouterState state) {
          return const RegisterPage();
        },
      ),
      GoRoute(
        path: '/forgot-password',
        builder: (BuildContext context, GoRouterState state) {
          return const ForgotPasswordPage();
        },
      ),
      GoRoute(
        path: '/dashboard-placeholder',
        builder: (BuildContext context, GoRouterState state) {
          return const PlaceholderPage(
            title: 'Dashboard Placeholder',
            description:
                'This screen represents the authenticated user dashboard. Will be implemented in future sprints.',
            routeName: 'Dashboard',
          );
        },
      ),
      GoRoute(
        path: '/placeholder',
        builder: (BuildContext context, GoRouterState state) {
          return const PlaceholderPage(
            title: 'Login Placeholder',
            description:
                'This screen will be replaced with the actual login functionality in a future sprint.',
            routeName: 'Login',
          );
        },
      ),
      GoRoute(
        path: '/guest-placeholder',
        builder: (BuildContext context, GoRouterState state) {
          return const PlaceholderPage(
            title: 'Guest Mode Placeholder',
            description:
                'This screen will be replaced with the actual guest user flow in a future sprint.',
            routeName: 'Guest Mode',
          );
        },
      ),
      GoRoute(
        path: '/home',
        builder: (BuildContext context, GoRouterState state) {
          return const HomePage();
        },
      ),
      GoRoute(
        path: '/services',
        builder: (BuildContext context, GoRouterState state) {
          return const ServicesPage();
        },
      ),
      GoRoute(
        path: '/service/:id',
        builder: (BuildContext context, GoRouterState state) {
          // Extract the service ID from the path
          final String fullPath = state.uri.path;
          final String serviceId = fullPath.split('/').last;
          return ServiceDetailPage(serviceId: serviceId);
        },
      ),
      GoRoute(
        path: '/booking-entry',
        builder: (BuildContext context, GoRouterState state) {
          // Extract service data from state
          final Service service = state.extra as Service;
          return BookingEntryPage(service: service);
        },
      ),
      GoRoute(
        path: '/booking-summary',
        builder: (BuildContext context, GoRouterState state) {
          return const BookingSummaryPage();
        },
      ),
      GoRoute(
        path: '/booking-success',
        builder: (BuildContext context, GoRouterState state) {
          return const BookingSuccessPage();
        },
      ),
      GoRoute(
        path: '/bookings',
        builder: (BuildContext context, GoRouterState state) {
          return const BookingsPage();
        },
      ),
    ],
  );
}
