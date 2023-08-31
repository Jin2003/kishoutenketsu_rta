import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'package:kishoutenketsu_rta/logic/firebase_helper.dart';
import 'package:kishoutenketsu_rta/logic/nfc_read.dart';
import 'package:kishoutenketsu_rta/view/constant.dart';
import 'package:kishoutenketsu_rta/view/pages/components/custom_text.dart';
import 'package:kishoutenketsu_rta/view/pages/components/outline_button.dart';
import 'package:soundpool/soundpool.dart';

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
    Map<String, String> nfcs = await FirebaseHelper().getNfcIdMap();
    Constant.updateNfcs(nfcs);

    //nfcReadFunc（）呼び出し読み取り開始
    nfcReadFunc();
  }

  // 画像番号
  int imageCount = 0;
  // ランダムにしてMap側のキーにする
  List nfcKey = ["起", "床", "点", "結"];

  String rta = "RTA";

  // この画面が表示された時の時間を取得
  DateTime startTime = DateTime.now();

  SoundpoolOptions _soundpoolOptions = const SoundpoolOptions();

  Soundpool? _pool;
  late Future<int> _soundId;
  int? _alarmSoundStreamId;

  Soundpool get _soundpool => _pool!;

  void _loadSounds() {
    _soundId = _loadSound();
  }

  Future<int> _loadSound() async {
    var asset = await rootBundle.load("assets/alarm/Alarm.mp3");
    return await _soundpool.load(asset);
  }

  Future<void> _playSound() async {
    var alarmSound = await _soundId;
    // TODO: 音が5秒くらいで止まる。無限リピートにしたら一応止まらない
    _alarmSoundStreamId = await _soundpool.play(alarmSound, repeat: -1);
  }

  @override
  void initState() {
    super.initState();
    _initPool(_soundpoolOptions);
    _loadSounds();
    // _getNfcTable()呼び出し
    Future(() async {
      await _getNfcID();
    });
    // Future(() async {
    nfcKey.shuffle();
    // });
    // 画面描画時に音を再生
    _playSound();
  }

  @override
  void dispose() {
    // _seSound.dispose(); // Dispose the SeSound instance
    super.dispose();
  }

  // サウンドの停止
  void _stopSounds() {
    if (_alarmSoundStreamId != null) {
      _soundpool.stop(_alarmSoundStreamId!);
      _alarmSoundStreamId = null;
    }
  }

  // Soundpoolの破棄
  void _disposePool() {
    _soundpool.release();
  }

  void _initPool(SoundpoolOptions soundpoolOptions) {
    _pool?.dispose();
    setState(() {
      _soundpoolOptions = soundpoolOptions;
      _pool = Soundpool.fromOptions(options: _soundpoolOptions);
      if (kDebugMode) {
        print('pool updated: $_pool');
      }
    });
  }

  void nfcReadFunc({int nfcIndex = 0}) async {
    dynamic nfcs = Constant.nfcs;
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
        _stopSounds();
        _disposePool();
        // RTA終了時の時間を取得
        DateTime finish = DateTime.now();
        String date = DateFormat('yy.MM/dd').format(finish);
        // firebaseにRTAのデータを送信
        FirebaseHelper()
            .saveRtaResult(finish.difference(startTime).inSeconds, date);

        endDialog(finish);
      } else {
        // 再度読み取り
        nfcReadFunc(nfcIndex: nfcIndex);
      }
    }
  }

  void endDialog(DateTime finish) {
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
                      Align(
                        alignment: Alignment.center,
                        child: CustomText(
                            text:
                                '今日のタイムは\n${finish.difference(startTime).inSeconds}秒!!!',
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
      backgroundColor: Constant.sub,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(
              width: 230,
              height: 230,
              child: imageCount < 5
                  ? Image.asset(
                      "assets/rta/${Constant.themeName}/${imageCount == 4 ? 'RTA' : nfcKey[imageCount]}.png",
                    )
                  : Container(),
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
}
