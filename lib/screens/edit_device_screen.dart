import 'package:challenge_1/services/device_service.dart';
import 'package:flutter/material.dart';
import 'package:challenge_1/screens/home_screen.dart'; // para acessar a lista devices

class EditDeviceScreen extends StatefulWidget {
  final int deviceIndex;

  EditDeviceScreen({required this.deviceIndex, super.key});

  final _editNameController = TextEditingController();
  final _editColorController = TextEditingController();
  final _editCapacityController = TextEditingController();

  @override
  State<EditDeviceScreen> createState() => _EditDeviceScreenState();
}

class _EditDeviceScreenState extends State<EditDeviceScreen> {
  @override
  void initState() {
    super.initState();
    widget._editNameController.text = devices[widget.deviceIndex].deviceName;
    widget._editColorController.text = devices[widget.deviceIndex].deviceColor;
    widget._editCapacityController.text =
        devices[widget.deviceIndex].deviceCapacity;
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      child: Scaffold(
        appBar: AppBar(
          title: Text("Edit Device", style: TextStyle(color: Colors.white)),
          backgroundColor: Color.fromARGB(255, 44, 44, 44),
          iconTheme: IconThemeData(color: Colors.white),
        ),
        body: Padding(
          padding: EdgeInsets.all(16),
          child: Column(
            children: [
              TextFormField(
                controller: widget._editNameController,
                decoration: InputDecoration(labelText: "Change Device Name"),
              ),
              TextFormField(
                controller: widget._editColorController,
                decoration: InputDecoration(labelText: "Change Device Color"),
              ),
              TextFormField(
                controller: widget._editCapacityController,
                decoration: InputDecoration(
                  labelText: "Change Device Capacity",
                ),
              ),

              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Color.fromARGB(255, 44, 44, 44),
                ),
                onPressed: () async {
                  await DeviceService().editDeviceOnApi(
                    id: devices[widget.deviceIndex].deviceId,
                    name: widget._editNameController.text,
                    color: widget._editColorController.text,
                    capacity: widget._editCapacityController.text,
                  );

                  setState(() {
                    devices[widget.deviceIndex].deviceName =
                        widget._editNameController.text;
                    devices[widget.deviceIndex].deviceColor =
                        widget._editColorController.text;
                    devices[widget.deviceIndex].deviceCapacity =
                        widget._editCapacityController.text;

                    Navigator.pop(context);
                  });
                },
                child: Text(
                  "Edit Device",
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
