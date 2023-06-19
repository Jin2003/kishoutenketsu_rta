import 'package:flutter/material.dart';
import 'package:kishoutenketsu_rta/logic/nav_bar.dart';
import 'package:kishoutenketsu_rta/view/constant.dart';
import 'package:kishoutenketsu_rta/view/pages/components/custom_text.dart';
import 'package:kishoutenketsu_rta/view/pages/email_set_page.dart';
import 'package:kishoutenketsu_rta/view/pages/nickname_set_page.dart';
import 'package:kishoutenketsu_rta/view/pages/pwd_set_page.dart';

class AccountSetPage extends StatefulWidget {
  const AccountSetPage({super.key});

  @override
  State<AccountSetPage> createState() => _AccountSetPageState();
}

class _AccountSetPageState extends State<AccountSetPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Constant.white,
      body: Column(
        children: [
          SizedBox(
            height: 40,
          ),
          // × のアイコン表示
          Align(
              alignment: Alignment(-0.9, 0),
              child: IconButton(
                iconSize: 20,
                icon: ImageIcon(
                  AssetImage('assets/icon/close_icon.png'),
                  color: Constant.gray,
                ),
                onPressed: () async {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: ((context) => NavBar())),
                  );
                },
              )),

          CustomText(text: 'アカウント設定', fontSize: 22, Color: Constant.gray),
          SizedBox(height: 20),
          Container(
            width: 380,
            decoration: BoxDecoration(
              border:
                  Border(bottom: BorderSide(color: Constant.gray, width: 2)),
            ),
          ),
          SizedBox(height: 10),
          _ListTileWidget(context, 'ニックネーム' , 'Fuuma', NicknameSetPage()),
          _ListTileWidget(context, 'メールアドレス' , 'fuuma@masa.hiro', EmailSetPage()),
          _ListTileWidget(context, 'パスワード' , '●●●●●●', PwdSetPage()),
        ],
      ),
    );
  }
}

// ListTileを表示するウィジェット
Widget _ListTileWidget(context, String title, String currentSetting, Widget nextPage) {
  return Container(
    width: 380,
    child: ListTile(
      contentPadding: EdgeInsets.only(top: 10, left: 20, right: 20, bottom: 10),
      title: Align(
          alignment: Alignment(-0.9, 0),
          child:
              CustomText(text: title, fontSize: 16, Color: Constant.gray)),
      subtitle: Align(
          alignment: Alignment(-0.9, 0),
          child: CustomText(text: currentSetting, fontSize: 23, Color: Constant.gray)),
      trailing: ImageIcon(
        AssetImage('assets/icon/r_arrow_icon.png'),
        color: Constant.gray,
      ),
      onTap: () async {
        Navigator.push(
          context,
          MaterialPageRoute(builder: ((context) => nextPage)),
        );
      },
    ),
  );
}
