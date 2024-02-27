import 'package:flutter/material.dart';
import 'package:rakuraku_reserve_front/pages/home_page.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('ログイン画面'),
        backgroundColor: Colors.deepOrange[300],
      ),
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              margin: const EdgeInsets.all(20),
              child: TextFormField(
                decoration: const InputDecoration(
                  label: Text('メールアドレス'),
                  fillColor: Colors.black,
                ),
              ),
            ),
            Container(
              margin: const EdgeInsets.all(20),
              child: TextFormField(
                decoration: const InputDecoration(
                  label: Text('パスワード'),
                ),
              ),
            ),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                foregroundColor: Colors.white,
                backgroundColor: Colors.deepOrange[300],
              ),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => HomePage()),
                );
              },
              child: const Text('ログイン'),
            ),
          ],
        ),
      ),
    );
  }
}
