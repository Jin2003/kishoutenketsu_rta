import 'package:flutter/material.dart';
import 'package:kishoutenketsu_rta/logic/shared_preferences_logic.dart';
import 'package:kishoutenketsu_rta/view/constant.dart';
import '../../logic/database_helper.dart';
import 'components/custom_text.dart';
import 'package:kishoutenketsu_rta/logic/chatgpt_service.dart';
import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:google_fonts/google_fonts.dart';

class LankingPage extends StatefulWidget {
  const LankingPage({super.key});

  @override
  State<LankingPage> createState() => _LankingPageState();
}

class _LankingPageState extends State<LankingPage> {
  //Lankingを表示するためのリスト
  List<Map<String, dynamic>> _times = [];
  //Lankingを何個表示するか
  int _lankingCount = 0;

  bool _showBubble = false;

  // 選択中のキャラクター
  String? _character;

  //chatGPTへの入力を保持する配列
  List<String> _message = [
    "「更新おめでとう！\n今日も一日頑張ろう！」だけ言ってくださいそれ以外は言わないでください",
    "「惜しい！\nあと秒で更新だったね！」だけ言ってくださいそれ以外は言わないでください",
    "「」"
  ];
  //０から３までのランダムな数字を保持する変数
  int? _Random;

  // ChatGPTからの応答を保持する変数
  String? _response;
  // ChatGPTの応答を表示するかどうかのフラグ
  bool _showResponse = false;

  @override
  void initState() {
    super.initState();
    _loadLank();
    initializeCharacter().then((_) {
      // キャラクターの初期化が完了したら、UIを更新する
      setState(() {});
    });
  }

  void _toggleBubble() {
    setState(() {
      _showBubble = !_showBubble;
    });
  }

  // ChatGPTからの応答を取得する関数
  Future<void> _getChatGPTResponse() async {
    final chatGPT = ChatGPT();
    final response = await chatGPT.message(_message[0]);
    setState(() {
      _response = response.content;
      _showResponse = !_showResponse;
    });
  }

  //_timeを取得する関数
  Future<void> _loadLank() async {
    final db = await DatabaseHelper().db;
    //timesテーブルからtime_recordとtime_datetimeを取得し、time_recordの昇順で並び替える
    final times = await db.rawQuery(
        'SELECT time_record, time_datetime FROM times ORDER BY time_record ASC');
    //timesの中身の数を_lankingCountに代入
    final lankingCount = times.length;

    setState(() {
      _times = times;
      _lankingCount = lankingCount;
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
      body: Stack(children: [
        Positioned.fill(
          child: Image.asset(
            "assets/pages/yellow/dots/ranking_page.png",
            fit: BoxFit.cover,

          ),
          Column(
            children: [
              const SizedBox(height: 58),
              Align(
                  alignment: Alignment.center,
                  child: Container(
                    padding: const EdgeInsets.only(top: 55),
                    width: 310,
                    height: 420,
                    child: Scrollbar(
                      child: ListView.separated(
                        padding: const EdgeInsets.all(20),
                        separatorBuilder: (context, index) =>
                            const SizedBox(height: 9),
                        //ここでリストの数を決めている
                        itemCount: _lankingCount,
                        itemBuilder: (context, index) =>
                            _buildCard(index + 1, _times[index]),
                      ),
                    ),
                  )),
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
                  alignment: const Alignment(-0.4, 0.65),
                  child: Container(
                    margin: const EdgeInsets.only(left: 15.0),
                    padding: const EdgeInsets.symmetric(
                      vertical: 7.0,
                      horizontal: 10.0,
                    ),
                    decoration: ShapeDecoration(
                      shape: BubbleBorder(
                        width: 30,
                        radius: 29,
                      ),
                    ),
                    child: AnimatedTextKit(
                      animatedTexts: [
                        TyperAnimatedText(
                          _response ?? "",
                          textStyle: GoogleFonts.zenMaruGothic(
                            fontWeight: FontWeight.bold,
                            fontSize: 15,
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

Widget _buildCard(int index, Map<String, dynamic> time) {
  debugPrint(time.toString());
  return Card(
    elevation: 6,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(10),
    ),
    child: Padding(
      padding: const EdgeInsets.all(9.0),
      child: Row(
        children: [
          const SizedBox(
            width: 5,
            height: 0,
          ),
          // 順位の丸
          Container(
            width: 35,
            height: 35,
            decoration: BoxDecoration(
              border: Border.all(color: Constant.main //accentYellow
              ),
              color: Constant.white,
              shape: BoxShape.circle,
            ),
            child: Center(
              child: Text(
                '$index',
                style: const TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Constant.main  //accentYellow
                    ),
              ),
            ),
          ),
          const SizedBox(
            width: 23,
            height: 0,
          ),
          // RTAのタイム
          Column(
            children: [
              const CustomText(text: 'りんご', fontSize: 14, Color: Constant.gray),
              Text(
                //timesが秒数で入っているので分と秒に変換し、00:00の形にする
                '${time['time_record'] ~/ 60}'.padLeft(2, '0') +
                    ':' +
                    '${time['time_record'] % 60}'.padLeft(2, '0'),
                style: const TextStyle(
                      fontSize: 25,
                      fontWeight: FontWeight.bold,
                      color: Constant.main  //accentYellow
                    ),
              ),
            ],
          ),
          const SizedBox(
            width: 20,
            height: 0,
          ),
          // 年月日のやつ
          Container(
            alignment: Alignment.center,
            margin: const EdgeInsets.only(top: 10, left: 20),
            width: 75,
            height: 20,
            decoration: BoxDecoration(
              color: Constant.sub,
              borderRadius: BorderRadius.circular(10),
            ),
            child: Text(
              "${time['time_datetime']}",
              style: const TextStyle(
                  color: Constant.main
                  , fontWeight: FontWeight.bold),
            ),
          )
        ],
      ),
    ),
  );
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
          ..lineTo(w - r - 2, 0) // →
          ..lineTo(w - r - 3, 0) // →
          ..arcToPoint(Offset(w - 5, r), radius: Radius.circular(r + 6))
          ..arcToPoint(Offset(w - r - 5, h + 1),
              radius: Radius.circular(r + 2), clockwise: true)
          ..relativeLineTo(10, 15)
          ..arcToPoint(Offset(w - r * 1.8, h + 3),
              radius: Radius.circular(r * 6), clockwise: true)
          ..lineTo(wl + r, h) // ←
          ..lineTo(r, h) // ←
          ..arcToPoint(Offset(0, h - r), radius: Radius.circular(r))
          ..arcToPoint(Offset(r, 0), radius: Radius.circular(r)),
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
  }

  @override
  ShapeBorder scale(double t) => this;
}
