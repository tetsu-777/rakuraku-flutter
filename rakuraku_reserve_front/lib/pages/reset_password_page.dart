import 'package:flutter/material.dart';
import 'package:rakuraku_reserve_front/pages/home_page.dart';
import 'package:rakuraku_reserve_front/pages/send_reset_password_mail_page.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

// パスワードリセット画面表示のためのクラス
class ResetPasswordPage extends StatefulWidget {
  const ResetPasswordPage({Key? key}) : super(key: key);

  @override
  _ResetPasswordPageState createState() => _ResetPasswordPageState();
}

// 画面表示内容
// メールで送信されたパスワード、確認用パスワード,トークンの入力内容をPOSTする
// パスワード再設定ボタン押下時、resetPasswordメソッドでログイン処理する
class _ResetPasswordPageState extends State<ResetPasswordPage> {
  late TextEditingController _passwordController;
  late TextEditingController _confirmPasswordController;
  late TextEditingController _tokenController;
  // パスワード・確認用パスワード表示非表示フラグ
  bool _isPasswordObscure = true;
  bool _isConfirmPasswordObscure = true;

  // 入力内容取得のためのコントローラーinitメソッド
  @override
  void initState() {
    super.initState();
    _passwordController = TextEditingController();
    _confirmPasswordController = TextEditingController();
    _tokenController = TextEditingController();
  }

  // 入力内容取得のためのコントローラーdisposeメソッド
  @override
  void dispose() {
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    _tokenController.dispose();
    super.dispose();
  }

  // 画面表示context指定メソッド
  // 入力内容：パスワード、確認用パスワード,トークン
  @override
  Widget build(BuildContext context) {
    const _formKey=GlobalObjectKey<FormState>('RESET_PASSWORD_FORM_KEY');

    return Scaffold(
      appBar: AppBar(
        title: const Text('パスワード再設定画面'),
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
                // パスワード入力フォーム
                child: TextFormField(
                  controller: _passwordController,
                  validator: (value){
                    // 空文字バリデーション
                    if(value == null || value.isEmpty){
                      return 'パスワードを入力してください';
                    }
                    return null;
                  },
                  obscureText: _isPasswordObscure,
                  decoration: InputDecoration(
                    label: Text('パスワード'),
                    // パスワード表示非表示実装
                    // アイコン押下で_isPasswordObscureが反転する
                    suffixIcon: IconButton(
                      icon: Icon(_isPasswordObscure ? Icons.visibility_off : Icons.visibility),
                      onPressed: () {
                        setState(() => _isPasswordObscure = !_isPasswordObscure
                        );
                      },
                    ),
                    fillColor: Colors.black,
                  ),
                ),
              ),
              Container(
                margin: const EdgeInsets.all(20),
                // 確認用パスワード入力フォーム
                child: TextFormField(
                  controller: _confirmPasswordController,
                  validator: (value){
                    // 空文字バリデーション
                    if(value == null || value.isEmpty){
                      return '確認用パスワードを入力してください';
                    }
                    if(value != _passwordController.text){
                      return 'パスワードと確認用パスワードが一致しません';
                    }
                    return null;
                  },
                  obscureText: _isConfirmPasswordObscure,
                  decoration: InputDecoration(
                    label: Text('確認用パスワード'),
                    // 確認用パスワード表示非表示実装
                    // アイコン押下で_isConfirmPasswordObscureが反転する
                    suffixIcon: IconButton(
                      icon: Icon(_isConfirmPasswordObscure ? Icons.visibility_off : Icons.visibility),
                      onPressed: () {
                        setState(() => _isConfirmPasswordObscure = !_isConfirmPasswordObscure
                        );
                      },
                    ),
                    fillColor: Colors.black,
                  ),
                ),
              ),
              Container(
                margin: const EdgeInsets.all(20),
                // トークン入力フォーム
                child: TextFormField(
                  controller: _tokenController,
                  validator: (value){
                    if(value == null || value.isEmpty){
                      return 'メールで送信されたトークンを入力してください';
                    }
                    return null;
                  },
                  decoration: InputDecoration(
                    label: Text('トークン'),
                  ),
                ),
              ),
              // パスワード再設定ボタン
              // 押下時、パスワード再設定処理する
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  foregroundColor: Colors.white,
                  backgroundColor: Colors.deepOrange[300],
                ),
                onPressed: (){
                  if(_formKey.currentState!.validate()){
                    resetPassword(_passwordController.text,_confirmPasswordController.text,_tokenController.text);
                  }
                },
                child: const Text('パスワード再設定する'),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // パスワード再設定処理のためのメソッド
  // 入力されたパスワード、確認用パスワード,トークンをBodyに入れPOST処理する
  // パスワード再設定処理成功時、200ステータスが返る
  Future<void> resetPassword(String password,confirmPassword,token) async{
  final url = Uri.parse('http://localhost:8080/api/users/reset-password');
  Map<String, String> headers = {'content-type': 'application/json'};
  final response = await http.post(url, headers: headers,body: json.encode({
        'password_token': token,
        'password': password,
        'confirmation_password':confirmPassword
      }));
  // パスワード再設定処理成功時、ホームページに遷移する
  // 失敗時、エラーメッセージを表示する
  if(response.statusCode == 200){
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => HomePage()),
      );
  }else{
    // パスワード再設定処理処理失敗時、SnackBar（画面下にエラー文表示）を出力する
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('パスワードの変更に失敗しました'),
        backgroundColor: Colors.red,
      ),
    );
  }
}
}