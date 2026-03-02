import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:nicestore/features/onboarding/presentation/pages/onboarding_screen.dart';

/// Application routes
class AppRoutes {
  // Auth
  // static const String splash = '/';
  static const String onboarding = '/onboarding';
  static const String login = '/login';
  static const String verifyOtp = '/verify-otp';

  // Main Tabs
  static const String home = '/home';
  static const String product_details = '/product_details';
}

/// Router provider for dependency injection
final routerProvider = Provider<GoRouter>((ref) {
  // Watch auth state to make router reactive to changes
  // final authState = ref.watch(authViewModelProvider);

  return GoRouter(
    initialLocation: AppRoutes.onboarding,
    debugLogDiagnostics: true,
    redirect: (context, state) => _handleRedirect(ref, state),
    routes: [
      // Main Tabs
      GoRoute(
        path: AppRoutes.onboarding,
        name: 'onboarding',
        builder: (context, state) => const OnboardingScreen(),
      ),
      // Login Tabs

      // Main Tabs
      // GoRoute(
      //   path: AppRoutes.verifyOtp,
      //   name: 'verify-otp',
      //   builder: (context, state) => const OtpScreen(),
      // ),
      // Main Tabs
      // GoRoute(
      //   path: AppRoutes.home,
      //   name: 'home',
      //   builder: (context, state) => const HomeScreen(),
      // ),
    ],
    errorBuilder: (context, state) => Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(Icons.error_outline, size: 64, color: Colors.red),
            const SizedBox(height: 16),
            Text(
              'Page not found',
              style: Theme.of(context).textTheme.headlineSmall,
            ),
            const SizedBox(height: 8),
            Text(
              'The page you are looking for does not exist.',
              style: Theme.of(context).textTheme.bodyMedium,
            ),
            const SizedBox(height: 24),
            ElevatedButton(
              onPressed: () => context.go(AppRoutes.home),
              child: const Text('Go Home'),
            ),
          ],
        ),
      ),
    ),
  );
});

/// Navigation extensions for easier usage
/// /// Navigation extensions for easier usage with go_router
extension AppNavigation on BuildContext {
  /* =======================
   * ROOT / REPLACE ROUTES
   * ======================= */

  // Main roots
  void goToHome() => go(AppRoutes.home);
  // Visits
  void pushproductDetails(String productId) =>
      push('/product_details/$productId');

  /* =======================
   * BACK / POP
   * ======================= */

  void goBack<T extends Object?>([T? result]) => pop<T>(result);

  /* =======================
   * UTILITIES
   * ======================= */

  bool isCurrentRoute(String routeName) =>
      GoRouterState.of(this).matchedLocation == routeName;
}

/// Handle navigation redirects based on app state
String? _handleRedirect(Ref ref, GoRouterState state) {
  // final authState = ref.read(authViewModelProvider);
  final currentLocation = state.matchedLocation;

  // Skip auth check for public routes
  // if (_isPublicRoute(currentLocation)) {
  //   return null; // Allow access to public routes
  // }

  // If user is not authenticated, redirect to login
  // if (!authState.isAuthenticated) {
  //  // return AppRoutes.login;
  //    return AppRoutes.home;
  // }

  return null; // Allow access to all other routes if authenticated
}

// bool _isPublicRoute(String? location) {
//   if (location == null) return false;
  
//   final publicRoutes = [

//     AppRoutes.onboarding, 
//     AppRoutes.login, 
//     AppRoutes.home,   // Consider if home should be public or not
//     AppRoutes.productsDetailsScreen,  
//   ];
  
//   return publicRoutes.any((route) => location.startsWith(route));
// }