import 'package:flutter/material.dart';
import 'package:flutter/src/material/date_picker_theme.dart';
import 'package:flutter_datetime_picker_plus/flutter_datetime_picker_plus.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:kishoutenketsu_rta/logic/nav_bar.dart';
import 'package:kishoutenketsu_rta/view/pages/components/custom_text.dart';

import '../constant.dart';
import 'components/elevate_button.dart';

class AlarmPage extends StatefulWidget {
  const AlarmPage({super.key});

  @override
  State<AlarmPage> createState() => _AlarmPageState();
}

class _AlarmPageState extends State<AlarmPage> {
  // 選択中のアラーム音
  String? _music;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Constant.subYellow,
      body: Stack(
        fit: StackFit.expand,
        children: [
          // 背景画像
          Image.asset(
            "assets/pages/yellow/alarm_page.png",
            fit: BoxFit.cover,
          ),

          Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [

                SizedBox(
                  height: 60,
                ),
                // 時刻設定
                Container(
                  //alignment: Alignment.center,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(25),
                      ),
                      side: BorderSide(
                        color: Constant.yellow, //枠線の色
                        width: 4, //太さ
                      ),
                      backgroundColor: Constant.white,
                      elevation: 8,
                    ),
                    //時刻の設定をする処理(ブラッシュアップ前のやつ)
                    //   onPressed: () async {
                    //     final TimeOfDay? timeOfDay = await showTimePicker(
                    //         context: context, initialTime: _timeOfDay);
                    //     if (timeOfDay != null) setState(() => {_timeOfDay = timeOfDay});
                    //   },
                    onPressed: () {
                      // TODO：時刻設定ダイアログ
                      DatePicker.showTimePicker(context,
                          //DatetimePickerのモーダル内の「キャンセル」「完了」を表示
                          showTitleActions: true,
                          //「秒」の表記が不要->showSecondsColumnをfalse
                          showSecondsColumn: false, onChanged: (date) {
                        //print(date);
                      }, onConfirm: (date) {
                        //print(date);
                      },
                      // DatetimePickerの初期値を設定
                      currentTime: DateTime.now(),
                      // 日本語設定
                      locale: LocaleType.jp);
                    },
                    child: SizedBox(
                      width: 270,
                      height: 110,
                      child: Column(
                        children: [
                          const SizedBox(height: 23),
                          Row(
                            children: [
                              SizedBox(width: 10),
                              Image.asset(
                                "assets/icon/alarm_icon.png",
                                width: 40,
                              ),
                              SizedBox(width: 10),
                              CustomText(
                                  text: '時刻設定',
                                  fontSize: 20,
                                  Color: Constant.gray),
                            ],
                          ),
                          Align(
                            alignment: Alignment(0.9, 0),
                            child: CustomText(
                                text: '8 : 4 0',
                                fontSize: 25,
                                Color: Constant.gray),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),

                SizedBox(height: 20),

                //　アラーム音設定
                Container(
                  alignment: Alignment.center,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(25),
                      ),
                      side: BorderSide(
                        color: Constant.yellow, //枠線の色
                        width: 4, //太さ
                      ),
                      backgroundColor: Constant.white,
                      elevation: 8,
                    ),
                    onPressed: () async {
                      // アラーム音のダイアログを表示して、選択したアラーム音を受け取る
                      final selectedAlarm = await showDialog<String>(
                        context: context,
                        builder: (context) => _alarmSelectorDialog(
                          music: _music,
                        ),
                      );
                      if (selectedAlarm != null) {
                        // 選択中のアラームを更新してリビルドする
                        setState(() {
                          _music = selectedAlarm;
                        });
                      }
                    },
                    // アラーム音設定
                    child: Container(
                      width: 270,
                      height: 110,
                      child: Column(
                        children: [
                          SizedBox(height: 20),
                          Row(
                            children: [
                              SizedBox(width: 12),
                              Image.asset(
                                "assets/icon/music_icon.png",
                                width: 32,
                              ),
                              SizedBox(width: 15),
                              CustomText(
                                  text: 'アラーム音設定',
                                  fontSize: 20,
                                  Color: Constant.gray),
                            ],
                          ),
                          SizedBox(height: 14),
                          Align(
                            alignment: Alignment(0.9, 0),
                            child: CustomText(
                                text: '♪ きらきら星',
                                fontSize: 19,
                                Color: Constant.gray),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),

                SizedBox(height: 35),

                // 変更内容保存ボタン
                ElevateButton(
                  title: "保存",
                  width: 160,
                  height: 50,
                  fontSize: 20,
                  shape: 16,
                  onPressed: () async {
                    // TODO: 変更内容保存
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: ((context) => NavBar()!)),
                    );
                  },
                ),
                SizedBox(height: 12),
                // キャンセルボタン
                ElevateButton(
                  title: "キャンセル",
                  width: 160,
                  height: 50,
                  fontSize: 20,
                  shape: 16,
                  onPressed: () async {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: ((context) => NavBar()!)),
                    );
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}


// アラーム音を選択するダイアログ
class _alarmSelectorDialog extends StatelessWidget {
  const _alarmSelectorDialog({
    Key? key,
    this.music,
  }) : super(key: key);

  // 選択中のアラーム音
  final String? music;

  static const _musics = ['きらきら星', 'せせらぎ', 'たかし〜朝よ〜！', '天国と地獄', '恋愛レボリューション21'];

  @override
  Widget build(BuildContext context) {
    return SimpleDialog(
      children: _musics
          .map(
            (p) => ListTile(
              leading: Visibility(
                visible: p == music,
                child: const Icon(Icons.check),
              ),
              title: Text(
                p,
                style: GoogleFonts.zenMaruGothic(
                  fontWeight: FontWeight.bold,
                  fontSize: 21,
                  color: Constant.accentYellow,
                ),
              ),
              onTap: () {
                Navigator.of(context).pop(p);
              },
            ),
          )
          .toList(),
    );
  }
}



            // アラームオンオフ切り替えボタン
// ElevateButton(
                //   title: "時刻設定",
                //   width: 180,
                //   height: 55,
                //   fontSize: 20,
                //   shape: 30,
                //   //時刻の設定をする処理
                //   onPressed: () async {
                //     final TimeOfDay? timeOfDay = await showTimePicker(
                //         context: context, initialTime: _timeOfDay);
                //     if (timeOfDay != null) setState(() => {_timeOfDay = timeOfDay});
                //   },
                // ),
                // const SizedBox(
                //   width: 0,
                //   height: 20,
                // ),
                // ElevateButton(
                //   title: "アラーム音設定",
                //   width: 180,
                //   height: 55,
                //   fontSize: 20,
                //   shape: 30,
                //   onPressed: () async {
                //     // アラーム音のダイアログを表示して、選択したアラーム音を受け取る
                //     final selectedAlarm = await showDialog<String>(
                //       context: context,
                //       builder: (context) => _alarmSelectorDialog(
                //         music: _music,
                //       ),
                //     );
                //     if (selectedAlarm != null) {
                //       // 選択中のアラームを更新してリビルドする
                //       setState(() {
                //         _music = selectedAlarm;
                //       });
                //     }
                //   },
                //  ),