import 'package:flutter/material.dart';
import '../models/device_health.dart';

class DeviceHealthCheckScreen extends StatefulWidget {
  const DeviceHealthCheckScreen({super.key});

  @override
  State<DeviceHealthCheckScreen> createState() => _DeviceHealthCheckScreenState();
}

class _DeviceHealthCheckScreenState extends State<DeviceHealthCheckScreen> {
  final Map<String, bool> _checks = {
    'Screen has no cracks or dead pixels': false,
    'All buttons work properly': false,
    'Camera functions correctly': false,
    'Speakers produce clear sound': false,
    'Charging port works': false,
    'Wi-Fi connectivity works': false,
    'Bluetooth functions properly': false,
    'No water damage indicators': false,
  };

  double _batteryHealth = 80.0;
  int _storageCapacity = 64;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Device Health Check'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Battery Health',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            Slider(
              value: _batteryHealth,
              min: 0,
              max: 100,
              divisions: 10,
              label: '${_batteryHealth.round()}%',
              onChanged: (value) {
                setState(() {
                  _batteryHealth = value;
                });
              },
            ),
            Text('Current battery health: ${_batteryHealth.round()}%'),

            const SizedBox(height: 20),

            const Text(
              'Storage Capacity',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            DropdownButton<int>(
              value: _storageCapacity,
              items: [16, 32, 64, 128, 256, 512].map((capacity) {
                return DropdownMenuItem(
                  value: capacity,
                  child: Text('$capacity GB'),
                );
              }).toList(),
              onChanged: (value) {
                setState(() {
                  _storageCapacity = value!;
                });
              },
            ),

            const SizedBox(height: 20),

            const Text(
              'Device Condition Checklist',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            ..._checks.entries.map((entry) {
              return CheckboxListTile(
                title: Text(entry.key),
                value: entry.value,
                onChanged: (value) {
                  setState(() {
                    _checks[entry.key] = value!;
                  });
                },
              );
            }).toList(),

            const SizedBox(height: 20),

            ElevatedButton(
              onPressed: _generateHealthReport,
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF109991),
                foregroundColor: Colors.white,
                minimumSize: const Size(double.infinity, 50),
              ),
              child: const Text('Generate Health Report'),
            ),
          ],
        ),
      ),
    );
  }

  void _generateHealthReport() {
    final health = DeviceHealth(
      batteryHealth: _batteryHealth,
      screenWorking: _checks['Screen has no cracks or dead pixels']!,
      buttonsWorking: _checks['All buttons work properly']!,
      cameraWorking: _checks['Camera functions correctly']!,
      speakersWorking: _checks['Speakers produce clear sound']!,
      storageCapacity: _storageCapacity,
      chargingPortWorking: _checks['Charging port works']!,
      wifiWorking: _checks['Wi-Fi connectivity works']!,
      bluetoothWorking: _checks['Bluetooth functions properly']!,
      overallCondition: _calculateOverallCondition(),
    );

    Navigator.pop(context, health);
  }

  String _calculateOverallCondition() {
    final passedChecks = _checks.values.where((value) => value).length;
    final totalChecks = _checks.length;
    final percentage = (passedChecks / totalChecks) * 100;

    if (percentage >= 90 && _batteryHealth >= 85) return 'Excellent';
    if (percentage >= 75 && _batteryHealth >= 70) return 'Good';
    if (percentage >= 50 && _batteryHealth >= 50) return 'Fair';
    return 'Poor';
  }
}