import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:kishoutenketsu_rta/view/pages/components/custom_text_blue.dart';
import 'package:kishoutenketsu_rta/view/pages/components/custom_text_white.dart';

import '../constant.dart';
import 'components/outline_button.dart';

class NfcSettingPage extends StatefulWidget {
  const NfcSettingPage({super.key});

  @override
  State<NfcSettingPage> createState() => _NfcSettingPageState();
}

class _NfcSettingPageState extends State<NfcSettingPage> {
  @override
  Widget build(BuildContext context) {
    // //遷移後すぐダイアログ表示
    // initState();

    // タグ番号
    int tag_count = 1;

    return Scaffold(
      backgroundColor: Constant.mainColor,
      body: Center(
        child: Container(
          child: CustomTextWhite(
              text: '$tag_count つ目のボタンを\n壁に取り付け\nタッチしてください', fontSize: 30),
        ),
      ),
    );
  }

  void _firstDialog(int index) {
    showDialog(
        context: context,
        builder: (context) {
          return SimpleDialog(
            children: [
              const SizedBox(
                height: 10,
              ),
              const Align(
                alignment: Alignment.center,
                child: CustomTextBlue(text: '５つのボタンの\n置き場所を決めよう', fontSize: 35),
              ),
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: Container(
                  child: OutlineButton(
                    title: 'とじる',
                    width: 150,
                    height: 50,
                    onPressed: () => Navigator.pop(context),
                  ),
                ),
              ),
            ],
          );
        });
  }

  //
  void initState() {
    super.initState();
    Future() {
      WidgetsBinding.instance!.addPostFrameCallback((_) => _showStartDialog() //
              );
    }
  }

  //
  Future<void> _showStartDialog() async {
    return showDialog<void>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: CustomTextBlue(text: '５つのボタンの\n置き場所を決めよう', fontSize: 20),
          // content: CustomTextBlue(text: '５つのボタンの\n置き場所を決めよう', fontSize: 30),
          actions: <Widget>[
            Center(
              child: OutlineButton(
                title: 'とじる',
                width: 150,
                height: 50,
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
            )
          ],
        );
      },
    );
  }
}
