// App router configuration
import 'package:go_router/go_router.dart';
import 'package:flutter/material.dart';

import '../../features/splash/presentation/pages/splash_page.dart';
import '../../features/welcome/presentation/pages/welcome_page.dart';
import '../../features/placeholder/presentation/pages/placeholder_page.dart';
import '../../features/home/presentation/pages/home_page.dart';

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
        path: '/welcome',
        builder: (BuildContext context, GoRouterState state) {
          return const WelcomePage();
        },
      ),
      GoRoute(
        path: '/placeholder',
        builder: (BuildContext context, GoRouterState state) {
          return PlaceholderPage(
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
          return PlaceholderPage(
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
    ],
  );
}
