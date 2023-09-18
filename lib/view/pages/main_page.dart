import 'dart:math';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:kishoutenketsu_rta/logic/shared_preferences_logic.dart';
import 'package:kishoutenketsu_rta/logic/singleton_user.dart';
import 'package:kishoutenketsu_rta/view/pages/components/custom_text.dart';
// import 'package:kishoutenketsu_rta/logic/chatgpt_service.dart';
import 'package:kishoutenketsu_rta/logic/position.dart';
import '../constant.dart';
import 'package:flutter/cupertino.dart';
import 'package:animated_text_kit/animated_text_kit.dart';
import 'alarm_page.dart';
import 'package:weather/weather.dart';
import 'package:geocoding/geocoding.dart' as geoCoding;

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
  final String _character = SingletonUser.characterName;

  // アラームオンオフの切り替え
  bool _value = SingletonUser.settedAlarm;

  // shared_preferencesから持ってきたアラーム時刻を保持する変数
  int? _alarmTime;

  // ラッキーアイテムを保持する配列
  final List<String> _luckyItem = [
    "青色のハンカチ",
    "花柄のハンカチ",
    "黄色のハンカチ",
    "赤色のペンダント",
    "青色の靴下",
    "黒色のペン",
  ];

  // 定型文を保持する配列
  final List<String> _message = [
    "りんごって美味しいよね！",
    "りんご食べたいなぁ〜",
    "明日のラッキーアイテムは\n{_luckyItem}だよ！",
    "ラ〜ラララ〜ラ〜ラララ〜♩"
  ];

  //定型文を保持する変数
  String? _response;

  //定型文表示するかどうかのフラグ
  bool _showResponse = false;

  //OpenWeatherMapのAPIキー
  String key = "acd5de627cfa49076715e8bfd8e76a8d";

  //天気情報を取得するためのインスタンス
  late WeatherFactory wf;

  // 緯度を保持する変数
  double? lat;

  // 経度を保持する変数
  double? lon;

  //天気のアイコンを保持する変数
  String? weatherIcon;

  //position.dartのUserPositionクラスのインスタンスを作成
  UserPosition userPosition = UserPosition();

  @override
  void initState() {
    _timeOfDay = const TimeOfDay(hour: 0, minute: 0);
    wf = WeatherFactory(key, language: Language.JAPANESE);
    super.initState();

    initializeTime().then((_) {
      setState(() {});
    });

    // 位置情報を取得
    userPosition.determinePosition().then((position) async {
      if (mounted) {
        setState(() {
          lat = position.latitude;
          lon = position.longitude;
        });
      }

      // print("緯度: $lat, 経度: $lon");

      //初回メッセージを作成
      // await _weatherMessage();
    });
  }

  // レンダリング時に表示される天気情報のメッセージを作成する関数
  // Future<void>_weatherMessage() async {
  //   try {
  //     //緯度と経度が取得できない場合のエラーハンドリング
  //     if (lat == null || lon == null) {
  //       print("緯度と経度が取得できませんでした");
  //       return;
  //     }

  //     //天気情報を取得
  //     final position = await geoCoding.placemarkFromCoordinates(lat!, lon!);
  //     Weather weather = await wf.currentWeatherByCityName(position.first.locality!);

  //     print("天気情報を取得しました: $weather");

  //     //都市の名前を取得
  //     String? cityName = position.first.locality;

  //     //天候情報を取得
  //     // String? weatherDescription = weather.weatherMain;
  //     String? weatherDescription = weather.weatherDescription;

  //     //最高気温の取得
  //     Temperature? temperature = weather.tempMax;

  //     //天気情報メッセージ
  //     String weatherMessage
  //       = "今日の$cityNameの天気は\n$weatherDescriptionだよ!\n最高気温は${temperature!.celsius!.toStringAsFixed(0)}度だよ！";

  //     if (mounted) {
  //       setState(() {
  //         _response = weatherMessage;
  //         _showResponse = !_showResponse;
  //         weatherIcon = weather.weatherIcon;
  //       });
  //     }
  //   } catch (e) {
  //     print("エラーが発生しました: $e");
  //   }
  // }

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

  // 定型文をランダムに表示する関数
  void randomResponse() {
    final randomMessage = _message[Random().nextInt(_message.length)];
    final replacedMessage = replaceLuckyItem(randomMessage);

    setState(() {
      _response = replacedMessage;
      _showResponse = !_showResponse;
    });
  }

  // ラッキーアイテムをランダムに選択してメッセージに埋め込む関数
  String replaceLuckyItem(String message) {
    // ラッキーアイテムをランダムに選択
    final luckyItem = _luckyItem[Random().nextInt(_luckyItem.length)];
    // ラッキーアイテムをメッセージに埋め込む
    return message.replaceFirst('{_luckyItem}', luckyItem);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: SingletonUser.sub,
      body: Stack(
        fit: StackFit.expand,
        children: [
          // 背景画像
          Image.asset(
            "assets/pages/${SingletonUser.themeName}/${SingletonUser.wallpaper}/main_page.png",
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
                      color: SingletonUser.main, //枠線の色
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
                                        color: SingletonUser.main,
                                      ),
                                    )
                                  : Container(),
                            ),
                            //アラーム音の表示
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
                          // TODO:shared_preferencesにアラームのオンオフを保存
                          SingletonUser.updateAlarmONOFF(value);
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
                      color: Color(0xFF707070),
                    ),
                    textAlign: TextAlign.center,
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
              randomResponse();
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

//TODOchatGPTへの入力を保持する配列
// List<String> _message = [
//   "りんごって美味しいよね！だけ言ってください",
//   "りんご食べたいなぁ〜だけ言ってください",
//   "今日のラッキーアイテムを「明日のラッキーアイテムは...だよ！」で一文で答えて",
//   "ラ〜で歌を短く歌って"
// ];

//TODO ChatGPTからの応答を保持する変数
// String? _response;
//TODO ChatGPTの応答を表示するかどうかのフラグ
// bool _showResponse = false;

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

//天候情報を日本語に変換
// switch (weatherDescription) {
//   case "Thunderstorm":
//     weatherDescription = "雷雨";
//     break;
//   case "Drizzle":
//     weatherDescription = "霧雨";
//     break;
//   case "Rain":
//     weatherDescription = "雨";
//     break;
//   case "Snow":
//     weatherDescription = "雪";
//     break;
//   case "Clear":
//     weatherDescription = "晴れ";
//     break;
//   case "Clouds":
//     weatherDescription = "曇り";
//     break;
//   default:
//     weatherDescription = "不明";
// }

//天気のアイコン表示
// weatherIcon != null
//   ?Container(
//     alignment: const Alignment(0.8, -0.8),
//     width: 100,
//     height: 100,
//     decoration: BoxDecoration(
//       color: Constant.main,
//       shape: BoxShape.circle,
//       border: Border.all(
//         color: Colors.white,
//         width: 2,
//       ),
//     ),
//     child: Center(
//       child: Image(
//         image:NetworkImage("http://openweathermap.org/img/wn/$weatherIcon.png"),
//       ),
//     ),
//   )
//   //ローディングを表示
//   :Container(
//     alignment: const Alignment(0.8, -0.8),
//     width: 100,
//     height: 100,
//     decoration: BoxDecoration(
//       color: Constant.main,
//       shape: BoxShape.circle,
//       border: Border.all(
//         color: Colors.white,
//         width: 2,
//       ),
//     ),
//     child: const Center(
//       child: CircularProgressIndicator(),
//     ),
//   ),
