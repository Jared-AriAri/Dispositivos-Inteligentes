import 'package:flutter/material.dart';
import 'package:flutter_blue_plus/flutter_blue_plus.dart';
import '../models/weather_model.dart';
import '../utils/weather_utils.dart';
import '../services/ble_service.dart';
import '../services/weather_service.dart';

class WeatherProvider extends ChangeNotifier {
  Weather? _weather;
  bool _isLoading = false;
  String? _errorMessage;
  int _tempUnit = 0;

  final WeatherService _weatherService = WeatherService();
  final BLEService _bleService = BLEService();

  List<ScanResult> bleDevices = [];
  String bleStatus = 'Sin conexión BLE';
  String bleData = '';

  Weather? get weather => _weather;
  bool get isLoading => _isLoading;
  String? get errorMessage => _errorMessage;
  String? get error => _errorMessage;
  String get temperatureUnit => _tempUnit == 0 ? '°C' : '°F';

  int get displayedTemperature {
    if (_weather == null) return 0;

    if (_tempUnit == 0) {
      return _weather!.temperature;
    }

    return WeatherUtils.celsiusToFahrenheit(_weather!.temperature).round();
  }

  Future<void> fetchWeather(String city) async {
    _isLoading = true;
    _errorMessage = null;
    notifyListeners();

    try {
      _weather = await _weatherService.getWeather(city);
    } catch (e) {
      _errorMessage = e.toString().replaceFirst('Exception: ', '');
      _weather = null;
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<void> loadWeather(String city) async {
    await fetchWeather(city);
  }

  void toggleTemperatureUnit() {
    _tempUnit = _tempUnit == 0 ? 1 : 0;
    notifyListeners();
  }

  void updateTemperature(int newTemp) {
    if (_weather != null && WeatherUtils.isValidTemperature(newTemp)) {
      _weather = Weather(
        city: _weather!.city,
        temperature: newTemp,
        condition: _weather!.condition,
        description: _weather!.description,
        humidity: _weather!.humidity,
        windSpeed: _weather!.windSpeed,
      );

      notifyListeners();
    }
  }

  Future<void> startBleScan() async {
    bleStatus = 'Buscando dispositivos...';
    notifyListeners();

    await _bleService.startScan();

    _bleService.scanResults.listen((results) {
      bleDevices = results;
      notifyListeners();
    });
  }

  Future<void> connectToDevice(BluetoothDevice device) async {
    try {
      bleStatus = 'Conectando...';
      notifyListeners();

      await _bleService.connect(device);

      bleStatus = 'Conectado';
      notifyListeners();

      device.connectionState.listen((state) {
        if (state == BluetoothConnectionState.disconnected) {
          bleStatus = 'Sin conexión BLE';
          notifyListeners();
        }
      });
    } catch (_) {
      bleStatus = 'Error BLE';
      notifyListeners();
    }
  }
}
