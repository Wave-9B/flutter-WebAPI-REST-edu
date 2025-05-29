import 'package:uuid/uuid.dart';

class Device {
  String deviceId;
  String deviceName;
  String deviceColor;
  String deviceCapacity;

  Device({
    required this.deviceId,
    required this.deviceName,
    required this.deviceColor,
    required this.deviceCapacity,
  });

  Device.empty()
    : deviceId = const Uuid().v1(),
      deviceName = '',
      deviceColor = '',
      deviceCapacity = '';

  Map<String, dynamic> toMap() {
    return {
      'name': deviceName,
      'data': {'color': deviceColor, 'capacity': deviceCapacity},
    };
  }

  //from Map
  factory Device.fromMap(Map<String, dynamic> map) {
    return Device(
      deviceId: map['id']?.toString() ?? '',
      deviceName: map['name'] ?? '',
      deviceColor: map['color'] ?? '',
      deviceCapacity: map['capacity'] ?? '',
    );
  }
}
