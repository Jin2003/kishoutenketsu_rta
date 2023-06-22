import 'dart:math';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:kishoutenketsu_rta/logic/shared_preferences_logic.dart';
import 'package:kishoutenketsu_rta/view/pages/components/custom_text.dart';
import '../constant.dart';
import 'package:flutter/cupertino.dart';
import 'package:kishoutenketsu_rta/logic/chatgpt_service.dart';
import 'package:animated_text_kit/animated_text_kit.dart';
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
  // 選択中のキャラクター
  String? _character;

  // アラームオンオフの切り替え
  bool _value = true;

  // バブルの表示を切り替えるフラグ
  bool _showBubble = false;

  //chatGPTへの入力を保持する配列
  List<String> _message = [
    "「りんごって美味しいよね！」だけ言ってくださいそれ以外は言わないでください",
    "「りんごって食べたいなぁ〜」だけ言ってくださいそれ以外は言わないでください",
    "今日のラッキーアイテムを「明日のラッキーアイテムは...だよ！」で一文で答えて",
    "短く「ラ〜」歌を歌って"
  ];
  
  //０から３までのランダムな数字を保持する変数
  int? _Random;

  // ChatGPTからの応答を保持する変数
  String? _response;
  // ChatGPTの応答を表示するかどうかのフラグ
  bool _showResponse = false;

@override
void initState() {
  _timeOfDay = const TimeOfDay(hour: 0, minute: 0);
  super.initState();
  initializeCharacter().then((_) {
      // キャラクターの初期化が完了したら、UIを更新する
      setState(() {});
    });
  //ウィジェットが描画された後に実行する
  WidgetsBinding.instance!.addPostFrameCallback((_) {
    _firstBubbleMessage();
  });
}

