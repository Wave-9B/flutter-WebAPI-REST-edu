// ignore_for_file: avoid_print

import 'dart:convert';
import 'package:challenge_1/models/device.dart';
import 'package:flutter/material.dart';

import 'package:http/http.dart' as http;
import 'package:http_interceptor/http_interceptor.dart';

import 'http_interceptors.dart';

class DeviceService {
  static const String url = "https://api.restful-api.dev/objects";
  //static const String url = "https://api.restful-api.dev";

  http.Client client = InterceptedClient.build(
    interceptors: [LoggerInterceptor()], // Adiciona o interceptor de log
  );

  String getUrl() {
    return url;
  }

  Future<void> fetchAndAddFirstDevice(List<Device> devices) async {
    final response = await client.get(Uri.parse(url));
    if (response.statusCode == 200) {
      final List<dynamic> data = jsonDecode(response.body);
      if (data.isNotEmpty) {
        //final nameFromUrl = data[0];
       // final first = data[0];

        //final deviceData = first['data'] ?? {};
        //final deviceNameUrl = nameFromUrl['name'] ?? {};
        devices.add(
          Device.fromMap(data.first), // Adiciona o primeiro dispositivo da lista
          // Device(
          //   deviceId: first['id'].toString(),
          //   deviceName: deviceNameUrl,
          //   deviceColor: deviceData['color'] ?? '',
          //   deviceCapacity: deviceData['capacity'] ?? '',
          // ),
        );
        print("Device added: ${devices.last.deviceName}");
      }
    } else {
      print("Failed to fetch devices: ${response.statusCode}");
    }
  }

  Future<void> fetchAndAddAllDevice(List<Device> devices) async {
    final response = await client.get(Uri.parse(url));
    if (response.statusCode == 200) {
      final List<dynamic> data = jsonDecode(response.body);
      devices.clear(); // Clear the list before adding new devices
      if (data.isNotEmpty) {
        for (var item in data) {
          final deviceData = item['data'] ?? {};
          final deviceNameUrl = item['name'] ?? {};

          // Tenta pegar o campo de capacidade em várias formas
          String capacity = '';
          if (deviceData['capacity'] != null) {
            capacity = deviceData['capacity'].toString();
          } else if (deviceData['Capacity'] != null) {
            capacity = deviceData['Capacity'].toString();
          } else if (deviceData['capacity GB'] != null) {
            capacity = deviceData['capacity GB'].toString();
          } else if (deviceData['capacityGB'] != null) {
            capacity = deviceData['capacityGB'].toString();
          }
          // Tenta pegar o campo de cor em várias formas
          String color = '';
          if (deviceData['color'] != null) {
            color = deviceData['color'].toString();
          } else if (deviceData['Color'] != null) {
            color = deviceData['Color'].toString();
          } else if (deviceData['Strap Colour'] != null) {
            color = deviceData['Strap Colour'].toString();
          }

          devices.add(
            Device(
              deviceId: item['id']?.toString() ?? '',
              deviceName: deviceNameUrl ?? '',
              deviceColor: color,
              deviceCapacity: capacity,

              // Uncomment the following lines if you want to use them
              //deviceColor: deviceData['color'] ?? '',
              // deviceCapacity: deviceData['capacity'] ?? '',
            ),
          );
        }
        print("Device added: ${devices.last.deviceName}");
        print('body da URL: ${response.body}');
      }
    } else {
      print("Failed to fetch devices: ${response.statusCode}");
    }

    // ignore: unused_element
    Future<void> testApiConnection() async {
      final response = await client.get(Uri.parse(url));
      if (response.statusCode == 200) {
        print("API connection successful");
        print(response.body);
      } else {
        print("API connection failed: ${response.statusCode}");
      }
    }
  }

  Future<void> addDeviceToApi({
    BuildContext? context,
    required String name,
    required String color,
    required String capacity,
  }) async {
    final response = await client.post(
      Uri.parse(url),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({
        "name": name,
        "data": {"color": color, "capacity": capacity},
      }),
    );

    if (response.statusCode == 200 || response.statusCode == 201) {
      print("Device adicionado com sucesso!");
      print(response.body);
    } else {
      print("Erro ao adicionar device: ${response.statusCode}");
      print(response.body);
    }
  }

  Future<void> editDeviceOnApi({
    required String id,
    required String name,
    required String color,
    required String capacity,
  }) async {
    final response = await client.patch(
      Uri.parse('$url/$id'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({
        "name": name,
        "data": {"color": color, "capacity": capacity},
      }),
    );

    if (response.statusCode == 200) {
      print("Device editado com sucesso!");
    } else {
      print("Erro ao editar device: ${response.statusCode}");
    }
  }

  //tutorial alura webAPI
  Future<bool> register(Device device) async {
    String jsonDevice = jsonEncode(device.toMap());

    http.Response response = await client.post(
      Uri.parse(getUrl()),
      headers: {'Content-Type': 'application/json'},
      body: jsonDevice,
    );
    if (response.statusCode == 200 || response.statusCode == 201) {
      print("Device registered successfully! ${response.statusCode})");
      return true;
    } else {
      print("Failed to register device: ${response.statusCode}");
      return false;
    }
  }
}
