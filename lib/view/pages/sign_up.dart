import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../logic/nav_bar.dart';
import '../constant.dart';
import 'components/custom_text.dart';
import 'components/elevate_button.dart';
import 'log_in.dart';

class SignUp extends StatefulWidget {
  const SignUp({super.key});

  @override
  State<SignUp> createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  TextEditingController userNameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  // password 表示非表示の切り替え
  bool isDisplay = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Constant.subYellow,
      body: Stack(
        children: [
          //　背景画像
          Positioned.fill(
            child: Image.asset(
              "assets/sign_up.png",
              fit: BoxFit.cover,
            ),
          ),
          Center(
            child: Padding(
              padding: const EdgeInsets.all(50),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  // ユーザーネーム
                  CustomText(text: 'ユーザーネーム', fontSize: 20, Color: Constant.gray,),
                  
                  const SizedBox(
                    width: 100,
                    height: 8,
                  ),

                  // ユーザーネーム入力フィールド
                  SizedBox(
                    width: 270,
                    height: 80,
                    child: TextField(
                      controller: userNameController,
                      decoration: const InputDecoration(
                          filled: true,
                          fillColor: Constant.white,
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.all(Radius.circular(10)),
                            borderSide: BorderSide.none,
                          ),
                          labelText: ''),
                    ),
                  ),
                  // メールアドレス
                  CustomText(text: 'メールアドレス', fontSize: 20, Color: Constant.gray,),
                  
                  const SizedBox(
                    width: 100,
                    height: 8,
                  ),

                  // メールアドレス入力フィールド
                  SizedBox(
                    width: 270,
                    height: 80,
                    child: TextField(
                      controller: emailController,
                      decoration: const InputDecoration(
                          filled: true,
                          fillColor: Constant.white,
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.all(Radius.circular(10)),
                            borderSide: BorderSide.none,
                          ),
                          labelText: 'sample@'),
                    ),
                  ),

                  // パスワード
                  CustomText(text: 'パスワード', fontSize: 20, Color: Constant.gray,),
                  const SizedBox(
                    width: 100,
                    height: 8,
                  ),
                  // パスワード入力フィールド
                  SizedBox(
                    width: 270,
                    height: 100,
                    child: TextField(
                      controller: passwordController,
                      obscureText: isDisplay,
                      decoration: InputDecoration(
                          filled: true,
                          fillColor: Constant.white,
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.all(Radius.circular(10)),
                            borderSide: BorderSide.none,
                          ),
                          // TextFieldの表示非表示
                          suffixIcon: isDisplay != true
                            ? IconButton(
                                icon: Icon(Icons.visibility),
                                onPressed: () {
                                  setState(() {
                                    isDisplay = !isDisplay;
                                  });
                                },
                              )
                            : IconButton(
                                icon: Icon(Icons.visibility_off),
                                onPressed: () {
                                  setState(() {
                                    isDisplay = !isDisplay;
                                  });
                                },
                              ),
                      ),
                    ),
                  ),
                  
                  // 登録ボタン
                  ElevateButton(
                    title: "新規登録",
                    width: 180,
                    height: 53,
                    fontSize: 20,
                    shape: 16,
                    onPressed: () async {
                      // TODO: データを保存
                      // Navbar経由でloginページへ
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: ((context) => LogIn()!)),
                      );
                    },
                  ),

                  const SizedBox(height: 15, width: 100,),
                ],
              ),
            ),
          ),

          // ログインページへ移行
          // TODO: alignで固定させてる→テキスト入力の時画面くずれる
          // Stackなら言うこと聞くのにColumnなら指定の位置行ってくれない
          Stack(
            children: [
              Align(
                alignment: Alignment(0,0.65),
                child: CustomText(text: 'アカウントをお持ちの方', fontSize: 16, Color: Constant.gray),
              ),
              Align(
                alignment: Alignment(0,0.75),
                child: TextButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: ((context) => LogIn()!)),
                  );
                },
                child: Text(
                  'ログイン',
                  style: GoogleFonts.zenMaruGothic(
                    fontSize: 20,
                    fontWeight: FontWeight.w900,
                    color: Constant.accentYellow,
                  ),
                ),
              ),
              ),
            ],

          ),
        ],
      ),
    );
  }
}