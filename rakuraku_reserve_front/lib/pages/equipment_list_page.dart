import 'package:flutter/material.dart';

class EquipmentListPage extends StatelessWidget {
  const EquipmentListPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ListTile(
          leading: Image.asset('images/Raspberry_Pi.jpg'),
          title: const Text('Raspberry Pi 1'),
          trailing: Icon(Icons.abc),
          onTap: () {},
        ),
        ListTile(
          leading: Image.asset('images/Raspberry_Pi.jpg'),
          title: const Text('Raspberry Pi 2'),
          trailing: Icon(Icons.abc),
          onTap: () {},
        ),
        ListTile(
          leading: Image.asset('images/Raspberry_Pi.jpg'),
          title: const Text('Raspberry Pi 3'),
          trailing: Icon(Icons.abc),
          onTap: () {},
        ),
      ],
    );
  }
}
