import 'package:clisence/screens/auth/form_details_screen.dart';
import 'package:clisence/screens/auth/sign_in_screen.dart';
import 'package:clisence/screens/auth/sign_up_screen.dart';
import 'package:clisence/screens/forecast_screen.dart';
import 'package:clisence/screens/home_screen.dart';
import 'package:clisence/utils/app_theme.dart'; // Import AppTheme
import 'package:clisence/screens/onboarding_screen.dart';
import 'package:clisence/screens/splash_screen.dart';
import 'package:clisence/providers/auth_provider.dart';
import 'package:clisence/providers/data_provider.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:forui/forui.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

// Initialize Firebase
Future<void> initializeApp() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
}

// Define a class to manage routes centrally
class AppRoutes {
  static const String splash = '/';
  static const String onboarding = '/onboarding';
  static const String signup = '/signup';
  static const String signin = '/signin';
  static const String formdetails = '/formdetails';
  static const String onboardingWelcome = '/onboarding/welcome';
  static const String onboardingPermissions = '/onboarding/permissions';
  static const String onboardingEmpowerment = '/onboarding/empowerment';
  static const String home = '/home';
  static const String forecast = '/forecast';

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
      GoRoute(
        path: signin,
        builder: (context, state) => const SignInScreen(),
      ),
      GoRoute(
        path: formdetails,
        builder: (context, state) => const FormDetailsScreen(),
      ),
      GoRoute(
        path: home,
        builder: (context, state) => const HomeScreen(),
      ),
      GoRoute(path:forecast, builder: (context, state) => const ForecastScreen()),

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

void main() async {
  await initializeApp();
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => AuthProvider()),
        ChangeNotifierProvider(create: (_) => DataProvider()),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    // Initialize auth provider
    final authProvider = Provider.of<AuthProvider>(context, listen: false);
    authProvider.initialize();

    return MaterialApp.router(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.green,
        colorScheme: ColorScheme.light(
          primary: AppTheme.primaryColor,
          secondary: AppTheme.secondaryColor,
        ),
        useMaterial3: true,
      ),
      // Configure go_router
      routerConfig: AppRoutes.router,
    );
  }
}
