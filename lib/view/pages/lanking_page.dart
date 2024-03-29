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

  //最新のRTAタイムを保持する変数
  Map<String, dynamic>? _newTime;

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

  //allとmonthlyの切り替えフラグ
  bool _isMonthly = true;

  @override
  void initState() {
    super.initState();
    _loadAllLank();
    _loadMonthlyLank();
    _getMyLateestRtaResult();
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
  Future<void> _loadAllLank() async {
    List<Map<String, dynamic>> rtaResults =
        await FirebaseHelper().getRtaResults();

    if (mounted) {
      setState(() {
        _lankingCount = rtaResults.length;
        _result = rtaResults;
      });
    }
  }

  // 月間ランキングを取得する関数
  Future<void> _loadMonthlyLank() async {
    List<Map<String, dynamic>> rtaResults =
        await FirebaseHelper().getMonthlyRtaResults();

    if (mounted) {
      setState(() {
        _lankingCount = rtaResults.length;
        _result = rtaResults;
      });
    }
  }

  // 自分の最新のタイムを取得する関数
  Future<void> _getMyLateestRtaResult() async {
    Map<String, dynamic> myLateestRtaResult =
        await FirebaseHelper().getMyLateestRtaResult();
    print("myLateestRtaResult");
    print(myLateestRtaResult);
    if (mounted) {
      setState(() {
        _newTime = myLateestRtaResult;
      });
    }
    if (myLateestRtaResult != {}) {
      _getMessage();
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
  _getMessage() async {
    // ランキング最高記録のRTAタイムを取得
    _topTime = _result.firstWhere(
        (element) => element['name'] == SingletonUser.userName,
        orElse: () => <String, dynamic>{});

    //自分の最新のタイムと最高記録のタイムの差を計算
    final difference = (_newTime != null && _topTime != null)
        ? _newTime!['rtaResult'] - _topTime!['rtaResult']
        : 'タイムが取得できなかったよ';

    if (_newTime != null && _result.isNotEmpty) {
      if (difference != null &&
          difference >= 0 &&
          _topTime!['date'] != _newTime!['date']) {
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
      appBar: AppBar(
        // appbarの高さ指定
        toolbarHeight: 90,
        // 影の深さ
        elevation: 5,
        // titleをcenter固定
        centerTitle: true,
        // 戻るボタンオフ
        automaticallyImplyLeading: false,
        // ランキングのAllとMonthlyをAppbarの真ん中で分けて左右で表示(_allでアンダーライン切り替え)
        actions: [
          Center(
            child: Row(
              children: [
                InkWell(
                  onTap: () {
                    setState(() {
                      _isMonthly = true;
                    });
                  },
                  child: Container(
                    width: 200,
                    height: 90,
                    decoration: BoxDecoration(
                      border: Border(
                        bottom: BorderSide(
                          color:
                              _isMonthly ? Constant.white : SingletonUser.main,
                          width: 3,
                        ),
                      ),
                    ),
                    child: const Align(
                      alignment: Alignment.bottomCenter,
                      child: Padding(
                        padding: EdgeInsets.only(bottom: 5),
                        child: Text(
                          'Monthly',
                          style: TextStyle(
                            fontSize: 25,
                            fontWeight: FontWeight.bold,
                            color: Constant.white,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                InkWell(
                  onTap: () {
                    setState(() {
                      _isMonthly = false;
                    });
                  },
                  child: Container(
                    width: 200,
                    height: 90,
                    decoration: BoxDecoration(
                      border: Border(
                        bottom: BorderSide(
                          color:
                              _isMonthly ? SingletonUser.main : Constant.white,
                          width: 3,
                        ),
                      ),
                    ),
                    child: const Align(
                      alignment: Alignment.bottomCenter,
                      child: Padding(
                        padding: EdgeInsets.only(bottom: 5),
                        child: Text(
                          'All',
                          style: TextStyle(
                            fontSize: 25,
                            fontWeight: FontWeight.bold,
                            color: Constant.white,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
        backgroundColor: SingletonUser.main,
      ),
      backgroundColor: SingletonUser.sub,
      body: Stack(
        children: [
          Positioned.fill(
            child: Image.asset(
              "assets/pages/${SingletonUser.themeName}/${SingletonUser.wallpaper}/ranking_page.png",
              fit: BoxFit.cover,
            ),
          ),
          Column(
            children: [
              const SizedBox(height: 58),
              Align(
                alignment: Alignment.center,
                child: Container(
                  padding: const EdgeInsets.only(top: 30),
                  width: 310,
                  height: 350,
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
