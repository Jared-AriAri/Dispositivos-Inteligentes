import 'package:flutter/material.dart';

class WeatherIcon extends StatelessWidget {
  final String condition;

  const WeatherIcon({super.key, required this.condition});

  @override
  Widget build(BuildContext context) {
    return Icon(
      condition == 'sunny' ? Icons.wb_sunny : Icons.cloud,
      size: 80,
      color: Colors.blue,
    );
  }
}
