import 'package:flutter/material.dart';
import 'package:kishoutenketsu_rta/logic/firebase_helper.dart';
import 'package:kishoutenketsu_rta/view/constant.dart';
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
  List<Map<String, dynamic>> _result = [];

  //Lankingを何個表示するか
  int _lankingCount = 0;

  //TODOchatGPTへの入力を保持する配列
  // List<String> _message = [
  //   "「更新おめでとう！\n今日も一日頑張ろう!」のみ言ってくださいそれ以外は言わないでください",
  //   "「惜しい！\nあと秒で更新だったね!」のみ言ってくださいそれ以外は言わないでください",
  // ];

  //ランキングの定型文
  List<String> _message = [
    "更新おめでとう！\n今日も一日頑張ろう!",
    // "惜しい！\nあと秒で更新だったね!",
  ];

  //定型文を表示する変数
  String? _response;
  //定型文を表示するかどうかのフラグ
  bool _showResponse = false;

  //TODO ChatGPTからの応答を保持する変数
  // String? _response;
  //TODO ChatGPTの応答を表示するかどうかのフラグ
  // bool _showResponse = false;

  // データベースのデータを保持する変数
  List<Map<String, dynamic>>? db;

  @override
  void initState() {
    super.initState();
    _loadLank();
  }

  // TODOChatGPTからの応答を取得する関数
  // Future<void> _getChatGPTResponse() async {
  //   final chatGPT = ChatGPT();
  //   final response = await chatGPT.message(_message[0]);
  //   if (mounted) {
  //     setState(
  //       () {
  //         // ChatGPTからの応答を保持する変数に代入
  //         _response = response;
  //         _showResponse = !_showResponse;
  //       },
  //     );
  //   }
  // }

  // ランキングを取得する関数
  Future<void> _loadLank() async {
    List<Map<String, dynamic>> rtaResults =
        await FirebaseHelper().getRtaResults();

    // ソート
    rtaResults.sort((a, b) => a['rtaResult'].compareTo(b['rtaResult']));

    // ランキングの数を設定
    int lankingCount = rtaResults.length;

    setState(() {
      _lankingCount = lankingCount;
    });
    _result = rtaResults;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Constant.sub,
      body: Stack(
        children: [
          Positioned.fill(
            child: Image.asset(
              "assets/pages/${Constant.themeName}/${Constant.wallpaper}/ranking_page.png",
              fit: BoxFit.cover,
            ),
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
                      itemBuilder: (context, index) => _buildCard(
                          index + 1, _result[index], _result), // 第3引数を追加
                    ),
                  ),
                ),
              ),
            ],
          ),
          // 吹き出し
          Align(
            alignment: const Alignment(-0.4, 0.8),
            child: SizedBox(
              width: 250,
              height: 190,
              child: Image.asset(
                "assets/speech_bubble.png",
              ),
            ),
          ),
          // 吹き出しの中身(ChatGPTの応答)
          // 吹き出しの中身(ChatGPTの応答)
          Align(
            alignment: const Alignment(-0.3, 1.05),
            child: SizedBox(
              width: 200,
              height: 190,
              child: AnimatedTextKit(
                key: ValueKey<String>(_response ?? ""), // ValueKeyを追加
                animatedTexts: [
                  TyperAnimatedText(
                    _response ?? "",
                    textStyle: GoogleFonts.zenMaruGothic(
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                      color: const Color(0xFF707070),
                    ),
                    speed: const Duration(milliseconds: 100),
                  ),
                ],
                totalRepeatCount: 1,
              ),
            ),
          ),
          GestureDetector(
              onTap: () async {
                //定型文を表示
                setState(() {
                  _response = _message[0];
                  _showResponse = !_showResponse;
                });
                //TODO ChatGPTからの応答を取得
                // await _getChatGPTResponse();
              },
              child: Align(
                alignment: const Alignment(0.8, 0.95),
                child: SizedBox(
                  width: 120,
                  height: 120,
                  child: Image.asset(
                    "assets/${Constant.characterName}.png",
                  ),
                ),
              )),
        ],
      ),
    );
  }
}

Widget _buildCard(
    int index, Map<String, dynamic> time, List<Map<String, dynamic>> result) {
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
                style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Constant.main //accentYellow
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
              CustomText(
                  text: "${result[index - 1]['name']}",
                  fontSize: 14,
                  Color: Constant.gray),
              Text("${result[index - 1]['rtaResult']}")
            ],
          ),
          const SizedBox(
            width: 20,
            height: 0,
          ),
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
              "${result[index - 1]['date']}",
              style:
                  TextStyle(color: Constant.main, fontWeight: FontWeight.bold),
            ),
          ),
        ],
      ),
    ),
  );
}
