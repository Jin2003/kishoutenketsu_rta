import 'package:flutter/material.dart';
import 'package:kishoutenketsu_rta/view/pages/setting/account_set_page.dart';
import '../../constant.dart';
import '../components/custom_text.dart';
import '../components/outline_button.dart';

class NicknameSetPage extends StatefulWidget {
  const NicknameSetPage({super.key});

  @override
  State<NicknameSetPage> createState() => _NicknameSetPageState();
}

class _NicknameSetPageState extends State<NicknameSetPage> {
  @override
  Widget build(BuildContext context) {

  // コントローラーから入力値を取得
  TextEditingController nicknameController = TextEditingController();

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
                  MaterialPageRoute(builder: ((context) =>  const AccountSetPage())),
                );
              },
            ),
          ),

          const CustomText(text: 'ニックネーム', fontSize: 22, Color: Constant.gray),
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
              // ニックネーム
              const SizedBox(height: 30),
              const Align(
                alignment: Alignment(-0.5,0),
                child: CustomText(
                  text: 'ニックネーム',
                  fontSize: 16,
                  Color: Constant.gray,
                ),
              ),

              const SizedBox(
                width: 100,
                height: 10,
              ),

              // ニックネーム入力フィールド
              SizedBox(
                width: 270,
                height: 80,
                child: TextField(
                  controller: nicknameController,
                  decoration: const InputDecoration(
                    filled: true,
                    fillColor: Constant.white,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(10)),
                      borderSide: BorderSide(
                        color: Constant.gray,
                      ),
                    ),
                    //　TODO： ここはlabelじゃなくてplaceholderみたいにしたい
                    labelText: 'nickname',
                    //TODO: アイコン表示上手くいかん
                    // suffixIcon:  ImageIcon(
                    //   AssetImage('assets/icon/circle_close_icon.png'),
                    //   color: Constant.gray,
                    //   size: 5,
                    // ),
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
