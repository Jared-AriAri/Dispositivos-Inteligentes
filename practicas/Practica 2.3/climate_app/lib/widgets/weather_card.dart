import 'package:flutter/material.dart';
import 'weather_icon.dart';

class WeatherCard extends StatelessWidget {
  final String temperature;
  final String city;
  final String condition;
  final String humidity;
  final String wind;

  const WeatherCard({
    Key? key,
    required this.temperature,
    required this.city,
    required this.condition,
    required this.humidity,
    required this.wind,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 4,
      child: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              temperature,
              style: const TextStyle(
                fontSize: 72,
                fontWeight: FontWeight.bold,
                color: Colors.blue,
              ),
            ),
            const SizedBox(height: 16),
            Text(
              city,
              textAlign: TextAlign.center,
              style: const TextStyle(fontSize: 24),
            ),
            const SizedBox(height: 32),
            WeatherIcon(condition: condition),
            const SizedBox(height: 32),
            Text(
              'Humedad: $humidity | Viento: $wind',
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}
