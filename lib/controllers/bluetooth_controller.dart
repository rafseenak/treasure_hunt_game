import 'dart:async';
import 'package:flutter_blue_plus/flutter_blue_plus.dart';
import 'package:permission_handler/permission_handler.dart';

class BluetoothController {
  List<ScanResult> _scanResults = [];
  bool _isScanning = false;
  late StreamSubscription<List<ScanResult>> _scanResultsSubscription;
  late StreamSubscription<bool> _isScanningSubscription;

  Future<void> requestBluetoothPermissions() async {
    var status = await Permission.bluetooth.request();
    if (status.isGranted) {
      print('Bluetooth Permission granted');
    } else {
      print('Bluetooth Permission Not granted');
    }
  }

  startScan() {
    try {
      FlutterBluePlus.startScan(timeout: const Duration(seconds: 1));
      _scanResultsSubscription = FlutterBluePlus.scanResults.listen(
        (results) {
          _scanResults = results.map((result) => result).toList();
        },
      );
      _isScanningSubscription = FlutterBluePlus.isScanning.listen(
        (state) {
          _isScanning = state;
        },
      );
    } catch (e) {
      print('Start Scan Error: $e');
    }
  }

  isScanning() {
    return _isScanning;
  }

  stopScan() {
    try {
      if (_isScanning) {
        FlutterBluePlus.stopScan();
        _isScanning = false;
      }
    } catch (e) {
      print('Stop Scan Error: $e');
    }
  }

  getScanResults() {
    if (_scanResults.isNotEmpty) {
      List scanResult = _scanResults.toList();
      return scanResult;
    }
  }

  void dispose() {
    try {
      if (_isScanning) {
        FlutterBluePlus.stopScan();
      }
    } catch (e) {
      print('Stop Scan Error: $e');
    }
    _scanResultsSubscription.cancel();
    _isScanningSubscription.cancel();
  }
}
