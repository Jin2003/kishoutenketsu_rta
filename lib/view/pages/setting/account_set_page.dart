import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:kishoutenketsu_rta/logic/nav_bar.dart';
import 'package:kishoutenketsu_rta/logic/shared_preferences_logic.dart';
import 'package:kishoutenketsu_rta/view/constant.dart';
import 'package:kishoutenketsu_rta/view/pages/components/custom_text.dart';
import 'package:kishoutenketsu_rta/view/pages/setting/email_set_page.dart';
import 'package:kishoutenketsu_rta/view/pages/setting/nickname_set_page.dart';
import 'package:kishoutenketsu_rta/view/pages/setting/pwd_set_page.dart';

class AccountSetPage extends StatefulWidget {
  const AccountSetPage({super.key});

  @override
  State<AccountSetPage> createState() => _AccountSetPageState();
}

class _AccountSetPageState extends State<AccountSetPage> {
  dynamic userData;
  String? userEmail;

  @override
  void initState() {
    super.initState();
    fetchUserData();
  }

  Future<void> fetchUserData() async {
    // ユーザIDを取得
    SharedPreferencesLogic sharedPreferencesLogic = SharedPreferencesLogic();
    final userID = await sharedPreferencesLogic.getUserID();
    final userDoc =
        await FirebaseFirestore.instance.collection('users').doc(userID).get();
    userData = userDoc.data();

    // ユーザーのメールアドレスを取得
    User? user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      userEmail = user.email;
    }
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Constant.white,
      body: Column(
        children: [
          const SizedBox(
            height: 40,
          ),
          // × のアイコン表示
          Align(
              alignment: const Alignment(-0.9, 0),
              child: IconButton(
                iconSize: 20,
                icon: const ImageIcon(
                  AssetImage('assets/icon/close_icon.png'),
                  color: Constant.gray,
                ),
                onPressed: () async {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: ((context) => const NavBar())),
                  );
                },
              )),

          const CustomText(text: 'アカウント設定', fontSize: 22, Color: Constant.gray),
          const SizedBox(height: 20),
          Container(
            width: 380,
            decoration: const BoxDecoration(
              border:
                  Border(bottom: BorderSide(color: Constant.gray, width: 2)),
            ),
          ),
          const SizedBox(height: 10),
          _ListTileWidget(
              context,
              'ニックネーム',
              userData != null ? userData['name'] : '',
              const NicknameSetPage()),
          _ListTileWidget(
              context, 'メールアドレス', userEmail ?? '', const EmailSetPage()),
          _ListTileWidget(context, 'パスワード', '●●●●●●', const PwdSetPage()),
        ],
      ),
    );
  }
}

// ListTileを表示するウィジェット
// ignore: non_constant_identifier_names
Widget _ListTileWidget(
    context, String title, String currentSetting, Widget nextPage) {
  return SizedBox(
    width: 380,
    child: ListTile(
      contentPadding:
          const EdgeInsets.only(top: 10, left: 20, right: 20, bottom: 10),
      title: Align(
          alignment: const Alignment(-0.9, 0),
          child: CustomText(text: title, fontSize: 16, Color: Constant.gray)),
      subtitle: Align(
          alignment: const Alignment(-0.9, 0),
          child: CustomText(
              text: currentSetting, fontSize: 23, Color: Constant.gray)),
      trailing: const ImageIcon(
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
