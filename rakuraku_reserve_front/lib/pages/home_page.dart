import 'package:flutter/material.dart';
import 'package:rakuraku_reserve_front/pages/equipment_list_page.dart';
import 'package:rakuraku_reserve_front/pages/event_list_page.dart';
import 'package:rakuraku_reserve_front/pages/my_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _currntIndex = 0;

  // 画面のリスト
  final List<Widget> _pages = [
    EquipmentListPage(),
    EventListPage(),
    MyPage(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('HOME PAGE'),
        backgroundColor: Colors.deepOrange[300],
      ),
      body: _pages[_currntIndex],
      bottomNavigationBar: CustomBottomNavigationBar(
        currentIndex: _currntIndex,
        onTap: (index) {
          setState(() {
            _currntIndex = index;
          });
        },
      ),
    );
  }
}

class CustomBottomNavigationBar extends StatelessWidget {
  final int currentIndex;
  final Function(int) onTap;

  const CustomBottomNavigationBar({
    required this.currentIndex,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      currentIndex: currentIndex,
      onTap: onTap,
      items: const [
        BottomNavigationBarItem(
          icon: Icon(Icons.design_services),
          label: 'Equipments',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.event),
          label: 'Events',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.face),
          label: 'MyPage',
        ),
      ],
    );
  }
}
