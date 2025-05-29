import 'package:challenge_1/services/device_service.dart';
import 'package:flutter/material.dart';

class AddDeviceScreen extends StatefulWidget {
  AddDeviceScreen({super.key});
  final _nameController = TextEditingController();
  final _colorController = TextEditingController();
  final _capacityController = TextEditingController();

  @override
  State<AddDeviceScreen> createState() => _AddDeviceScreenState();
}

class _AddDeviceScreenState extends State<AddDeviceScreen> {
  @override
  Widget build(BuildContext context) {
    return Form(
      child: Scaffold(
        appBar: AppBar(
          title: const Text(
            "Add Device",
            style: TextStyle(color: Colors.white),
          ),
          backgroundColor: const Color.fromARGB(255, 44, 44, 44),
          iconTheme: IconThemeData(color: Colors.white),
        ),
        body: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            children: [
              TextFormField(
                controller: widget._nameController,
                decoration: const InputDecoration(labelText: "Device Name"),
              ),
              TextFormField(
                controller: widget._colorController,
                decoration: const InputDecoration(labelText: "Device Color"),
              ),
              TextFormField(
                controller: widget._capacityController,
                decoration: const InputDecoration(labelText: "Device Capacity"),
              ),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Color.fromARGB(255, 44, 44, 44),
                ),
                onPressed: () async {
                  await DeviceService().addDeviceToApi(
                    name: widget._nameController.text,
                    color: widget._colorController.text,
                    capacity: widget._capacityController.text,
                  );
                  /* devices.add(
                    Device(
                      deviceId: devices.length.toString(),
                      deviceName: widget._nameController.text,
                      deviceColor: widget._colorController.text,
                      deviceCapacity: widget._capacityController.text,
                    ),
                  );*/
                  setState(() {
                    Navigator.pop(context, true);
                  });
                  
                },
                child: const Text(
                  "Add Device",
                  style: TextStyle(color: Colors.white),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
