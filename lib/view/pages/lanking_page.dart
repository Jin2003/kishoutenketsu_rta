import 'package:flutter/material.dart';
import 'package:kishoutenketsu_rta/logic/firebase_helper.dart';
import 'package:kishoutenketsu_rta/logic/singleton_user.dart';
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

  //ランキングで自分の名前を保持する変数
  String? _userName;

  //最新のRTAタイムを保持する変数
  Map<String, dynamic>? _rtaTime;

  //最高記録のRTAタイムを保持する変数
  Map<String, dynamic>? _topTime;

  //TODOchatGPTへの入力を保持する配列
  // List<String> _message = [
  //   "「更新おめでとう！\n今日も一日頑張ろう!」のみ言ってくださいそれ以外は言わないでください",
  //   "「惜しい！\nあと秒で更新だったね!」のみ言ってくださいそれ以外は言わないでください",
  // ];

  //TODO ChatGPTからの応答を保持する変数
  // String? _response;
  //TODO ChatGPTの応答を表示するかどうかのフラグ
  // bool _showResponse = false;

  //ランキングの定型文
  final List<String> _message = [
    "更新おめでとう！\n今日も一日頑張ろう!",
    "惜しい！\n",
    "タイムを競い合おう!",
    // "惜しい！\nあと秒で更新だったね!",
  ];

  //定型文を表示する変数
  String? _response;

  //定型文を表示するかどうかのフラグ
  bool _showResponse = false;

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

    print('rtaResults: $rtaResults');

    if (rtaResults.isNotEmpty) {
      // rtaResultsの最新で登録されたタイムの名前を取得
      final userName = rtaResults.last['name'];

      print('userName: $userName');

      // 自分の最新のタイムを取得
      final rtaTime = rtaResults.lastWhere(
          (element) => element['name'] == userName,
          orElse: () => <String, dynamic>{});

      print('rtaTime: $rtaTime');

      if (mounted) {
        setState(() {
          _rtaTime = rtaTime;
          _userName = userName;
        });
      }
    }

    // ソート
    rtaResults.sort((a, b) => a['rtaResult'].compareTo(b['rtaResult']));

    // ランキングの数を設定
    int lankingCount = rtaResults.length;

    if (mounted) {
      setState(() {
        _lankingCount = lankingCount;
      });
    }
    _result = rtaResults;

    _getMessage(_userName!);
  }

//定型文を表示する関数
  _getMessage(String userName) async {
    // ランキング最高記録のRTAタイムを取得
    _topTime = _result.firstWhere((element) => element['name'] == userName,
        orElse: () => <String, dynamic>{});

    print('topTime: $_topTime');

    //自分の最新のタイムと最高記録のタイムの差を計算
    final difference = (_rtaTime != null && _topTime != null)
        ? _rtaTime!['rtaResult'] - _topTime!['rtaResult']
        : 'タイムが取得できなかったよ';

    print('${_rtaTime!['rtaResult']}だよ！');
    print('${_topTime!['rtaResult']}だよ！');

    if (_rtaTime != null && _result.isNotEmpty) {
      if (difference != null && difference >= 0) {
        final minutes = difference ~/ 60;
        final seconds = difference % 60 + 1;

        if (mounted) {
          setState(() {
            if (minutes == 0) {
              _response = "${_message[1]}あと $seconds 秒で更新だったね!";
            } else {
              _response = "${_message[1]}あと $minutes 分 $seconds 秒で更新だったね!";
            }
            _showResponse = !_showResponse;
          });
        }
      } else {
        if (mounted) {
          setState(() {
            _response = _message[0];
            _showResponse = !_showResponse;
          });
        }
      }
    } else {
      if (mounted) {
        setState(() {
          _response = _message[2];
          _showResponse = !_showResponse;
        });
      }
    }
  }

  //定型文を表示する関数
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: SingletonUser.sub,
      body: Stack(
        children: [
          Positioned.fill(
            child: Image.asset(
              "assets/pages/${SingletonUser.themeName}/${Constant.wallpaper}/ranking_page.png",
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
          // 吹き出しに表示するメッセージ
          Align(
            alignment: (_response != null &&
                    _response!.length >= 14 &&
                    _response!.length <= 28)
                ? const Alignment(-0.3, 1.05)
                : (_response != null && _response!.length > 28)
                    ? const Alignment(-0.3, 1.02)
                    : const Alignment(-0.3, 1.07),
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
          Align(
            alignment: const Alignment(0.8, 0.95),
            child: SizedBox(
              width: 120,
              height: 120,
              child: Image.asset(
                "assets/${SingletonUser.characterName}.png",
              ),
            ),
          )
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
              border: Border.all(color: SingletonUser.main //accentYellow
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
                    color: SingletonUser.main //accentYellow
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
              color: SingletonUser.sub,
              borderRadius: BorderRadius.circular(10),
            ),
            child: Text(
              "${result[index - 1]['date']}",
              style: TextStyle(
                  color: SingletonUser.main, fontWeight: FontWeight.bold),
            ),
          ),
        ],
      ),
    ),
  );
}
