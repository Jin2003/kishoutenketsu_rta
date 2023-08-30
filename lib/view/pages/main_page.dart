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
import 'package:weather/weather.dart';

class MainPage extends StatefulWidget {
  const MainPage({Key? key}) : super(key: key);

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  TimeOfDay? _timeOfDay;
  // 選択中のアラーム音
  // TODO:音楽を選択できるようにする
  String? _music;
  // 選択中のキャラクター
  final String _character = Constant.characterName;

  // アラームオンオフの切り替え
  bool _value = Constant.alarmONOFF;

  // shared_preferencesから持ってきたアラーム時刻を保持する変数
  int? _alarmTime;

// ラッキーアイテムを保持する配列
final List<String> _luckyItem = [
  "青いハンカチ",
  "赤いハンカチ",
  "黄色いハンカチ",
  "赤のジャケット",
  "青の靴下",
  "黄色のTシャツ",   
];

// 定型文を保持する配列
final List<String> _message = [
  "りんごって美味しいよね！",
  "りんご食べたいなぁ〜",
  "明日のラッキーアイテムは{_luckyItem}だよ！",
  "ラ〜ラララ〜ラ〜ラララ〜♩"
];

String replaceLuckyItem(String message) {
  final luckyItem = _luckyItem[Random().nextInt(_luckyItem.length)];
  return message.replaceFirst('{_luckyItem}', luckyItem);
}

// ラッキーアイテムをランダムに表示する関数
void RandomLuckyItemResponse() {
  final randomMessage = _message[Random().nextInt(_message.length)];
  final replacedMessage = replaceLuckyItem(randomMessage);
  
  setState(() {
    _response = replacedMessage;
    _showResponse = !_showResponse;
  });
}

  //TODOchatGPTへの入力を保持する配列
  // List<String> _message = [
  //   "りんごって美味しいよね！だけ言ってください",
  //   "りんご食べたいなぁ〜だけ言ってください",
  //   "今日のラッキーアイテムを「明日のラッキーアイテムは...だよ！」で一文で答えて",
  //   "ラ〜で歌を短く歌って"
  // ];

  //TODO ChatGPTからの応答を保持する変数
  String? _response;
  //TODO ChatGPTの応答を表示するかどうかのフラグ
  bool _showResponse = false;

  @override
  void initState() {
    _timeOfDay = const TimeOfDay(hour: 0, minute: 0);
    super.initState();

    initializeTime().then((_) {
      setState(() {});
    });

  //TODOウィジェットが描画された後に実行する
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _firstMessage();
    });
  }

_firstMessage() async {
  try {
    final weather = await getWeather();
    if (weather != null) {
      String messageWithWeather = weather.toString();
      setState(() {
        _response = messageWithWeather;
      });
    } else {
      setState(() {
        _response = "申し訳ありません。\n天気情報が取得できませんでした。";
      });
    }
  } catch (e) {
    print("エラーが発生しました: $e");
  }
}

  //TODO:初回メッセージを作成する関数
  // Future<void> _firstMessage() async {
  //   final chatGPT = ChatGPT();

    //TODO天気情報を含めたメッセージを作成
    // String messageWithWeather =
    //     await getWeather().then((value) => value!.toString());
    // final response = await chatGPT.message(
    //     "$messageWithWeatherの情報から「今日の...の天気は...だよ！」だけ一文で言ってくださいそれ以外は言わないでください");
    // if (mounted) {
    //   setState(() {
    //     // ChatGPTからの応答を保持する変数に代入
    //     _response = response;
    //     _showResponse = !_showResponse;
    //   });
    // }
  // }

  // TODOChatGPTからの応答を取得する関数
  // Future<void> _getChatGPTResponse() async {
  //   final chatGPT = ChatGPT();
  //   _response = null;
  //   final response =
  //       await chatGPT.message(_message[Random().nextInt(_message.length)]);

  //   if (mounted) {
  //     setState(() {
  //       // ChatGPTからの応答を保持する変数に代入
  //       _response = response;
  //       _showResponse = !_showResponse;
  //     });
  //   }
  // }

  //天気情報を取得する関数
  getWeather() async {
    String key = "dcb167452a27389332613cf37eca0217";
    double lat = 35.69; //latitude(緯度)
    double lon = 139.69; //longitude(経度)
    WeatherFactory wf = WeatherFactory(key);

    Weather weather = await wf.currentWeatherByLocation(lat, lon);
    return weather;
  }

  // アラーム音の初期化
  Future<void> initializeMusic() async {
    SharedPreferencesLogic sharedPreferencesLogic = SharedPreferencesLogic();
    _music = (await sharedPreferencesLogic.getSelectedMusic());
  }

  // アラーム時刻の初期化
  Future<void> initializeTime() async {
    SharedPreferencesLogic sharedPreferencesLogic = SharedPreferencesLogic();
    _alarmTime = (await sharedPreferencesLogic.getAlarmTime());

    setState(() {
      if (_alarmTime != null) {
        _timeOfDay =
            TimeOfDay(hour: _alarmTime! ~/ 60, minute: _alarmTime! % 60);
      }
    });
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
            "assets/pages/${Constant.themeName}/${Constant.wallpaper}/main_page.png",
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
                          builder: ((context) =>
                              AlarmPage(argumentAlarmTime: _alarmTime))),
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
                              child: _timeOfDay != null
                                  ? Text(
                                      '${_timeOfDay?.hour.toString().padLeft(2, '0')}:${_timeOfDay?.minute.toString().padLeft(2, '0')}',
                                      style: GoogleFonts.zenMaruGothic(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 65,
                                        color: Constant.main,
                                      ),
                                    )
                                  : Container(),
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
                        onChanged: (value) {
                          Constant.updateAlarmONOFF(value);
                          setState(() {
                            _value = value;
                          });
                        },
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 150),
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
          Align(
            alignment: const Alignment(-0.3, 1.05),
            child: SizedBox(
              width: 200,
              height: 190,
              child:AnimatedTextKit(
                key: ValueKey<String>(_response ?? ""),  // ValueKeyを追加
                animatedTexts: [
                  TyperAnimatedText(
                    _response ?? "",
                    textStyle: GoogleFonts.zenMaruGothic(
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                      color: Color(0xFF707070),
                    ),
                    speed: const Duration(milliseconds: 100),
                  ),
                ],
                totalRepeatCount: 1,
              ),
            ),
          ),
          // GestureDetectorの中でメッセージのランダム表示を呼び出す
          GestureDetector(
            onTap: () {
              RandomLuckyItemResponse();
            },
            child: Align(
              alignment: const Alignment(0.8, 0.95),
              child: SizedBox(
                width: 120,
                height: 120,
                child: Image.asset(
                  "assets/$_character.png",
                ),
              ),
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