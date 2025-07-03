import 'package:flutter/material.dart';

class AlertCard extends StatelessWidget {
  final String? title;
  final String? description;
  final String? image;

  const AlertCard({
    this.title,
    this.description,
    this.image,
    super.key
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          width: 100,
          height: 100,
          decoration: BoxDecoration(
            borderRadius: const BorderRadius.all(Radius.circular(10)),
            image: DecorationImage(
              image: NetworkImage(image!),
              fit: BoxFit.cover,
            ),
          ),
        ),
        const SizedBox(width: 16),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(title!),
              const SizedBox(height: 4),
              Text(description!),
            ],
          ),
        ),
      ],

    );
  }
}
