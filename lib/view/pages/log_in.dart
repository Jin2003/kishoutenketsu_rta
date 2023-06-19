import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:kishoutenketsu_rta/logic/nav_bar.dart';
import 'package:kishoutenketsu_rta/view/constant.dart';
import 'package:kishoutenketsu_rta/view/pages/sign_up.dart';
import 'package:kishoutenketsu_rta/view/pages/use_select.dart';
import '../constant.dart';
import 'components/custom_text.dart';
import 'components/elevate_button.dart';

class LogIn extends StatefulWidget {
  const LogIn({super.key});

  @override
  State<LogIn> createState() => _LogInState();
}

class _LogInState extends State<LogIn> {
  // コントローラーから入力値を取得
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
          Positioned.fill(
            child: Image.asset(
              "assets/log_in.png",
              fit: BoxFit.cover,
            ),
          ),
          Center(
            child: Padding(
              padding: const EdgeInsets.all(50),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  // メールアドレス
                  const CustomText(
                    text: 'メールアドレス',
                    fontSize: 20,
                    Color: Constant.gray,
                  ),

                  const SizedBox(
                    width: 100,
                    height: 10,
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
                  const CustomText(
                    text: 'パスワード',
                    fontSize: 20,
                    Color: Constant.gray,
                  ),
                  const SizedBox(
                    width: 100,
                    height: 10,
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
                        border: const OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(10)),
                          borderSide: BorderSide.none,
                        ),
                        // TextFieldの表示非表示
                        suffixIcon: isDisplay != true
                            ? IconButton(
                                icon: const Icon(Icons.visibility),
                                onPressed: () {
                                  setState(() {
                                    isDisplay = !isDisplay;
                                  });
                                },
                              )
                            : IconButton(
                                icon: const Icon(Icons.visibility_off),
                                onPressed: () {
                                  setState(() {
                                    isDisplay = !isDisplay;
                                  });
                                },
                              ),
                      ),
                    ),
                  ),

                  // ログインボタン
                  ElevateButton(
                    title: "ログイン",
                    width: 180,
                    height: 53,
                    fontSize: 20,
                    shape: 16,
                    onPressed: () async {
                      //　TODO;アカウントがあればmain_page、なければselect_pageに移行
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: ((context) => NavBar()!)),
                      );
                    },
                  ),

                  const SizedBox(
                    height: 40,
                    width: 100,
                  ),
                ],
              ),
            ),
          ),

          // 新規登録ページへ移行
          // Stackなら言うこと聞くのにColumnなら指定の位置行ってくれない
          Stack(
            children: [
              const Align(
                alignment: Alignment(0, 0.5),
                child: CustomText(
                    text: 'アカウントをお持ちでない方', fontSize: 16, Color: Constant.gray),
              ),
              Align(
                alignment: Alignment(0, 0.59),
                child: TextButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: ((context) => SignUp()!)),
                    );
                  },
                  child: Text(
                    '新規登録',
                    style: GoogleFonts.zenMaruGothic(
                      fontSize: 20,
                      fontWeight: FontWeight.w900,
                      color: Constant.accentYellow,
                    ),
                  ),
                ),
              ),

              // デバック用
              Align(
                alignment: Alignment(0,0.8),
                child: ElevateButton(title: 'select_page', shape: 16, fontSize: 20, width: 200, height: 40, nextPage: UseSelect(),),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
