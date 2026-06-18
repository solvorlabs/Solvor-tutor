import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../modules/home/presentation/home_screen.dart';

final _rootNavigatorKey = GlobalKey<NavigatorState>();

class AppRouter {
  AppRouter._();

  static final GoRouter router = GoRouter(
    navigatorKey: _rootNavigatorKey,
    initialLocation: '/home',
    routes: [
      GoRoute(
        path: '/onboarding',
        name: 'onboarding',
        builder: (context, state) => const Scaffold(
          body: Center(child: Text('Onboarding Screen')),
        ),
      ),
      GoRoute(
        path: '/home',
        name: 'home',
        builder: (context, state) => const HomeScreen(),
      ),
      GoRoute(
        path: '/diagnostic',
        name: 'diagnostic',
        builder: (context, state) => const Scaffold(
          body: Center(child: Text('Diagnostic Screen')),
        ),
      ),
      GoRoute(
        path: '/test/:testId',
        name: 'test',
        builder: (context, state) {
          final testId = state.pathParameters['testId'] ?? '';
          return Scaffold(
            body: Center(child: Text('Test Screen: $testId')),
          );
        },
      ),
      GoRoute(
        path: '/review/:attemptId',
        name: 'review',
        builder: (context, state) {
          final attemptId = state.pathParameters['attemptId'] ?? '';
          return Scaffold(
            body: Center(child: Text('Review Screen: $attemptId')),
          );
        },
      ),
      GoRoute(
        path: '/error-notebook',
        name: 'error-notebook',
        builder: (context, state) => const Scaffold(
          body: Center(child: Text('Error Notebook Screen')),
        ),
      ),
      GoRoute(
        path: '/ai-tutor',
        name: 'ai-tutor',
        builder: (context, state) => const Scaffold(
          body: Center(child: Text('AI Tutor Screen')),
        ),
      ),
    ],
  );
}
