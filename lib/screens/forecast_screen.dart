import 'package:flutter/material.dart';

import '../components/forecast_card.dart';
import '../components/ui_components.dart';

class ForecastScreen extends StatelessWidget {
  const ForecastScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: UIComponents.appBar(context, 'HYPERICAL FORECAST'),
      body: SingleChildScrollView(
        child: Column(
          children: [
            //image

            // daily forecast(today, tomorrow, next week)
            UIComponents.card(context, 'Daily Forecast', Column(children: [])),
          ],
        ),
      ),
    );
  }
}
