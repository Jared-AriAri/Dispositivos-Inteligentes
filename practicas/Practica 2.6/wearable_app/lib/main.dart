import 'package:flutter/material.dart';
import 'sensor_simulator.dart';
import 'ble_server.dart';

void main() => runApp(const WearableApp());

class WearableApp extends StatefulWidget {
  const WearableApp({super.key});

  @override
  State<WearableApp> createState() => WearableAppState();
}

class WearableAppState extends State<WearableApp> {
  late final SensorSimulator _sim;
  late final BleServer _server;

  int steps = 0;
  int heartRate = 72;
  int calories = 0;
  String status = 'reposo';
  bool _active = false;

  @override
  void initState() {
    super.initState();
    _sim = SensorSimulator();
    _server = BleServer(_sim);
    _subscribeStreams();
  }

  void _subscribeStreams() {
    _sim.stepsStream.listen((v) => setState(() => steps = v));
    _sim.heartRateStream.listen((v) => setState(() => heartRate = v));
    _sim.caloriesStream.listen((v) => setState(() => calories = v));
    _sim.statusStream.listen((v) => setState(() => status = v));
  }

  void _toggleActivity() {
    setState(() => _active = !_active);
    if (_active) {
      _sim.start();
      _server.startAdvertising();
    } else {
      _server.stop();
    }
  }

  @override
  void dispose() {
    _server.stop();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData.dark(),
      home: Scaffold(
        backgroundColor: Colors.black,
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                '$heartRate',
                style: TextStyle(
                  fontSize: 40,
                  fontWeight: FontWeight.bold,
                  color: heartRate > 120 ? Colors.red : Colors.white,
                ),
              ),
              const Text(
                'bpm',
                style: TextStyle(color: Colors.grey, fontSize: 12),
              ),
              const SizedBox(height: 4),
              Text(
                '$steps pasos',
                style: const TextStyle(fontSize: 14, color: Colors.green),
              ),
              Text(
                '$calories kcal',
                style: const TextStyle(fontSize: 13, color: Colors.amber),
              ),
              Text(
                status.toUpperCase(),
                style: const TextStyle(fontSize: 11, color: Colors.blue),
              ),
              const SizedBox(height: 8),
              ElevatedButton(
                onPressed: _toggleActivity,
                style: ElevatedButton.styleFrom(
                  backgroundColor: _active ? Colors.red : Colors.green,
                  minimumSize: const Size(90, 32),
                ),
                child: Text(_active ? 'Detener' : 'Iniciar'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
