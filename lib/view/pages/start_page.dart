import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:kishoutenketsu_rta/view/pages/components/custom_text_blue.dart';
import 'dart:async';

import '../constant.dart';
import 'components/f-action_button.dart';
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
    // nfcが登録されてるか確認

    // if (){
    //   // 登録があった場合
    //   return _logoWidget(context, Navigate());
    // } else {
    //   // 登録がなかった場合
    return _logoWidget(context, NfcSettingPage());
    // },
  }

  // ロゴを表示するウィジェト
  Widget _logoWidget(BuildContext context, Widget? nextPage) {
    return Scaffold(
        backgroundColor: Constant.mainColor,
        body: Stack(
          children: [
            Positioned.fill(
              child: Image.asset(
                "assets/start_page.png",
                fit: BoxFit.cover,
              ),
            ),
            //floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
          ],
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
        floatingActionButton: FactionButton(
          title: 'はじめる',
          fontSize: 23,
          width: 180,
          height: 60,
          nextPage: nextPage,
        ));
  }
}
