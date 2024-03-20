import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:rakuraku_reserve_front/pages/equipment_pages/equipment_reserve_page.dart';

class EquipmentDetailPage extends StatefulWidget {
  final int equipmentId;

  const EquipmentDetailPage({super.key, required this.equipmentId});

  @override
  State<EquipmentDetailPage> createState() => _EquipmentDetailState();
}

class _EquipmentDetailState extends State<EquipmentDetailPage> {
  var equipment = {};

  @override
  void initState() {
    super.initState();

    _getEquipmentData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('機材詳細'),
        backgroundColor: Colors.deepOrange[300],
      ),
      body: Center(
        child: Column(
          children: [
            SizedBox(height: 50),
            Text(equipment['name']),
            SizedBox(height: 30),
            Text(equipment['explanation']),
            SizedBox(height: 30),
            (equipment['IsAvaliable'])
                ? ElevatedButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => EquipmentReservePage(
                                equipmentId: equipment['equipmentId'])),
                      );
                    },
                    child: const Text('予約'),
                  )
                : const Text('予約不可')
          ],
        ),
      ),
    );
  }

  Future<void> _getEquipmentData() async {
    var response = await http.get(
      Uri.parse(
          "http://10.0.2.2:8080/api/equipments/${widget.equipmentId.toString()}"),
    );

    var jsonResponse = jsonDecode(response.body);

    setState(() {
      equipment = jsonResponse['equipment'];
    });
  }
}
