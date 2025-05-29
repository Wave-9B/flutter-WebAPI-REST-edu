import 'package:challenge_1/models/device.dart';
import 'package:challenge_1/screens/add_device_screen.dart';
import 'package:challenge_1/screens/device_card.dart';
import 'package:challenge_1/screens/edit_device_screen.dart';
import 'package:challenge_1/services/device_service.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

DeviceService deviceService = DeviceService();

List<Device> devices = [
  /*Device(
    deviceId: "001",
    deviceName: "iPhone 14",
    deviceColor: "Red",
    deviceCapacity: "256 GB",
  ),*/
];

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    super.initState();
    //DeviceService().testApiConnection(); // Test API connection
    _loadDevices();
  }

  void _loadDevices() async {
    //await DeviceService().fetchAndAddFirstDevice(devices);
    await deviceService.fetchAndAddAllDevice(devices);
    // deviceService.register(
    //   Device.empty(),
    // ); // Registra um dispositivo vazio para garantir que a lista não esteja vazia
    setState(() {}); // Para atualizar a tela, se necessário
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Align(
          alignment: Alignment.centerLeft,
          child: Text(
            "Home",
            style: TextStyle(
              color: Color.fromARGB(255, 230, 230, 230),
              fontSize: 30,
            ),
          ),
        ),
        backgroundColor: const Color.fromARGB(255, 44, 44, 44),
      ),
      body: ListView(
        children: [
          Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                for (int i = 0; i < devices.length; i++)
                  Padding(
                    padding: const EdgeInsets.only(bottom: 16),
                    child: DeviceCard(
                      deviceId: devices[i].deviceId,
                      deviceName: devices[i].deviceName,
                      deviceColor: devices[i].deviceColor,
                      deviceCapacity: devices[i].deviceCapacity,
                      onDelete: () {
                        setState(() {
                          devices.removeAt(i);
                        });
                      },
                      onEdit: () {
                        setState(() async {
                          await Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder:
                                  (context) => EditDeviceScreen(deviceIndex: i),
                            ),
                          );
                          setState(
                            () {},
                          ); // Refresh the screen after editing a device
                        });
                      },
                    ),
                  ),
              ],
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: const Color.fromARGB(255, 44, 44, 44),
        shape: CircleBorder(),

        onPressed: () async {
          final result = await Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => AddDeviceScreen()),
          );
          if (result == true) {
            await deviceService.fetchAndAddAllDevice(devices);
            setState(() {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text("Device adicionado com sucesso!"),
                  backgroundColor: Colors.green,
                ),
              );
            }); // Refresh the screen only if a new device was added
          }
        },
        child: const Icon(Icons.add, color: Colors.white),
      ),
    );
  }
}
