import 'package:clisence/screens/auth/sign_up_screen.dart';
import 'package:clisence/screens/onboarding_screen.dart';
import 'package:clisence/screens/splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:forui/forui.dart';
import 'package:go_router/go_router.dart';

// Define a class to manage routes centrally
class AppRoutes {
  static const String splash = '/';
  static const String onboarding = '/onboarding';
  static const String signup = '/signup';
  static const String signin = '/signin';
  static const String onboardingWelcome = '/onboarding/welcome';
  static const String onboardingPermissions = '/onboarding/permissions';
  static const String onboardingEmpowerment = '/onboarding/empowerment';

  static final GoRouter router = GoRouter(
    initialLocation: splash,
    routes: [
      GoRoute(
        path: splash,
        builder: (context, state) => const SplashScreen(),
      ),
      GoRoute(
        path: onboarding,
        builder: (context, state) => const OnboardingScreen(),
      ),
      GoRoute(
        path: signup,
        builder: (context, state) => const SignupScreen(),
      ),
    ],
    // Optional: Handle redirects (e.g., for authentication)
    redirect: (context, state) {
      // Example: Redirect logic for unauthenticated users
      // bool isAuthenticated = checkAuthState();
      // if (!isAuthenticated && state.location != splash) return splash;
      return null;
    },
  );
}

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      debugShowCheckedModeBanner: false,
      // Integrate forui theme
      builder: (context, child) => FTheme(
        data: FThemes.zinc.light,
        child: child!,
      ),
      // Configure go_router
      routerConfig: AppRoutes.router,
    );
  }
}
