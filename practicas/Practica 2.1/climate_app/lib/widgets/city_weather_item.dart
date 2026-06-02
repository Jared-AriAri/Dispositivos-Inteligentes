import 'package:flutter/material.dart';

class CityWeatherItem extends StatelessWidget {
  final String city;
  final String temperature;
  final VoidCallback onTap;

  const CityWeatherItem({
    Key? key,
    required this.city,
    required this.temperature,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(city),
      subtitle: Text(temperature),
      onTap: onTap,
    );
  }
}
