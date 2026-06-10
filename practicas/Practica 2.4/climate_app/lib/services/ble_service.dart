import 'package:flutter_blue_plus/flutter_blue_plus.dart';

class BLEService {
  Future<void> startScan() async {
    await FlutterBluePlus.startScan(timeout: const Duration(seconds: 5));
  }

  Future<void> stopScan() async {
    await FlutterBluePlus.stopScan();
  }

  Stream<List<ScanResult>> get scanResults => FlutterBluePlus.scanResults;

  Future<void> connect(BluetoothDevice device) async {
    await device.connect();
  }

  Future<List<BluetoothService>> discoverServices(
    BluetoothDevice device,
  ) async {
    return await device.discoverServices();
  }
}
