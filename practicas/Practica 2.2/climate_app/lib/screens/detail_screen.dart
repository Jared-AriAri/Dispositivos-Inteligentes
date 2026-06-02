import 'package:flutter/material.dart';
import '../widgets/app_button.dart';
import '../widgets/forecast_item.dart';

class DetailScreen extends StatelessWidget {
  final String city;

  const DetailScreen({Key? key, required this.city}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final isWide = width > 600;

    final forecast = const [
      ForecastItem(day: 'Lun', temperature: '24°C'),
      ForecastItem(day: 'Mar', temperature: '26°C'),
      ForecastItem(day: 'Mié', temperature: '20°C'),
      ForecastItem(day: 'Jue', temperature: '25°C'),
      ForecastItem(day: 'Vie', temperature: '28°C'),
    ];

    return Scaffold(
      appBar: AppBar(title: Text('$city - 5 Días'), centerTitle: true),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16),
          child: Center(
            child: Column(
              children: [
                const SizedBox(height: 20),
                isWide
                    ? Row(
                        children: forecast
                            .map(
                              (item) => Expanded(
                                child: Padding(
                                  padding: const EdgeInsets.all(6),
                                  child: item,
                                ),
                              ),
                            )
                            .toList(),
                      )
                    : Column(
                        children: forecast
                            .map(
                              (item) => SizedBox(
                                width: double.infinity,
                                child: Padding(
                                  padding: const EdgeInsets.only(bottom: 12),
                                  child: item,
                                ),
                              ),
                            )
                            .toList(),
                      ),
                const SizedBox(height: 30),
                AppButton(
                  text: 'Volver',
                  onPressed: () => Navigator.pop(context),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
