import 'package:flutter/material.dart';

class DetailScreen extends StatelessWidget {
  final String city;

  const DetailScreen({super.key, required this.city});

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final isWide = width > 600;

    final forecast = const [
      Text('Lun\n24°C', textAlign: TextAlign.center),
      Text('Mar\n26°C', textAlign: TextAlign.center),
      Text('Mié\n20°C', textAlign: TextAlign.center),
      Text('Jue\n25°C', textAlign: TextAlign.center),
      Text('Vie\n28°C', textAlign: TextAlign.center),
    ];

    return Scaffold(
      appBar: AppBar(title: Text('$city - 5 Días'), centerTitle: true),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16),
          child: Column(
            children: [
              isWide
                  ? Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: forecast,
                    )
                  : Column(
                      children: forecast
                          .map(
                            (item) => Padding(
                              padding: const EdgeInsets.only(bottom: 16),
                              child: item,
                            ),
                          )
                          .toList(),
                    ),
              const SizedBox(height: 40),
              ElevatedButton(
                onPressed: () => Navigator.pop(context),
                child: const Text('Volver'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
