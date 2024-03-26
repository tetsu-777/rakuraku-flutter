import 'package:flutter/material.dart';
import 'package:rakuraku_reserve_front/pages/home_page.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  late TextEditingController _emailController;
  late TextEditingController _passwordController;

  @override
  void initState() {
    super.initState();
    _emailController = TextEditingController();
    _passwordController = TextEditingController();
  }

    @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

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
                controller: _emailController,
                decoration: const InputDecoration(
                  label: Text('メールアドレス'),
                  fillColor: Colors.black,
                ),
              ),
            ),
            Container(
              margin: const EdgeInsets.all(20),
              child: TextFormField(
                controller: _passwordController,
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
              onPressed: ()=>login(_emailController.text,_passwordController.text)
              // () {
                // Navigator.push(
                //   context,
                //   MaterialPageRoute(builder: (context) => HomePage()),
                // );
              // }
              ,
              child: const Text('ログイン'),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> login(String email,password) async{
  final url = Uri.parse('http://localhost:8080/api/login');
  Map<String, String> headers = {'content-type': 'application/json'};
  final response = await http.post(url, headers: headers,body: json.encode({
        'email': email,
        'password': password
      }));
  if(response.statusCode == 200){
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => HomePage()),
      );
  }
  else{
    print('postが失敗しました');
    // ScaffoldMessenger.of(context).showSnackBar(
    //     SnackBar(
    //       content: Text('Failed to send POST request'),
    //     ),);
  }
}
}