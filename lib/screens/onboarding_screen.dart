import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:clisence/main.dart'; // Import AppRoutes

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({super.key});

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  final PageController _pageController = PageController();
  int _currentPage = 0;

  // Onboarding content data with "GO" for the last slide
  final List<Map<String, dynamic>> _onboardingData = [
    {
      'imagePath': 'https://i.pinimg.com/736x/fd/bf/93/fdbf9345a5b9ed5fb2eb3a5c1a25e82e.jpg',
      'title': 'WELCOME TO CLISENSE',
      'description':
      'Hyperlocal data for better harvests. Get climate-smart insights for your farm. We provide hyperlocal forecasts, early alerts, and crop-specific advice to help you thrive.',
      'buttonText': 'NEXT',
    },
    {
      'imagePath': 'https://i.pinimg.com/736x/fd/bf/93/fdbf9345a5b9ed5fb2eb3a5c1a25e82e.jpg',
      'title': 'PERMISSIONS & CONSENT',
      'description':
      'To serve you better, Clisense will collect your location and farm details. We use this data only to deliver climate forecasts and farming advice tailored to your needs.',
      'buttonText': 'GO',
    },
    {
      'imagePath': 'https://i.pinimg.com/736x/fd/bf/93/fdbf9345a5b9ed5fb2eb3a5c1a25e82e.jpg',
      'title': 'EMPOWERING FARMERS WITH CLIMATE-SMART INSIGHTS',
      'description':
      'Hyperlocal data for better harvests. Get climate-smart insights for your farm. We provide hyperlocal forecasts, early alerts, and crop-specific advice to help you thrive.',
      'buttonText': 'GO', // Remains "GO" for the last slide
    },
  ];

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        fit: StackFit.expand,
        children: [
          // PageView for onboarding slides
          PageView.builder(
            controller: _pageController,
            onPageChanged: (index) {
              setState(() {
                _currentPage = index;
              });
            },
            itemCount: _onboardingData.length,
            itemBuilder: (context, index) {
              final data = _onboardingData[index];
              return Stack(
                fit: StackFit.expand,
                children: [
                  // Background image
                  Image.network(
                    data['imagePath'],
                    fit: BoxFit.cover,
                    height: double.infinity,
                    width: double.infinity,
                    alignment: Alignment.center,
                  ),
                  // Overlay content
                  Container(
                    color: Colors.black.withOpacity(0.5), // Semi-transparent overlay
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Spacer(flex: 2),
                        // Title
                        Text(
                          data['title'],
                          textAlign: TextAlign.center,
                          style: const TextStyle(
                            fontSize: 28,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                        const SizedBox(height: 16),
                        // Description
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 24.0),
                          child: Text(
                            data['description'],
                            textAlign: TextAlign.center,
                            style: const TextStyle(
                              fontSize: 16,
                              color: Colors.white,
                            ),
                          ),
                        ),
                        const Spacer(),
                        // Button
                        Padding(
                          padding: const EdgeInsets.only(bottom: 40.0),
                          child: GestureDetector(
                            onTap: () {
                              if (_currentPage == _onboardingData.length - 1) {
                                context.go(AppRoutes.signup); // Navigate to SignupScreen on last page
                              } else {
                                _pageController.nextPage(
                                  duration: const Duration(milliseconds: 300),
                                  curve: Curves.easeInOut,
                                );
                              }
                            },
                            child: Container(
                              width: 60,
                              height: 60,
                              decoration: const BoxDecoration(
                                color: Colors.green,
                                shape: BoxShape.circle,
                                gradient: LinearGradient(
                                  colors: [Colors.green, Color(0xFF2E7D32)],
                                  begin: Alignment.topCenter,
                                  end: Alignment.bottomCenter,
                                ),
                              ),
                              child: const Icon(
                                Icons.arrow_forward,
                                color: Colors.white,
                                size: 24,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              );
            },
          ),
          // Dot indicator
          if (_currentPage < _onboardingData.length - 1)
            Positioned(
              bottom: 100,
              left: 0,
              right: 0,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: List.generate(_onboardingData.length, (index) {
                  return Container(
                    margin: const EdgeInsets.symmetric(horizontal: 4),
                    width: 8,
                    height: 8,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: _currentPage == index ? Colors.white : Colors.grey,
                    ),
                  );
                }),
              ),
            ),
        ],
      ),
    );
  }
}