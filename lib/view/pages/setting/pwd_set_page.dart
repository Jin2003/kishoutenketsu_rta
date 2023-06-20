import 'package:flutter/material.dart';

import '../../constant.dart';
import 'account_set_page.dart';
import '../components/custom_text.dart';
import '../components/outline_button.dart';

class PwdSetPage extends StatefulWidget {
  const PwdSetPage({super.key});

  @override
  State<PwdSetPage> createState() => _PwdSetPageState();
}

class _PwdSetPageState extends State<PwdSetPage> {
  @override
  Widget build(BuildContext context) {

    TextEditingController pwdController = TextEditingController();
    // password 表示非表示の切り替え
    bool isDisplay = false;

    return Scaffold(
      backgroundColor: Constant.white,
      body: Column(
        children: [
          const SizedBox(
            height: 40,
          ),
          // < のアイコン表示
          Align(
            alignment: const Alignment(-0.9, 0),
            child: IconButton(
              iconSize: 22,
              icon: const ImageIcon(
                AssetImage('assets/icon/l_arrow_icon.png'),
                color: Constant.gray,
              ),
              onPressed: () async {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: ((context) => const AccountSetPage())),
                );
              },
            ),
          ),

          const CustomText(text: 'パスワード', fontSize: 22, Color: Constant.gray),
          const SizedBox(height: 20),
          Container(
            width: 380,
            decoration: const BoxDecoration(
              border:
                  Border(bottom: BorderSide(color: Constant.gray, width: 2)),
            ),
          ),

          Column(
            children: [
              // パスワード
              const SizedBox(height: 30),
              const Align(
                alignment: Alignment(-0.5,0),
                child: CustomText(
                  text: 'パスワード',
                  fontSize: 16,
                  Color: Constant.gray,
                ),
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
                      controller: pwdController,
                      obscureText: isDisplay,
                      decoration: InputDecoration(
                        filled: true,
                        fillColor: Constant.white,
                        border: const OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(10)),
                          borderSide: BorderSide(color: Constant.gray),
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
              const SizedBox(height: 20,),
              const OutlineButton(
                title: '保存',
                width: 170,
                height: 50,
                fontsize: 20,
                shape: 15,
                nextPage: AccountSetPage(),
              ),
            ],
          ),
          
        ],
      ),
    );
  }
}
