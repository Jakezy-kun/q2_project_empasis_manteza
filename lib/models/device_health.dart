class DeviceHealth {
  final double batteryHealth;
  final bool screenWorking;
  final bool buttonsWorking;
  final bool cameraWorking;
  final bool speakersWorking;
  final int storageCapacity;
  final bool chargingPortWorking;
  final bool wifiWorking;
  final bool bluetoothWorking;
  final String overallCondition;

  DeviceHealth({
    required this.batteryHealth,
    required this.screenWorking,
    required this.buttonsWorking,
    required this.cameraWorking,
    required this.speakersWorking,
    required this.storageCapacity,
    required this.chargingPortWorking,
    required this.wifiWorking,
    required this.bluetoothWorking,
    required this.overallCondition,
  });

  double get healthScore {
    double score = 0;
    if (batteryHealth >= 80) score += 20;
    else if (batteryHealth >= 50) score += 15;
    else score += 5;

    if (screenWorking) score += 15;
    if (buttonsWorking) score += 10;
    if (cameraWorking) score += 10;
    if (speakersWorking) score += 10;
    if (chargingPortWorking) score += 10;
    if (wifiWorking) score += 10;
    if (bluetoothWorking) score += 10;

    return score;
  }

  Map<String, dynamic> toMap() {
    return {
      'batteryHealth': batteryHealth,
      'screenWorking': screenWorking,
      'buttonsWorking': buttonsWorking,
      'cameraWorking': cameraWorking,
      'speakersWorking': speakersWorking,
      'storageCapacity': storageCapacity,
      'chargingPortWorking': chargingPortWorking,
      'wifiWorking': wifiWorking,
      'bluetoothWorking': bluetoothWorking,
      'overallCondition': overallCondition,
    };
  }

  factory DeviceHealth.fromMap(Map<String, dynamic> map) {
    return DeviceHealth(
      batteryHealth: map['batteryHealth']?.toDouble() ?? 0.0,
      screenWorking: map['screenWorking'] ?? false,
      buttonsWorking: map['buttonsWorking'] ?? false,
      cameraWorking: map['cameraWorking'] ?? false,
      speakersWorking: map['speakersWorking'] ?? false,
      storageCapacity: map['storageCapacity'] ?? 0,
      chargingPortWorking: map['chargingPortWorking'] ?? false,
      wifiWorking: map['wifiWorking'] ?? false,
      bluetoothWorking: map['bluetoothWorking'] ?? false,
      overallCondition: map['overallCondition'] ?? 'Unknown',
    );
  }
}