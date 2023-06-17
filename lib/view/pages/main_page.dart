import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:kishoutenketsu_rta/view/pages/components/custom_text.dart';
import 'package:kishoutenketsu_rta/view/pages/components/elevate_button.dart';
import 'package:kishoutenketsu_rta/view/pages/rta_page.dart';
import '../constant.dart';
import 'package:flutter/cupertino.dart';

import 'alarm_page.dart';

class MainPage extends StatefulWidget {
  const MainPage({Key? key}) : super(key: key);

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  late TimeOfDay _timeOfDay;
  // 選択中のアラーム音
  String? _music;
  // アラームオンオフの切り替え
  bool _value = true;

  @override
  void initState() {
    _timeOfDay = const TimeOfDay(hour: 0, minute: 0);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Constant.subYellow,
      body: Container(
        child: Stack(
          fit: StackFit.expand,
          children: [
            // 背景画像
            Image.asset(
              "assets/y_main_page.png",
              fit: BoxFit.cover,
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.center, 
              children: [
                // 時刻とか表示させてる箱
                Container(
                  alignment: Alignment.center,
                  width: 330,
                  height: 150,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30),
                      ),
                      side: BorderSide(
                        color: Constant.yellow, //枠線の色
                        width: 4, //太さ
                      ),
                      backgroundColor: Constant.white,
                      elevation: 8,
                    ),
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: ((context) => AlarmPage()!)),
                      );
                    },
                    child: Row(
                      children: [
                        SizedBox(width: 25),
                        Container(
                          width: 200,
                          child: Column(
                            children: [
                              SizedBox(height: 5,),
                              Container(
                                alignment: Alignment(-0.65,0),
                                // アラームが鳴る時刻
                                child: Text(
                                  '${_timeOfDay.hour.toString().padLeft(2, '0')}:${_timeOfDay.minute.toString().padLeft(2, '0')}',
                                  style: GoogleFonts.zenMaruGothic(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 65,
                                    color: Constant.yellow,
                                  ),
                                ),
                              ),
                              //　アラーム音の表示
                              Container(
                                alignment: Alignment(-0.68,-0.8),
                                width: 300,
                                height: 30,
                                child: CustomText(text: '♪きらきら星', fontSize: 19, Color: Constant.gray),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(width: 12),
                        // アラームのオンオフを切り替えるボタン
                        CupertinoSwitch(
                          activeColor: Color(0xFFFFA08A),
                          trackColor: Colors.grey,
                          value: _value,
                          onChanged: (value) => setState(() => _value = value),
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(height: 150),
              ],
            ),
            // 吹き出し
            Align(
              alignment: Alignment(-0.5, 0.85),
              child: Container(
                width: 250,
                height: 190,
                child: Image.asset(
                  "assets/speech_bubble.png",
                ),
              ),
            ),
            // TODO: ここにchatGPT
            Align(
              alignment: Alignment(-0.40, 0.62),
              child: CustomText(text:'今日のラッキーアイテム', fontSize: 18, Color: Constant.gray,),
            ),
            // 鶏の画像
            Align(
              alignment: Alignment(0.8, 0.95),
              child: Container(
                width: 120,
                height: 120,
                child: Image.asset(
                  "assets/chicken.png",
                ),
              ),
            ),
          ],
        ),
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
                  color: Constant.blue,
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
