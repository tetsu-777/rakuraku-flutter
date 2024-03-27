import 'package:flutter/material.dart';
import 'package:rakuraku_reserve_front/pages/home_page.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class SendResetPasswordMailPage extends StatefulWidget {
  const SendResetPasswordMailPage({super.key});

  @override
  State<SendResetPasswordMailPage> createState() => _SendResetPasswordMailPageState();
}

class _SendResetPasswordMailPageState extends State<SendResetPasswordMailPage>  {
  late TextEditingController _emailController;

    // 入力内容取得のためのコントローラーinitメソッド
  @override
  void initState() {
    super.initState();
    _emailController = TextEditingController();
  }

  // 入力内容取得のためのコントローラーdisposeメソッド
  @override
  void dispose() {
    _emailController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    const _formKey=GlobalObjectKey<FormState>('SEND_RESET_PASSWORD_EMAIL_FORM_KEY');

    return Scaffold(
      appBar: AppBar(
        title: const Text('パスワード再設定メール送信画面'),
        backgroundColor: Colors.deepOrange[300],
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: Center(
        child: Form(
          key:_formKey,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                margin: const EdgeInsets.all(20),
                // トークン送信するメールアドレス入力フォーム
                child: TextFormField(
                  controller: _emailController,
                  validator: (value){
                    // メールアドレス形式の正規表現
                    final emailPattern = RegExp(r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$');
                    if(value == null || value.isEmpty || !emailPattern.hasMatch(value)){
                      return 'パスワーそ再設定の案内を受け取る\nメールアドレスを入力してください';
                    }
                    return null;
                  },
                  decoration: const InputDecoration(
                    label: Text('メールアドレス'),
                    fillColor: Colors.black,
                  ),
                ),
              ),
              // メール送信ボタン
              // 押下時、メール送信処理する
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  foregroundColor: Colors.white,
                  backgroundColor: Colors.deepOrange[300],
                ),
                onPressed: (){
                  if(_formKey.currentState!.validate()){
                    sendResetPasswordEmail(_emailController.text);
                  }
                },
                child: const Text('パスワード再設定メールを送信する'),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // パスワード再設定メール送信するためのメソッド
  // 入力されたメールアドレスをBodyに入れPOST処理する
  // メール送信成功時、200ステータスが返る
  Future<void> sendResetPasswordEmail(String email) async{
    final url = Uri.parse('http://localhost:8080/api/users/forgot-password');
    Map<String, String> headers = {'content-type': 'application/json'};
    final response = await http.post(url, headers: headers,body: json.encode({
          'email': email,
        }));
    // ログイン成功時、ホームページに遷移する
    // 失敗時、エラーメッセージを表示する
    if(response.statusCode == 200){
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => HomePage()),
        );
    }else{
      // ログイン処理失敗時、SnackBar（画面下にエラー文表示）を出力する
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('パスワード再設定メールの送信に失敗しました'),
          backgroundColor: Colors.red,
        ),
      );
    }
  }
}