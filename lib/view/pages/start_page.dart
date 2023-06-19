import 'package:flutter/material.dart';
import '../../logic/nav_bar.dart';
import '../constant.dart';
import 'components/elevate_button.dart';
import 'log_in.dart';
import 'nfc_setting_page.dart';

class StartPage extends StatefulWidget {
  const StartPage({super.key});

  @override
  State<StartPage> createState() => _StartPageState();
}

class _StartPageState extends State<StartPage> {
  void main() {
    build(context);
    // 画面がついてから2秒後に画面遷移がうまくいかん
    // Future.delayed(Duration(seconds: 2), () {
    //   MaterialPageRoute(builder: ((context) => NfcSettingPage()!));
    // });
  }

  @override
  Widget build(BuildContext context) {
    // nfcが登録されてるか確認  false==登録なし
    bool nfcState = false;

    if (nfcState == true) {
      // 登録があった場合
      return _logoWidget(context, const NavBar());
    } else {
      // 登録がなかった場合
      return _logoWidget(context, const LogIn());
    }
  }

  // ロゴを表示するウィジェト
  Widget _logoWidget(BuildContext context, Widget? nextPage) {
    return Scaffold(
        backgroundColor: Constant.blue,
        body: Stack(
          children: [
            Positioned.fill(
              child: Image.asset(
                "assets/pages/start_page.png",
                fit: BoxFit.cover,
              ),
            ),
            //floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
          ],
        ),
        
        floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
        floatingActionButton: ElevateButton(
          shape: 60,
          title: 'はじめる',
          fontSize: 23,
          width: 190,
          height: 60,
          nextPage: nextPage,
        ));

  }
}
