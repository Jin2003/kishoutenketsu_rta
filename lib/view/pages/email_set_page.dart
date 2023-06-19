import 'package:flutter/material.dart';
import 'package:kishoutenketsu_rta/view/pages/account_set_page.dart';

import '../../logic/nav_bar.dart';
import '../constant.dart';
import 'components/custom_text.dart';
import 'components/outline_button.dart';

class EmailSetPage extends StatefulWidget {
  const EmailSetPage({super.key});

  @override
  State<EmailSetPage> createState() => _EmailSetPageState();
}

class _EmailSetPageState extends State<EmailSetPage> {
  @override
  Widget build(BuildContext context) {
    TextEditingController emailController = TextEditingController();

    return Scaffold(
      backgroundColor: Constant.white,
      body: Column(
        children: [
          SizedBox(
            height: 40,
          ),
          // < のアイコン表示
          Align(
            alignment: Alignment(-0.9, 0),
            child: IconButton(
              iconSize: 22,
              icon: ImageIcon(
                AssetImage('assets/icon/l_arrow_icon.png'),
                color: Constant.gray,
              ),
              onPressed: () async {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: ((context) => AccountSetPage())),
                );
              },
            ),
          ),

          CustomText(text: 'メールアドレス', fontSize: 22, Color: Constant.gray),
          SizedBox(height: 20),
          Container(
            width: 380,
            decoration: BoxDecoration(
              border:
                  Border(bottom: BorderSide(color: Constant.gray, width: 2)),
            ),
          ),

          Column(
            children: [
              // メールアドレス
              SizedBox(height: 30),
              Align(
                alignment: Alignment(-0.5,0),
                child: CustomText(
                  text: 'メールアドレス',
                  fontSize: 16,
                  Color: Constant.gray,
                ),
              ),

              SizedBox(
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
                      borderSide: BorderSide(
                        color: Constant.gray,
                      ),
                    ),
                    labelText: 'email-address',
                    //TODO: アイコン表示上手くいかん
                    // suffixIcon:  ImageIcon(
                    //   AssetImage('assets/icon/circle_close_icon.png'),
                    //   color: Constant.gray,
                    //   size: 5,
                    // ),
                  ),
                ),
              ),
              SizedBox(height: 20,),
              OutlineButton(
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
