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

          return SingleChildScrollView(
            padding: const EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Card(
                  child: Padding(
                    padding: const EdgeInsets.all(20),
                    child: Column(
                      children: [
                        const Icon(Icons.bluetooth, size: 60),
                        const SizedBox(height: 12),
                        const Text(
                          'Bluetooth BLE',
                          style: TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 12),
                        Text(
                          weatherProvider.bleStatus,
                          textAlign: TextAlign.center,
                        ),
                        const SizedBox(height: 16),
                        SizedBox(
                          width: double.infinity,
                          child: ElevatedButton.icon(
                            onPressed: weatherProvider.startBleScan,
                            icon: const Icon(Icons.bluetooth_searching),
                            label: const Text('Buscar dispositivos'),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),

                const SizedBox(height: 16),

                if (weatherProvider.bleDevices.isNotEmpty)
                  Card(
                    child: Padding(
                      padding: const EdgeInsets.all(12),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            'Dispositivos encontrados',
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(height: 12),
                          ListView.builder(
                            shrinkWrap: true,
                            physics: const NeverScrollableScrollPhysics(),
                            itemCount: weatherProvider.bleDevices.length,
                            itemBuilder: (context, index) {
                              final result = weatherProvider.bleDevices[index];

                              return ListTile(
                                leading: const Icon(Icons.bluetooth),
                                title: Text(
                                  result.device.platformName.isEmpty
                                      ? 'Dispositivo BLE'
                                      : result.device.platformName,
                                ),
                                subtitle: Text(
                                  result.device.remoteId.toString(),
                                ),
                                onTap: () {
                                  weatherProvider.connectToDevice(
                                    result.device,
                                  );
                                },
                              );
                            },
                          ),
                        ],
                      ),
                    ),
                  ),

                const SizedBox(height: 24),

                Card(
                  child: Padding(
                    padding: const EdgeInsets.all(24),
                    child: Column(
                      children: [
                        Text(icon, style: const TextStyle(fontSize: 90)),
                        const SizedBox(height: 12),
                        Text(
                          '${weatherProvider.displayedTemperature}${weatherProvider.temperatureUnit}',
                          style: const TextStyle(
                            fontSize: 56,
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
                        Text(weather.condition),
                        const SizedBox(height: 8),
                        Text('Humidity: ${weather.humidity}%'),
                        const SizedBox(height: 16),
                        SizedBox(
                          width: double.infinity,
                          child: ElevatedButton(
                            onPressed: weatherProvider.toggleTemperatureUnit,
                            child: const Text('Cambiar unidad'),
                          ),
                        ),
                        const SizedBox(height: 12),
                        SizedBox(
                          width: double.infinity,
                          child: OutlinedButton.icon(
                            onPressed: openSearch,
                            icon: const Icon(Icons.search),
                            label: const Text('Buscar ciudad'),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
