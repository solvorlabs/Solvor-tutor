import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../modules/home/presentation/home_screen.dart';
import '../../modules/onboarding/presentation/onboarding_screen.dart';
import '../auth/auth_state.dart';

final _rootNavigatorKey = GlobalKey<NavigatorState>();

final routerProvider = Provider<GoRouter>((ref) {
  final authState = ref.watch(authStateProvider);

  return GoRouter(
    navigatorKey: _rootNavigatorKey,
    initialLocation: '/onboarding',
    redirect: (context, state) {
      if (authState.isLoading) return null;

      final isOnOnboarding = state.matchedLocation == '/onboarding';

      if (authState.isLoggedIn && isOnOnboarding) return '/home';
      if (!authState.isLoggedIn && !isOnOnboarding) return '/onboarding';
      return null;
    },
    routes: [
      GoRoute(
        path: '/onboarding',
        name: 'onboarding',
        builder: (context, state) => const OnboardingScreen(),
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
});
