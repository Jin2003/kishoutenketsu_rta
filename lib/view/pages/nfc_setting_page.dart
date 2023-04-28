
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:kishoutenketsu_rta/logic/nav_bar.dart';
import 'package:kishoutenketsu_rta/view/pages/components/custom_text_blue.dart';
import 'package:kishoutenketsu_rta/view/pages/components/custom_text_white.dart';
import 'package:kishoutenketsu_rta/view/pages/components/elevate_button.dart';
import 'package:kishoutenketsu_rta/view/pages/start_page.dart';

import '../../logic/nav_bar.dart';
import '../constant.dart';
import 'components/outline_button.dart';

class NfcSettingPage extends StatefulWidget {
  const NfcSettingPage({super.key});

  @override
  State<NfcSettingPage> createState() => _NfcSettingPageState();
}

class _NfcSettingPageState extends State<NfcSettingPage> {
  // タグ名
  final List<String> tagname = ["起", "床", "点", "結", "RTA"];
  //int a = tagname.length;

  // タグ番号
  int tag_count = 0;

  @override
  Widget build(BuildContext context) {
    // 0,1,2,3,4,  5
    if (tag_count >= tagname.length) {
      EndSet();
    }
    

    String tag_name = tagname[tag_count];

    return Scaffold(
      backgroundColor: Constant.mainColor,
      body: Stack(
        children: [
          Center(
            child: Container(
              child: CustomTextWhite(
                  text: '[$tag_name]のボタンを\n壁に取り付け\nタッチしてください', fontSize: 30),
            ),
          ),
          Align(
            alignment: const Alignment(0.0, 0.4),
            child: //OutlineButton(title: 'nfcスキャンできたら', width: 250, height: 70, fontsize: 20, shape: 60),
                SizedBox(
              width: 250,
              height: 70,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Constant.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(60),
                  ),
                ),
                onPressed: () {
                  showDialog<void>(
                      context: context,
                      builder: (_) {
                        return Dialog();
                      });
                  setState(() {
                    tag_count++;
                  });
                },
                child: CustomTextBlue(
                  text: 'nfcスキャンできたら',
                  fontSize: 20,
                ),
              ),
            ),
          ),
          Align(
            alignment: const Alignment(0.0, 0.6),
            child: //OutlineButton(title: 'nfcスキャンできたら', width: 250, height: 70, fontsize: 20, shape: 60),
                SizedBox(
              width: 250,
              height: 70,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Constant.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(60),
                  ),
                ),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: ((context) => NavBar()!)),
                  );
                },
                child: CustomTextBlue(
                  text: 'main',
                  fontSize: 20,
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}

class Dialog extends StatelessWidget {
  const Dialog({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SimpleDialog(
      children: [
        const SizedBox(
          height: 40,
        ),
        const Align(
          alignment: Alignment.center,
          child: CustomTextBlue(text: 'スキャン完了！', fontSize: 25),
        ),
        Padding(
          padding:
              const EdgeInsets.only(top: 20, left: 50, right: 50, bottom: 40),
          child: Container(
            child: OutlineButton(
              title: 'とじる',
              width: 50,
              height: 50,
              shape: 10,
              fontsize: 17,
              onPressed: () => Navigator.pop(context),
            ),
          ),
        ),
      ],
    );
  }
}

class EndSet extends StatelessWidget {
  const EndSet({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SimpleDialog(
      children: [
        const SizedBox(
          height: 40,
        ),
        const Align(
          alignment: Alignment.center,
          child: CustomTextBlue(text: '設定が完了しました！', fontSize: 25),
        ),
        Padding(
          padding:
              const EdgeInsets.only(top: 20, left: 50, right: 50, bottom: 40),
          child: Container(
            child: OutlineButton(
              title: 'とじる',
              width: 50,
              height: 50,
              shape: 10,
              fontsize: 17,
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: ((context) => NavBar()!)),
                );
              },
            ),
          ),
        ),
      ],
    );
  }
}

