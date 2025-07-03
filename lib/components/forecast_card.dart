// forecast_card.dart
import 'package:flutter/material.dart';

class ForecastCard extends StatelessWidget {
  final String title;
  final IconData icon;
  final String description;
  final String temperature;
  final String windSpeed;
  final String image;

  const ForecastCard({
    required this.title,
    required this.icon,
    required this.description,
    required this.temperature,
    required this.windSpeed,
    required this.image,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Icon(icon, size: 32),
            const SizedBox(height: 4),
            Text(description),
            Text(temperature),
            Text(windSpeed),
          ],
        ),
        const SizedBox(width: 16),
        Container(
          width: 100,
          height: 100,
          decoration: BoxDecoration(
            borderRadius: const BorderRadius.all(Radius.circular(10)),
            image: DecorationImage(
              image: NetworkImage(image),
              fit: BoxFit.cover,
            ),
          ),
        ),
      ],
    );
  }
}