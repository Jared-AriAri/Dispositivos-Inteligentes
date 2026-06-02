import 'package:flutter/material.dart';
import '../widgets/weather_icon.dart';
import 'search_screen.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final isWide = width > 600;

    final weatherContent = [
      const Text(
        '24°C',
        style: TextStyle(
          fontSize: 72,
          fontWeight: FontWeight.bold,
          color: Colors.blue,
        ),
      ),
      const SizedBox(height: 16),
      const Text(
        'Santiago de Querétaro',
        style: TextStyle(fontSize: 24),
        textAlign: TextAlign.center,
      ),
      const SizedBox(height: 32),
      const WeatherIcon(condition: 'cloudy'),
      const SizedBox(height: 32),
      const Text('Humedad: 65% | Viento: 12 km/h', textAlign: TextAlign.center),
      const SizedBox(height: 40),
      ElevatedButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const SearchScreen()),
          );
        },
        child: const Text('Buscar Ciudades'),
      ),
    ];

    return Scaffold(
      appBar: AppBar(title: const Text('Clima Actual'), centerTitle: true),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16),
          child: Center(
            child: isWide
                ? Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: weatherContent,
                      ),
                    ],
                  )
                : Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: weatherContent,
                  ),
          ),
        ),
      ),
    );
  }
}
