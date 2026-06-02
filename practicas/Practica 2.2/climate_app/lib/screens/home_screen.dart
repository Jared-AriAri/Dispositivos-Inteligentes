import 'package:flutter/material.dart';
import '../widgets/app_button.dart';
import '../widgets/weather_card.dart';
import 'search_screen.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final isWide = width > 600;

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
                      const Flexible(
                        child: WeatherCard(
                          temperature: '24°C',
                          city: 'Santiago de Querétaro',
                          condition: 'cloudy',
                          humidity: '65%',
                          wind: '12 km/h',
                        ),
                      ),
                      const SizedBox(width: 24),
                      AppButton(
                        text: 'Buscar Ciudades',
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const SearchScreen(),
                            ),
                          );
                        },
                      ),
                    ],
                  )
                : Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const WeatherCard(
                        temperature: '24°C',
                        city: 'Santiago de Querétaro',
                        condition: 'cloudy',
                        humidity: '65%',
                        wind: '12 km/h',
                      ),
                      const SizedBox(height: 40),
                      AppButton(
                        text: 'Buscar Ciudades',
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const SearchScreen(),
                            ),
                          );
                        },
                      ),
                    ],
                  ),
          ),
        ),
      ),
    );
  }
}
