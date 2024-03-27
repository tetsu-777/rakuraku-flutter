import 'package:flutter/material.dart';
import 'package:rakuraku_reserve_front/pages/home_page.dart';
import 'package:rakuraku_reserve_front/pages/send_reset_password_mail_page.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

// ログイン画面表示のためのクラス
class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  _LoginPageState createState() => _LoginPageState();
}

// 画面表示内容
// メールアドレス、パスワードの入力内容をPOSTする
// ログインボタン押下時、loginメソッドでログイン処理する
class _LoginPageState extends State<LoginPage> {
  late TextEditingController _emailController;
  late TextEditingController _passwordController;
  // パスワード表示非表示フラグ
  bool _isObscure = true;

  // 入力内容取得のためのコントローラーinitメソッド
  @override
  void initState() {
    super.initState();
    _emailController = TextEditingController();
    _passwordController = TextEditingController();
  }

  // 入力内容取得のためのコントローラーdisposeメソッド
  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  // 画面表示context指定メソッド
  // 入力内容：メールアドレス、パスワード
  @override
  Widget build(BuildContext context) {
    const _formKey=GlobalObjectKey<FormState>('LOGIN_FORM_KEY');

    return Scaffold(
      appBar: AppBar(
        title: const Text('ログイン画面'),
        backgroundColor: Colors.deepOrange[300],
      ),
      body: Center(
        child: Form(
          key:_formKey,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                margin: const EdgeInsets.all(20),
                // メールアドレス入力フォーム
                child: TextFormField(
                  controller: _emailController,
                  validator: (value){
                    // メールアドレス形式の正規表現
                    final emailPattern = RegExp(r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$');
                    if(value == null || value.isEmpty){
                      return 'メールアドレスを入力してください';
                    }
                    if(!emailPattern.hasMatch(value)){
                      return 'メールアドレス形式で入力してください';
                    }
                    return null;
                  },
                  decoration: const InputDecoration(
                    label: Text('メールアドレス'),
                    fillColor: Colors.black,
                  ),
                ),
              ),
              Container(
                margin: const EdgeInsets.all(20),
                // パスワード入力フォーム
                child: TextFormField(
                  controller: _passwordController,
                  validator: (value){
                    if(value == null || value.isEmpty){
                      return 'パスワードを入力してください';
                    }
                    return null;
                  },
                  obscureText: _isObscure,
                  decoration: InputDecoration(
                    label: Text('パスワード'),
                    // パスワード表示非表示実装
                    // アイコン押下で_isObscureが反転する
                    suffixIcon: IconButton(
                      icon: Icon(_isObscure ? Icons.visibility_off : Icons.visibility),
                      onPressed: () {
                        setState(() => _isObscure = !_isObscure
                        );
                      },
                    )
                  ),
                ),
              ),
              // ログインボタン
              // 押下時、ログイン処理する
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  foregroundColor: Colors.white,
                  backgroundColor: Colors.deepOrange[300],
                ),
                onPressed: (){
                  if(_formKey.currentState!.validate()){
                    login(_emailController.text,_passwordController.text);
                  }
                },
                child: const Text('ログイン'),
              ),
              TextButton(
                onPressed:(){
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => SendResetPasswordMailPage()),
                    );
                },
                child: Text('パスワードを忘れた場合'),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // ログイン処理のためのメソッド
  // 入力されたメールアドレス、パスワードをBodyに入れPOST処理する
  // ログイン成功時、200ステータスが返る
  // Cookieにsession_idが格納される
  Future<void> login(String email,password) async{
  final url = Uri.parse('http://localhost:8080/api/login');
  Map<String, String> headers = {'content-type': 'application/json'};
  final response = await http.post(url, headers: headers,body: json.encode({
        'email': email,
        'password': password
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
        content: Text('ログインに失敗しました'),
        backgroundColor: Colors.red,
      ),
    );
  }
}
}