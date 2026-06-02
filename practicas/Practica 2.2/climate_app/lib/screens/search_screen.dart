import 'package:flutter/material.dart';
import '../widgets/app_button.dart';
import '../widgets/city_weather_item.dart';
import 'detail_screen.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({Key? key}) : super(key: key);

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  List<String> cities = ['Santiago', 'Querétaro', 'México'];
  List<String> filtered = [];
  String query = '';

  void filterCities(String value) {
    setState(() {
      query = value;

      filtered = cities
          .where((c) => c.toLowerCase().contains(value.toLowerCase()))
          .toList();
    });
  }

  String getTemperature(String city) {
    if (city == 'Santiago') {
      return '24°C';
    }

    if (city == 'Querétaro') {
      return '22°C';
    }

    return '20°C';
  }

  @override
  Widget build(BuildContext context) {
    final visibleCities = query.isEmpty ? cities : filtered;

    return Scaffold(
      appBar: AppBar(title: const Text('Buscar Ciudades'), centerTitle: true),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16),
            child: TextField(
              onChanged: filterCities,
              decoration: const InputDecoration(
                hintText: 'Busca una ciudad...',
                border: OutlineInputBorder(),
              ),
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: visibleCities.length,
              itemBuilder: (context, index) {
                final city = visibleCities[index];

                return CityWeatherItem(
                  city: city,
                  temperature: getTemperature(city),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => DetailScreen(city: city),
                      ),
                    );
                  },
                );
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16),
            child: AppButton(
              text: 'Atrás',
              onPressed: () => Navigator.pop(context),
            ),
          ),
        ],
      ),
    );
  }
}
