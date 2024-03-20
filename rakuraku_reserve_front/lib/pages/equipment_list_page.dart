import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:rakuraku_reserve_front/pages/equipment_pages/equipment_detail_page.dart';

class EquipmentListPage extends StatefulWidget {
  const EquipmentListPage({super.key});

  @override
  State<EquipmentListPage> createState() => _EquipmentListState();
}

class _EquipmentListState extends State<EquipmentListPage> {
  List equipments = [];

  Future<void> getData() async {
    var response = await http.get(
      Uri.parse("http://10.0.2.2:8080/api/equipments"),
    );

    var jsonResponse = jsonDecode(response.body);

    setState(() {
      equipments = jsonResponse;
    });
  }

  @override
  void initState() {
    super.initState();

    getData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView.builder(
        itemCount: equipments.length,
        itemBuilder: (BuildContext context, int index) {
          return Card(
            child: Column(
              children: [
                ListTile(
                  leading: Text(equipments[index]['equipmentId'].toString()),
                  title: Text(equipments[index]['name']),
                  onTap: () {
                    print(equipments[index]['name']);
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => EquipmentDetailPage(
                              equipmentId: equipments[index]['equipmentId']),
                        ));
                  },
                )
              ],
            ),
          );
        },
      ),
    );
  }
}

// class EquipmentListPage extends StatelessWidget {
//   const EquipmentListPage({super.key});

//   Future<void> getData() async {
//     var response = await http.get(Uri.https('localhost', '/api/equipments',
//         {'q': '{Flutter}', 'maxResults': '40', 'langRestrict': 'ja'}));

//     var jsonResponse = jsonDecode(response.body);

//     setState(() {
//       items = jsonResponse['items'];
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Column(
//       children: [
//         ListTile(
//           leading: Image.asset('images/Raspberry_Pi.jpg'),
//           title: const Text('Raspberry Pi 1'),
//           trailing: Icon(Icons.abc),
//           onTap: () {},
//         ),
//         ListTile(
//           leading: Image.asset('images/Raspberry_Pi.jpg'),
//           title: const Text('Raspberry Pi 2'),
//           trailing: Icon(Icons.abc),
//           onTap: () {},
//         ),
//         ListTile(
//           leading: Image.asset('images/Raspberry_Pi.jpg'),
//           title: const Text('Raspberry Pi 3'),
//           trailing: Icon(Icons.abc),
//           onTap: () {},
//         ),
//       ],
//     );
//   }
// }
