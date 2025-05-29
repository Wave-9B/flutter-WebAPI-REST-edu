import 'package:flutter/material.dart';

class DeviceCard extends StatefulWidget {
  const DeviceCard({
    required this.deviceId,
    required this.deviceName,
    required this.deviceColor,
    required this.deviceCapacity,
    this.onDelete,
    this.onEdit,
    super.key,
  });

  final String deviceId;
  final String? deviceName;
  final String? deviceColor;
  final String? deviceCapacity;
  final VoidCallback? onDelete;
  final VoidCallback? onEdit;

  @override
  State<DeviceCard> createState() => _DeviceCardState();
}

class _DeviceCardState extends State<DeviceCard> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          height: 116,
          width: double.infinity,
          decoration: BoxDecoration(
            color: Color.fromARGB(255, 255, 255, 255),
            borderRadius: BorderRadius.circular(10),
            boxShadow: [
              BoxShadow(
                color: Color.fromARGB(100, 0, 0, 0),
                blurRadius: 1,
                offset: Offset(0, 3),
              ),
            ],
          ),
          child: Padding(
            padding: const EdgeInsets.all(10),
            child: Row(
              children: [
                Expanded(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Text(
                        //?'${widget.deviceName!}wave-9b', testin purpose
                        widget.deviceName ?? '',
                        style: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                        overflow: TextOverflow.ellipsis,
                        maxLines: 1,
                      ),
                      Text(
                        "ID: ${widget.deviceId}",
                        style: const TextStyle(
                          fontSize: 16,
                          color: Colors.black54,
                        ),
                        overflow: TextOverflow.ellipsis,
                        maxLines: 1,
                      ),
                      // const SizedBox(height: 15),
                      Text(
                        "Color: ${widget.deviceColor}",
                        style: const TextStyle(
                          fontSize: 16,
                          color: Colors.black87,
                        ),
                        overflow: TextOverflow.ellipsis,
                        maxLines: 1,
                      ),
                      Text(
                        "Capacity: ${widget.deviceCapacity}",
                        style: const TextStyle(
                          fontSize: 16,
                          color: Colors.black87,
                        ),
                        overflow: TextOverflow.ellipsis,
                        maxLines: 1,
                      ),
                    ],
                  ),
                ),
                //Spacer(),
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    IconButton(
                      icon: Icon(
                        Icons.delete_outline,
                        size: 30,
                        color: const Color.fromARGB(255, 128, 37, 28),
                      ),
                      onPressed: () {
                        widget.onDelete?.call();
                      },
                    ),
                    IconButton(
                      icon: Icon(
                        Icons.edit_outlined,
                        size: 27,
                        color: const Color.fromARGB(255, 18, 79, 129),
                      ),
                      onPressed: () {
                        widget.onEdit?.call();
                      },
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
