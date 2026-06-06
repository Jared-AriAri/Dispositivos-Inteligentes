import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/weather_provider.dart';
import '../utils/weather_utils.dart';
import 'search_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    super.initState();

    Future.microtask(() {
      Provider.of<WeatherProvider>(
        context,
        listen: false,
      ).loadWeather('Santiago');
    });
  }

  Future<void> openSearch() async {
    final selectedCity = await Navigator.push<String>(
      context,
      MaterialPageRoute(builder: (_) => const SearchScreen()),
    );

    if (selectedCity != null && selectedCity.isNotEmpty) {
      if (!mounted) return;

      Provider.of<WeatherProvider>(
        context,
        listen: false,
      ).loadWeather(selectedCity);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Climate App'),
        actions: [
          IconButton(onPressed: openSearch, icon: const Icon(Icons.search)),
        ],
      ),
      body: Consumer<WeatherProvider>(
        builder: (context, weatherProvider, _) {
          if (weatherProvider.isLoading) {
            return const Center(child: CircularProgressIndicator());
          }

          if (weatherProvider.errorMessage != null) {
            return Center(
              child: Text('Error: ${weatherProvider.errorMessage}'),
            );
          }

          final weather = weatherProvider.weather;

          if (weather == null) {
            return const Center(child: Text('No data'));
          }

          final icon = WeatherUtils.getWeatherIcon(weather.condition);

          return Center(
            child: Padding(
              padding: const EdgeInsets.all(24),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(icon, style: const TextStyle(fontSize: 80)),
                  const SizedBox(height: 16),
                  Text(
                    '${weatherProvider.displayedTemperature}${weatherProvider.temperatureUnit}',
                    style: const TextStyle(
                      fontSize: 72,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    weather.city,
                    style: const TextStyle(
                      fontSize: 28,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(weather.condition, style: const TextStyle(fontSize: 20)),
                  const SizedBox(height: 8),
                  Text(
                    'Humidity: ${weather.humidity}%',
                    style: const TextStyle(fontSize: 18),
                  ),
                  const SizedBox(height: 32),
                  ElevatedButton(
                    onPressed: weatherProvider.toggleTemperatureUnit,
                    child: const Text('Cambiar unidad'),
                  ),
                  const SizedBox(height: 12),
                  OutlinedButton.icon(
                    onPressed: openSearch,
                    icon: const Icon(Icons.search),
                    label: const Text('Buscar ciudad'),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