// 初回のバブルメッセージを表示する関数
Future<void> _firstBubbleMessage() async {
  await _getChatGPTResponse();
  _toggleBubble();
}

  // バブルの表示を切り替える関数


  void _toggleBubble() {
    setState(() {
      _showBubble = !_showBubble;
    });
  }

  // ChatGPTからの応答を取得する関数
  Future<void> _getChatGPTResponse() async {
    final chatGPT = ChatGPT();
    final response =
        await chatGPT.message(_message[3]);

    setState(() {
      // ChatGPTからの応答を保持する変数に代入
      _response = response.content;
      _showResponse = !_showResponse;
    });
  }

  Future<void> initializeCharacter() async {
    SharedPreferencesLogic sharedPreferencesLogic = SharedPreferencesLogic();
    _character = (await sharedPreferencesLogic.getSelectedCharacter());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Constant.sub,
      body: Stack(
        fit: StackFit.expand,
        children: [
          // 背景画像
          Image.asset(
            "assets/pages/yellow/dots/main_page.png",
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
                    side: const BorderSide(
                      color: Constant.main, //枠線の色
                      width: 4, //太さ
                    ),
                    backgroundColor: Constant.white,
                    elevation: 8,
                  ),
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: ((context) => const AlarmPage())),
                    );
                  },
                  child: Row(
                    children: [
                      const SizedBox(width: 25),
                      SizedBox(
                        width: 200,
                        child: Column(
                          children: [
                            const SizedBox(
                              height: 5,
                            ),
                            Container(
                              alignment: const Alignment(-0.65, 0),
                              // アラームが鳴る時刻
                              child: Text(
                                '${_timeOfDay.hour.toString().padLeft(2, '0')}:${_timeOfDay.minute.toString().padLeft(2, '0')}',
                                style: GoogleFonts.zenMaruGothic(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 65,
                                  color: Constant.main,
                                ),
                              ),
                            ),
                            //　アラーム音の表示
                            Container(
                              alignment: const Alignment(-0.68, -0.8),
                              width: 300,
                              height: 30,
                              child: const CustomText(
                                  text: '♪きらきら星',
                                  fontSize: 19,
                                  Color: Constant.gray),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(width: 12),
                      // アラームのオンオフを切り替えるボタン
                      CupertinoSwitch(
                        activeColor: const Color(0xFFFFA08A),
                        trackColor: Colors.grey,
                        value: _value,
                        onChanged: (value) => setState(() => _value = value),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 150),
            ],
          ),
          // 吹き出し
          // Visibility(
          //   visible: _showBubble,
          //   child: Align(
          //     alignment: const Alignment(-0.5, 0.85),
          //     child: SizedBox(
          //       width: 250,
          //       height: 190,
          //       child: Image.asset(
          //         "assets/speech_bubble.png",
          //       ),
          //     ),
          //   ),
          // ),
          // 吹き出しの中身(ChatGPTの応答)
          Visibility(
            visible: _showResponse,
            child: Align(
              alignment: const Alignment(-0.4, 0.65),
              // alignment: const Alignment(-0.25, 1.14),
              child: Container(
                margin: const EdgeInsets.only(left: 15.0),
                padding: const EdgeInsets.symmetric(
                  vertical: 7.0,
                  horizontal: 10.0,
                ),
                child: Align(
                  alignment: const Alignment(-0.1, 0.65),
                  child: Container(
                    margin: const EdgeInsets.only(left: 15.0),
                    padding: const EdgeInsets.symmetric(
                      vertical: 7.0,
                      horizontal: 10.0,
                    ),
                    decoration: ShapeDecoration(
                      shape: BubbleBorder(
                        width: 30,
                        radius: 25,
                      ),
                    ),
                    child: AnimatedTextKit(
                      animatedTexts: [
                        TyperAnimatedText(
                          _response ?? "",
                          textStyle: GoogleFonts.zenMaruGothic(
                            fontWeight: FontWeight.bold,
                            fontSize: 18,
                            color: const Color(0xFF707070),
                          ),
                          speed: const Duration(milliseconds: 100),
                        ),
                      ],
                      totalRepeatCount: 1,
                    ),
                  ),
                ),
              ),
              // child: SizedBox(
              //   width: 200,
              //   height: 190,
              //   child: AnimatedTextKit(
              //     animatedTexts: [
              //       TyperAnimatedText(_response ?? "",
              //           textStyle: GoogleFonts.zenMaruGothic(
              //             fontWeight: FontWeight.bold,
              //             fontSize: 15,
              //             color: Color(0xFF707070),
              //           ),
              //           speed: const Duration(milliseconds: 100)
              //           ),
              //     ],
              //     totalRepeatCount:1,
              //   ),
              // ),
            ),
          ),
          GestureDetector(
            onTap: () async {
              await _getChatGPTResponse();
              _toggleBubble();
            },
            child: _character != null
                ? Align(
                    alignment: const Alignment(0.8, 0.95),
                    child: SizedBox(
                      width: 120,
                      height: 120,
                      child: Image.asset(
                        "assets/$_character.png",
                      ),
                    ),
                  )
                : Container(),
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

//吹き出しの形を作るクラス
class BubbleBorder extends ShapeBorder {
  BubbleBorder({
    required this.width,
    required this.radius,
  });

  final double width;
  final double radius;

  @override
  EdgeInsetsGeometry get dimensions {
    return EdgeInsets.all(width);
  }

  @override
  Path getInnerPath(Rect rect, {TextDirection? textDirection}) {
    return getOuterPath(
      rect.deflate(width / 2.0),
      textDirection: textDirection,
    );
  }

  @override
  Path getOuterPath(Rect rect, {TextDirection? textDirection}) {
    final r = radius;
    final rs = radius / 2;
    final w = rect.size.width; // 全体の横幅
    final h = rect.size.height; // 全体の縦幅
    final wl = w / 3;
    return Path()
      ..addPath(
        Path()
          ..moveTo(r, 0)
          ..lineTo(w - r - 2 , 0) // →
          ..lineTo(w - r - 3 , 0) // →
          ..arcToPoint(Offset(w - 5 , r), radius: Radius.circular(r + 6))
          ..arcToPoint(Offset(w - r - 5, h + 1), radius: Radius.circular(r + 10),clockwise: true)
          ..relativeLineTo(10 , 15)
          ..arcToPoint(Offset(w - r * 1.5, h + 3), radius: Radius.circular(r * 6),clockwise: true)
          ..lineTo(r, h + 1) // ←
          ..arcToPoint(Offset(0, h - r), radius: Radius.circular(r + 15))
          ..arcToPoint(Offset(r, 0), radius: Radius.circular(r+6.5)),

        Offset(rect.left, rect.top),
      )
      ..close();
  }

  @override
  void paint(Canvas canvas, Rect rect, {TextDirection? textDirection}) {
    final path = getOuterPath(
      rect.deflate(width / 2.0),
      textDirection: textDirection,
    );

    // Add a shadow to the speech bubble
    final shadowPaint = Paint()
      ..color = Colors.black.withOpacity(0.2)
      ..maskFilter = MaskFilter.blur(BlurStyle.normal, 1.5);
    canvas.drawPath(path.shift(Offset(4.0, 4.0)), shadowPaint);

    // Draw the speech bubble shape

    final paint = Paint()
      ..style = PaintingStyle.fill
      ..strokeWidth = 4
      ..color = Color.fromARGB(255, 255, 255, 255);
    canvas.drawPath(path, paint);

  }

  @override
  ShapeBorder scale(double t) => this;
}
