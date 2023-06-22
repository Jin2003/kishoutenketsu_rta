import 'package:flutter/material.dart';
import 'package:kishoutenketsu_rta/logic/nfc_read.dart';
import 'package:kishoutenketsu_rta/view/constant.dart';
import 'package:kishoutenketsu_rta/view/pages/components/custom_text.dart';
import 'package:kishoutenketsu_rta/view/pages/components/outline_button.dart';
import 'package:kishoutenketsu_rta/logic/database_helper.dart';

import '../../logic/nav_bar.dart';

class RtaPage extends StatefulWidget {
  const RtaPage({super.key});

  @override
  State<RtaPage> createState() => _RtaPageState();
}

class _RtaPageState extends State<RtaPage> {
  // アイコン画像
  final List<String> iconImage = [
    'assets/rta/${Constant.themeName}/起.png',
    'assets/rta/${Constant.themeName}/床.png',
    'assets/rta/${Constant.themeName}/点.png',
    'assets/rta/${Constant.themeName}/結.png',
    'assets/rta/${Constant.themeName}/RTA.png',
    'assets/rta/${Constant.themeName}/RTA.png',
  ];

  // タッチしたかしてないか判定
  List<bool> onOff = [
    false,
    false,
    false,
    false,
    false,
    false,
  ];

  // running_bar 画像
  final List<String> rtaImage = [
    'assets/rta/${Constant.themeName}/rta_circle.png',
    'assets/rta/${Constant.themeName}/rta_circle_on.png',
    'assets/rta/${Constant.themeName}/rta_bar.png',
  ];

  Future<void> _getNfcID() async {
    // データベースからnfc_idをランダムに取得
    final db = await DatabaseHelper().db;
    final List<Map<String, dynamic>> nfcs =
        await db.rawQuery("SELECT nfc_id FROM nfc ORDER BY RANDOM()");
    //nfcReadFunc（）呼び出し読み取り開始
    nfcReadFunc(nfcs);
  }

  // 画像番号
  int imageCount = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Constant.sub,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(
              width: 230,
              height: 230,
              child: Image.asset(iconImage[imageCount]),
            ),
            const SizedBox(width: 100, height: 20),
            CustomText(text: '  をタッチしてね！', fontSize: 25, Color: Constant.main),
            const SizedBox(width: 100, height: 30),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(
                  width: 35,
                  height: 35,
                  child: Image.asset(rtaImage[onOff[0] ? 1 : 0]),
                ),
                SizedBox(
                  width: 30,
                  height: 30,
                  child: Image.asset(rtaImage[2]),
                ),
                SizedBox(
                  width: 35,
                  height: 35,
                  child: Image.asset(rtaImage[onOff[1] ? 1 : 0]),
                ),
                SizedBox(
                  width: 30,
                  height: 30,
                  child: Image.asset(rtaImage[2]),
                ),
                SizedBox(
                  width: 35,
                  height: 35,
                  child: Image.asset(rtaImage[onOff[2] ? 1 : 0]),
                ),
                SizedBox(
                  width: 30,
                  height: 30,
                  child: Image.asset(rtaImage[2]),
                ),
                SizedBox(
                  width: 35,
                  height: 35,
                  child: Image.asset(rtaImage[onOff[3] ? 1 : 0]),
                ),
                SizedBox(
                  width: 30,
                  height: 30,
                  child: Image.asset(rtaImage[2]),
                ),
                SizedBox(
                  width: 35,
                  height: 35,
                  child: Image.asset(rtaImage[onOff[4] ? 1 : 0]),
                ),
              ],
            ),
            // SizedBox(width: 100, height: 50),
            // SizedBox(
            //   width: 200,
            //   height: 60,
            //   child: ElevatedButton(
            //     child: Text(
            //       'タッチしたら',
            //       style: GoogleFonts.zenMaruGothic(
            //         fontSize: 20,
            //         fontWeight: FontWeight.bold,
            //         color: Constant.mainColor,
            //       ),
            //     ),
            //     style: ElevatedButton.styleFrom(
            //       backgroundColor: Constant.white,
            //       elevation: 5,
            //       shape: RoundedRectangleBorder(
            //         borderRadius: BorderRadius.circular(60),
            //       ),
            //     ),
            //     onPressed: () {
            //       onOff[imageCount] = true;
            //       setState(() {
            //         imageCount++;
            //       });
            //       if (imageCount == 5) {
            //         endDialog();
            //       }
            //     },
            //   ),
            // ),
          ],
        ),
      ),
    );
  }

  @override
  void initState() {
    super.initState();
    // _getNfcTable()呼び出し
    _getNfcID();
  }

  void nfcReadFunc(List<Map<String, dynamic>> nfcs, {int nfcIndex = 0}) async {
    // NFC読み取り
    bool success = await NFCRead().nfcRead(imageCount, nfcs[nfcIndex]);
    debugPrint('$success');
    // データベースに登録しているIDと読み取ったIDが異なるので再度読み取り
    if (success == false) {
      nfcReadFunc(nfcs, nfcIndex: nfcIndex);
      return;
    } else {
      setState(() {
        // タッチしたかしてないか判定
        onOff[imageCount] = true;
        // imageCountをインクリメント
        imageCount++;
        //nfcIndexをインクリメント
        if (nfcIndex <= nfcs.length - 1) {
          nfcIndex++;
        }
      });
      // 5回正しく読み取ったら終了
      if (imageCount == 5) {
        endDialog();
      } else {
        // 再度読み取り
        nfcReadFunc(nfcs, nfcIndex: nfcIndex);
      }
    }
  }

  void endDialog() {
    Future.delayed(const Duration(milliseconds: 500), () {
      showDialog(
          context: context,
          builder: (context) {
            return Scaffold(
              backgroundColor: Constant.sub,
              body: Stack(
                children: [
                  SimpleDialog(
                    children: [
                      const SizedBox(
                        height: 40,
                      ),
                      const Align(
                        alignment: Alignment.center,
                        child: CustomText(
                            text: '設定が完了しました！',
                            fontSize: 25,
                            Color: Constant.gray),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(
                            top: 20, left: 50, right: 50, bottom: 40),
                        child: OutlineButton(
                          title: 'とじる',
                          width: 50,
                          height: 50,
                          shape: 10,
                          fontsize: 17,
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: ((context) => const NavBar())),
                            );
                          },
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            );
          });
    });
  }
}
