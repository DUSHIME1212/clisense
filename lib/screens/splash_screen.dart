import 'package:clisence/main.dart';
import 'package:flutter/material.dart';
import 'package:forui/forui.dart';
import 'package:go_router/go_router.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  void pushOnboarding(BuildContext context) {
    context.go(
      AppRoutes.onboarding
    );
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Container(
          color: Colors.green[800],
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Spacer(),
                  Image.asset(
                    'assets/images/logo.png',
                    width: 200,
                    height: 200,
                  ),
                  Spacer(),
                  //button
                  Container(
                    width: double.infinity,
                    child: FButton(
                      style: FButtonStyle.secondary,
                      intrinsicWidth: true,
                      onPress: () => pushOnboarding(context),
                      child: const Text('Get started'),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
