import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class EquipmentReservePage extends StatefulWidget {
  final int equipmentId;

  const EquipmentReservePage({super.key, required this.equipmentId});

  @override
  State<EquipmentReservePage> createState() => _EquipmentReserveState();
}

class _EquipmentReserveState extends State<EquipmentReservePage> {
  var equipment = {};

  DateTime selectedDate = DateTime.now();
  TimeOfDay selectedStartTime = TimeOfDay.now();
  TimeOfDay selectedEndTime = TimeOfDay.now();

  @override
  void initState() {
    super.initState();

    _getEquipmentData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('機材予約'),
        backgroundColor: Colors.deepOrange[300],
      ),
      body: Center(
        child: Column(
          children: [
            SizedBox(height: 50),
            Text(equipment['name']),
            SizedBox(height: 50),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                    '予約日: ${selectedDate.year}/${selectedDate.month}/${selectedDate.day}'),
                SizedBox(width: 15),
                ElevatedButton(
                  onPressed: () => _selectDate(context),
                  child: const Text('日付選択'),
                ),
              ],
            ),
            SizedBox(height: 35),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                    '開始予定時間: ${selectedStartTime.hour.toString().padLeft(2, "0")}:${selectedStartTime.minute.toString().padLeft(2, "0")}'),
                SizedBox(width: 15),
                ElevatedButton(
                  onPressed: () => _selectStartTime(context),
                  child: const Text('時刻選択'),
                ),
              ],
            ),
            SizedBox(height: 35),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                    '終了予定時間: ${selectedEndTime.hour.toString().padLeft(2, "0")}:${selectedEndTime.minute.toString().padLeft(2, "0")}'),
                SizedBox(width: 15),
                ElevatedButton(
                  onPressed: () => _selectEndTime(context),
                  child: const Text('時刻選択'),
                ),
              ],
            ),
            SizedBox(height: 80),
            ElevatedButton(
              onPressed: () {
                _postEquipmentReservation();
              },
              child: Text('予約'),
            )
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

  // 予約日を選択する。
  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: selectedDate,
      firstDate: DateTime(2020),
      lastDate: DateTime(2025),
    );

    if (picked != null) {
      setState(() {
        selectedDate = picked;
      });
    }
  }

  // 予約開始時間を選択する。
  Future<void> _selectStartTime(BuildContext context) async {
    final TimeOfDay? picked = await showTimePicker(
      context: context,
      initialTime: selectedStartTime,
    );

    if (picked != null) {
      setState(() {
        selectedStartTime = picked;
      });
    }
  }

  // 予約終了時間を選択する。
  Future<void> _selectEndTime(BuildContext context) async {
    final TimeOfDay? picked = await showTimePicker(
      context: context,
      initialTime: selectedEndTime,
    );

    if (picked != null) {
      setState(() {
        selectedEndTime = picked;
      });
    }
  }

  // 機材予約のAPI呼び出しを行なう。
  Future<void> _postEquipmentReservation() async {
    print(selectedDate);
    print(selectedStartTime);
    print(selectedEndTime);
    int userId = 1;
    String reservationStartTime =
        '${selectedDate.year}-${selectedDate.month.toString().padLeft(2, "0")}-${selectedDate.day.toString().padLeft(2, "0")} ${selectedStartTime.hour.toString().padLeft(2, "0")}:${selectedStartTime.minute.toString().padLeft(2, "0")}:00';
    String reservationEndTime =
        '${selectedDate.year}-${selectedDate.month.toString().padLeft(2, "0")}-${selectedDate.day.toString().padLeft(2, "0")} ${selectedEndTime.hour.toString().padLeft(2, "0")}:${selectedEndTime.minute.toString().padLeft(2, "0")}:00';
    String activityStartTime = '2022-01-01 12:34:56';
    String activityEndTime = '2022-01-01 12:34:56';
    print('userId:${userId}');
    print('reservationStartTime:${reservationStartTime}');
    print('reservationEndTime:${reservationEndTime}');
    print('activityStartTime:${activityStartTime}');
    print('activityEndTime:${activityEndTime}');
    var response = await http.post(
        Uri.parse(
            "http://10.0.2.2:8080/api/equipments/${widget.equipmentId.toString()}/reserve"),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode({
          'userId': userId,
          'reservationStartTime': reservationStartTime,
          'reservationEndTime': reservationEndTime,
          'activityStartTime': activityStartTime,
          'activityEndTime': activityEndTime,
        }));
    var status = response.statusCode;
    if (status == 200) {
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: const Text("予約完了"),
          content: const Text(""),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text("OK"),
            )
          ],
        ),
      );
    }
  }
}
