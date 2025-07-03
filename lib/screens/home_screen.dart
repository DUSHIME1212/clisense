// home_screen.dart
import 'package:clisence/components/alert_card.dart';
import 'package:clisence/main.dart';
import 'package:flutter/material.dart';
import 'package:forui/forui.dart';
import 'package:go_router/go_router.dart';

import '../components/ui_components.dart' show UIComponents;
import '../components/forecast_card.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // Sample forecast data
    final List<Map<String, dynamic>> forecasts = [
      {
        'title': 'Morning',
        'icon': Icons.wb_sunny,
        'description': 'Sunny',
        'temperature': '22°C - 28°C',
        'windSpeed': 'Wind: 10 km/h',
        'image': 'https://i.pinimg.com/736x/8b/55/59/8b5559aa155c458f774bccfade3c4782.jpg',
      },
      {
        'title': 'Afternoon',
        'icon': Icons.cloud,
        'description': 'Partly Cloudy',
        'temperature': '25°C - 30°C',
        'windSpeed': 'Wind: 12 km/h',
        'image': 'https://i.pinimg.com/736x/8b/55/59/8b5559aa155c458f774bccfade3c4782.jpg',
      },
      {
        'title': 'Evening',
        'icon': Icons.wb_cloudy,
        'description': 'Cloudy',
        'temperature': '20°C - 25°C',
        'windSpeed': 'Wind: 8 km/h',
        'image': 'https://i.pinimg.com/736x/8b/55/59/8b5559aa155c458f774bccfade3c4782.jpg',
      },
      {
        'title': 'Night',
        'icon': Icons.nightlight_round,
        'description': 'Clear',
        'temperature': '18°C - 22°C',
        'windSpeed': 'Wind: 5 km/h',
        'image': 'https://i.pinimg.com/736x/8b/55/59/8b5559aa155c458f774bccfade3c4782.jpg',
      },
    ];

    return Scaffold(
      appBar: UIComponents.appBar(context, 'Clisense'),
      body: SingleChildScrollView(
        child: Container(
          color: FThemes.zinc.light.colors.background,
          margin: const EdgeInsets.only(bottom: 16.0),
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              children: [
                //forecast
                TextButton(
                  onPressed: () {
                    context.go(AppRoutes.forecast);
                  },
                  child: UIComponents.card(
                    context,
                    "Forecast",
                    SizedBox(
                      height: 300, // Increased height to accommodate all items
                      child: ListView.builder(
                        shrinkWrap: true,
                        itemCount: forecasts.length,
                        itemBuilder: (context, index) {
                          final forecast = forecasts[index];
                          return Padding(
                            padding: const EdgeInsets.symmetric(vertical: 8.0),
                            child: ForecastCard(
                              title: forecast['title'],
                              icon: forecast['icon'],
                              description: forecast['description'],
                              temperature: forecast['temperature'],
                              windSpeed: forecast['windSpeed'],
                              image: forecast['image'],
                            ),
                          );
                        },
                      ),
                    ),
                  ),
                ),
                //alerts
                UIComponents.card(
                  context,
                  "Alerts",
                  SizedBox(
                    height: 100,
                    child: ListView.builder(
                      shrinkWrap: true,
                      itemCount: 4,
                      itemBuilder: (context, index) {
                        return const Padding(
                          padding: const EdgeInsets.symmetric(vertical: 8.0),
                          child: AlertCard(
                            image: 'https://i.pinimg.com/736x/8b/55/59/8b5559aa155c458f774bccfade3c4782.jpg',
                            title: 'Alert Title',
                            description: 'Description of the alert',
                          ),
                        );
                      },
        
                    )
                  ),
                ),
                // buttons
                Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    UIComponents.primaryButton(context, 'Get forecast', () {}),
                    UIComponents.secondaryButton(context, 'Check alerts', () {}),
                    UIComponents.secondaryButton(context, 'Crop advice', () {}),
                    UIComponents.secondaryButton(context, 'Help and support', () {}),
                  ],
                )],
            ),
          ),
        ),
      ),
    );
  }
}