import 'package:flutter/material.dart';
import 'package:rakuraku_reserve_front/pages/reset_password_page.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

// パスワード再設定メール送信画面
class SendResetPasswordMailPage extends StatefulWidget {
  const SendResetPasswordMailPage({super.key});

  @override
  State<SendResetPasswordMailPage> createState() => _SendResetPasswordMailPageState();
}

class _SendResetPasswordMailPageState extends State<SendResetPasswordMailPage>  {
  late TextEditingController _emailController;
  bool _loading = false;

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

  // パスワード再設定メール画面表示context指定メソッド
  // 入力内容：メールアドレス
  @override
  Widget build(BuildContext context) {
    const _formKey=GlobalObjectKey<FormState>('SEND_RESET_PASSWORD_EMAIL_FORM_KEY');

    return Scaffold(
      appBar: AppBar(
        title: const Text('パスワード再設定\nメール送信画面'),
        backgroundColor: Colors.deepOrange[300],
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: Stack(
        children: [
          Center(
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
        if (_loading) // ローディング状態が true の場合、ローディングダイアログを表示
          Container(
            color: Colors.black.withOpacity(0.5), // 半透明の黒色の背景
            child: Center(
              child: CircularProgressIndicator(), // ローディングアイコン
            ),
          ),
        ],
      ),
    );
  }

  // パスワード再設定メール送信するためのメソッド
  // 入力されたメールアドレスをBodyに入れPOST処理する
  // メール送信成功時、200ステータスが返る
  Future<void> sendResetPasswordEmail(String email) async{
<<<<<<< HEAD
    final url = Uri.parse('http://localhost:8080/api/users/forgot-password');
    Map<String, String> headers = {'content-type': 'application/json'};
    final response = await http.post(url, headers: headers,body: json.encode({
          'email': email,
        }));
    // パスワード再設定メール送信成功時、ホームページに遷移する
    // 失敗時、エラーメッセージを表示する
    if(response.statusCode == 200){
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => ResetPasswordPage()),
=======
    // ローディング開始
    setState(() {
      _loading = true;
    });

    try{
      final url = Uri.parse('http://localhost:8080/api/users/forgot-password');
      Map<String, String> headers = {'content-type': 'application/json'};
      final response = await http.post(url, headers: headers,body: json.encode({
            'email': email,
          }));
      // パスワード再設定メール送信成功時、ホームページに遷移する
      // 失敗時、エラーメッセージを表示する
      if(response.statusCode == 200){
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => HomePage()),
          );
      }else{
        // パスワード再設定メール送信失敗時、SnackBar（画面下にエラー文表示）を出力する
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('パスワード再設定メールの送信に失敗しました'),
            backgroundColor: Colors.red,
          ),
>>>>>>> 7-send_change_password_email
        );
      }
    }finally{
      setState(() {
        _loading = false; // ローディング終了
      });
    }
  }
}