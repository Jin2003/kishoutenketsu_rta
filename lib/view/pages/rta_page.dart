import 'package:alarm/alarm.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'package:kishoutenketsu_rta/logic/firebase_helper.dart';
import 'package:kishoutenketsu_rta/logic/nfc_read.dart';
import 'package:kishoutenketsu_rta/logic/singleton_user.dart';
import 'package:kishoutenketsu_rta/view/constant.dart';
import 'package:kishoutenketsu_rta/view/pages/components/custom_text.dart';
import 'package:kishoutenketsu_rta/view/pages/components/outline_button.dart';

import '../../logic/nav_bar.dart';

class RtaPage extends StatefulWidget {
  const RtaPage({super.key});

  @override
  State<RtaPage> createState() => _RtaPageState();
}

class _RtaPageState extends State<RtaPage> {
  // アイコン画像
  final List<String> iconImage = [
    'assets/rta/${SingletonUser.themeName}/起.png',
    'assets/rta/${SingletonUser.themeName}/床.png',
    'assets/rta/${SingletonUser.themeName}/点.png',
    'assets/rta/${SingletonUser.themeName}/結.png',
    'assets/rta/${SingletonUser.themeName}/RTA.png',
    'assets/rta/${SingletonUser.themeName}/RTA.png',
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
    'assets/rta/${SingletonUser.themeName}/rta_circle.png',
    'assets/rta/${SingletonUser.themeName}/rta_circle_on.png',
    'assets/rta/${SingletonUser.themeName}/rta_bar.png',
  ];

  Future<void> _getNfcID() async {
    // データベースからnfc_idをランダムに取得
    Map<String, String> gettedNfcs = await FirebaseHelper().getNfcIdMap();
    setState(() {
      nfcs = gettedNfcs;
    });
    //nfcReadFunc（）呼び出し読み取り開始
    nfcReadFunc();
  }

  late Map<String, String> nfcs;

  // 画像番号
  int imageCount = 0;
  // ランダムにしてMap側のキーにする
  List nfcKey = ["起", "床", "点", "結"];

  String rta = "RTA";

  // この画面が表示された時の時間を取得
  DateTime startTime = DateTime.now();

  @override
  void initState() {
    super.initState();
    // _getNfcTable()呼び出し
    Future(() async {
      await _getNfcID();
    });
    // Future(() async {
    nfcKey.shuffle();
    // });
  }

  @override
  void dispose() {
    // _seSound.dispose(); // Dispose the SeSound instance
    super.dispose();
  }

  Future<int> _getRankingPosition(int thisTime) async {
    // 順位を取得する
    int ranking = await FirebaseHelper().getRanking(thisTime);
    return ranking;
  }

  void nfcReadFunc({int nfcIndex = 0}) async {
    bool success = await NFCRead()
        .nfcRead(imageCount, nfcs[nfcIndex == 4 ? rta : nfcKey[nfcIndex]]);
    debugPrint('$success');
    // データベースに登録しているIDと読み取ったIDが異なるので再度読み取り
    if (success == false) {
      nfcReadFunc(nfcIndex: nfcIndex);
      falseDialog();
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
        //アラーム停止
        Alarm.stop(1);

        // RTA終了時の時間を取得
        DateTime finish = DateTime.now();
        String date = DateFormat('yy.MM/dd').format(finish);
        int rtaResult = finish.difference(startTime).inSeconds;
        // firebaseにRTAのデータを送信
        FirebaseHelper().saveRtaResult(rtaResult, date);

        endDialog(finish, rtaResult);
      } else {
        // 再度読み取り
        nfcReadFunc(nfcIndex: nfcIndex);
      }
    }
  }

  void endDialog(DateTime finish, int rtaResult) async {
    // 順位を取得する
    int ranking = await _getRankingPosition(rtaResult);

    Future.delayed(const Duration(milliseconds: 500), () {
      showDialog(
          context: context,
          builder: (context) {
            return Scaffold(
              backgroundColor: SingletonUser.sub,
              body: Stack(
                children: [
                  SimpleDialog(
                    children: [
                      const SizedBox(
                        height: 40,
                      ),
                      Align(
                        alignment: Alignment.center,
                        child: CustomText(
                            text:
                                '今日のタイムは\n${finish.difference(startTime).inSeconds}秒!!!\n\n順位は$ranking位だよ！',
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

  //タグが違う時のダイアログ
  void falseDialog() {
    Future.delayed(const Duration(milliseconds: 500), () {
      showDialog(
          context: context,
          builder: (context) {
            return Scaffold(
              backgroundColor: SingletonUser.sub,
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
                            text: "そのタグじゃないよ！\n他のタグをタッチしてみよう！",
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
                            Navigator.pop(context);
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: SingletonUser.sub,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(
              width: 230,
              height: 230,
              child: imageCount < 5
                  ? Image.asset(
                      "assets/rta/${SingletonUser.themeName}/${imageCount == 4 ? 'RTA' : nfcKey[imageCount]}.png",
                    )
                  : Container(),
            ),

            const SizedBox(width: 100, height: 20),
            CustomText(
                text: '  をタッチしてね！', fontSize: 25, Color: SingletonUser.main),
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
}
