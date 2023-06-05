import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:kishoutenketsu_rta/logic/nav_bar.dart';
import 'package:kishoutenketsu_rta/logic/nfc_scan.dart';
import 'package:kishoutenketsu_rta/view/pages/components/custom_text_blue.dart';
import 'package:kishoutenketsu_rta/view/pages/components/custom_text_white.dart';
import 'package:kishoutenketsu_rta/view/pages/components/elevate_button.dart';
import 'package:kishoutenketsu_rta/view/pages/start_page.dart';
import 'package:uuid/uuid.dart';
import 'package:kishoutenketsu_rta/logic/database_helper.dart';

import '../../logic/nav_bar.dart';
import '../constant.dart';
import 'components/outline_button.dart';

class NfcSettingPage extends StatefulWidget {
  const NfcSettingPage({super.key});

  @override
  State<NfcSettingPage> createState() => _NfcSettingPageState();
}

class _NfcSettingPageState extends State<NfcSettingPage> {
  final List<String> tagname = ["起", "床", "点", "結", "RTA"];

  //修正箇所
  //配列の中身のRTAを一つ削除した
  //完了ダイアログのifの条件式の値を５から４に変えた
  //ScanFileとWriteFileを結合した
  //WriteFileは削除してもいい

  int tag_count = 0;

  var uuid = Uuid();

  @override
  void initState() {
    super.initState();
    //nfcScanFunc()呼び出し
    nfcScanFunc();
  }

  @override
  Widget build(BuildContext context) {
    String tag_name = tagname[tag_count];

    return Scaffold(
      backgroundColor: Constant.mainColor,
      body: Stack(
        children: [
          Center(
            child: Container(
              child: CustomTextWhite(
                text: '[$tag_name]のボタンを\n壁に取り付け\nタッチしてください',
                fontSize: 30,
              ),
            ),
          ),
        ],
      ),
    );
  }

  void nfcScanFunc() async {
    String id = uuid.v4(); //uuidを生成
    //NFCScan().nfcScan(id)呼び出し
    await NFCScan().nfcScan(id, tag_count).then((_) {
      //NFCのスキャン処理が終わったらshowDialogFunc()呼び出し
      showDialogFunc(context, tag_count);

      _registerIdInDatabase(id);
      //tag_countが4以下ならtag_countの値を増やしてnfcScanFunc()呼び出し
      if (tag_count < 4) {
        setState(() {
          tag_count++;
        });
        nfcScanFunc();
      }
    });
  }

  Future<void> _registerIdInDatabase(String id) async {
    final db = await DatabaseHelper().db;

    await db.insert('nfc', {'nfc_id': id});
    // print('inserted id: $id');
  }

  void showDialogFunc(BuildContext context, int tag_count) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return Dialog(
          tag_count: tag_count,
        );
      },
    );
  }
}

class Dialog extends StatelessWidget {
  final int tag_count;
  const Dialog({
    Key? key,
    required this.tag_count,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (tag_count >= 4) {
      return SimpleDialog(
        shape: RoundedRectangleBorder(
          side: const BorderSide(color: Constant.white, width: 5),
          borderRadius: BorderRadius.circular(10.0),
        ),
        backgroundColor: Constant.mainColor,
        children: [
          Container(
            width: 200,
            height: 190,
            child: Column(
              children: [
                const SizedBox(
                  height: 40,
                ),
                const Align(
                  alignment: Alignment.center,
                  child: CustomTextWhite(text: '設定が完了しました！', fontSize: 25),
                ),
                const SizedBox(
                  height: 20,
                ),
                Container(
                  child: OutlineButton(
                    title: 'とじる',
                    width: 120,
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
                // Padding(
                //   padding:
                //       const EdgeInsets.only(top: 20, left: 50, right: 50, bottom: 40),
                //   child:
                // ),
              ],
            ),
          ),
        ],
      );
    }

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
