import 'dart:math';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:kishoutenketsu_rta/logic/nav_bar.dart';
import 'package:kishoutenketsu_rta/logic/shared_preferences_logic.dart';
import 'package:kishoutenketsu_rta/logic/singleton_user.dart';
import 'package:kishoutenketsu_rta/view/pages/components/custom_text.dart';
// import 'package:kishoutenketsu_rta/logic/chatgpt_service.dart';
import 'package:kishoutenketsu_rta/logic/position.dart';
import 'package:kishoutenketsu_rta/view/pages/join_group.dart';
import 'package:kishoutenketsu_rta/view/pages/log_in.dart';
import 'package:kishoutenketsu_rta/view/pages/rta_page.dart';
import 'package:kishoutenketsu_rta/view/pages/setting/account_set_page.dart';
import 'package:kishoutenketsu_rta/view/pages/setting/chara_set_page.dart';
import 'package:kishoutenketsu_rta/view/pages/setting/color_set_page.dart';
import 'package:kishoutenketsu_rta/view/pages/setting/help_page.dart';
import 'package:kishoutenketsu_rta/view/pages/setting/invitation_page.dart';
import 'package:kishoutenketsu_rta/view/pages/setting/wallpaper_set_page.dart';
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

  //天気を保持する変数
  String? weatherDescription;

  //最高気温を保持する変数
  Temperature? temperature;

  //降水確率を保持する変数
  double? rain;

  //天気のアイコンを保持する変数
  String? weatherIcon;

  //position.dartのUserPositionクラスのインスタンスを作成
  UserPosition userPosition = UserPosition();

  // ScaffoldStateのGlobalKeyを変数として定義
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  //nav_bar.dartのインスタンスを作成
  final NavBar _navBar = NavBar();


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
  //     weatherDescription = weather.weatherMain;
  //     // String? weatherDescription = weather.weatherDescription;

  //     //天候情報を日本語に変換
  //     switch (weatherDescription) {
  //       case "Clear":
  //         weatherDescription = "晴れ";
  //         break;
  //       case "Clouds":
  //         weatherDescription = "曇り";
  //         break;
  //       case "Rain":
  //         weatherDescription = "雨";
  //         break;
  //       case "Thunderstorm":
  //         weatherDescription = "雷雨";
  //         break;
  //       case "Drizzle":
  //         weatherDescription = "霧雨";
  //         break;
  //       case "Snow":
  //         weatherDescription = "雪";
  //         break;
  //       case "Mist":
  //         weatherDescription = "霧";
  //         break;
  //       default:
  //         weatherDescription = "不明";
  //     }

  //     //最高気温の取得
  //     temperature = weather.tempMax;

  //     //OpenWeatherMapのAPIから降水確率を取得
  //     rain = weather.rainLastHour;

  //     print(rain);

  //     //天気情報メッセージ
  //     String weatherMessage
  //       = "今日の$cityNameの天気は$weatherDescriptionだよ!\n最高気温は${temperature!.celsius!.toStringAsFixed(0)}度だよ！";

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
      appBar: AppBar(
        // appbarの高さ指定
        toolbarHeight: 90,
        // 影の深さ
        elevation: 5,
        // titleをcenter固定
        centerTitle: true,
        // 戻るボタンオフ
        automaticallyImplyLeading: false,
        // ロゴ表示
        title: Image.asset(
          'assets/logo.png',
          height: 50,
          width: 130,
        ),

        backgroundColor: SingletonUser.main,

        actions: <Widget>[
          // ハンバーガーボタンをカスタム
          InkWell(
            onTap: () => _scaffoldKey.currentState?.openEndDrawer(),
            child: const Row(
              children: [
                ImageIcon(
                  AssetImage('assets/icon/humberger_icon.png'),
                  color: Constant.white,
                ),
                SizedBox(width: 10),
              ],
            ),
          ),
        ],
      ),
      // 定義した _scaffoldKey をkeyプロパティに適用
      key: _scaffoldKey,

      // drawerの表示（ハンバーガーメニュー）
      endDrawer: Drawer(
        child: Column(
          children: [
            Expanded(
              child: ListView(
                padding: EdgeInsets.zero,
                children: [
                  const SizedBox(
                    height: 120,
                    child: DrawerHeader(
                      decoration: BoxDecoration(
                        color: Constant.white,
                        border: Border(
                            bottom: BorderSide(color: Constant.gray, width: 2)),
                      ),
                      child: Column(
                        children: [
                          CustomText(
                              text: '設定', fontSize: 20, Color: Constant.gray),
                        ],
                      ),
                    ),
                  ),
                  _DrawerWidget(context, 'person_icon', 'アカウント設定',
                      const AccountSetPage()),
                  _DrawerWidget(context, 'character_icon', 'キャラクター変更',
                      const CharaSetPage()),
                  // 時間があれば
                  _DrawerWidget(
                      context, 'color_icon', 'テーマカラー変更', const ColorSetPage()),
                  _DrawerWidget(context, 'wallpaper_icon', '壁紙変更',
                      const WallpaperSetPage()),
                  _DrawerWidget(context, 'adduser_icon', 'グループ招待',
                      const InvitationPage()),
                  _DrawerWidget(
                      context, 'invitaion_icon', 'グループ参加', const JoinGroup()),
                  _DrawerWidget(context, 'help_icon', 'ヘルプ', const HelpPage()),
                ],
              ),
            ),
            // ログアウトボタン
            TextButton(
              onPressed: () async {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: ((context) => const RtaPage())),
                );
              },
              child: const CustomText(
                text: 'RTAテスト',
                Color: Constant.red,
                fontSize: 20,
              ),
            ),
            TextButton(
              onPressed: () async {
                // firebaseからログアウト
                // print(Constant.groupID);
                // FirebaseHelper().getNfcIdMap();
                await FirebaseAuth.instance.signOut();
                SharedPreferencesLogic sharedPreferencesLogic =
                    SharedPreferencesLogic();
                // sharedPreferenceのデータを全て削除
                sharedPreferencesLogic.clearAllData();
                if (!mounted) return;
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: ((context) => const LogIn())),
                );
              },
              child: const CustomText(
                text: 'ログアウト',
                Color: Constant.red,
                fontSize: 20,
              ),
            ),
            const SizedBox(height: 20),
          ],
        ),
      ),
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
            mainAxisAlignment: MainAxisAlignment.start,
              children:[
              const SizedBox(height: 100),
              // 時刻とか表示させてる箱
              Container(
                alignment: Alignment.center,
                width: 330,
                height: 150,
                child: Stack(
                  children: [
                    ElevatedButton(
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
                  ],
                ),
              ),

              const SizedBox(height: 60),

            // 天気情報を表示する箱
            weatherIcon != null
            ? Container(
                alignment: Alignment.center,
                width: 320,
                height: 100,
                decoration: BoxDecoration(
                  color: Constant.white,
                  borderRadius: BorderRadius.circular(30),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.2),
                      spreadRadius: 0,
                      blurRadius: 3,
                      offset: const Offset(0, 4),
                    ),
                  ],
                ),
                child: Row(
                  children: [
                    //天気アイコン表示
                    Image.network("http://openweathermap.org/img/wn/$weatherIcon.png",
                      width: 100,
                      height: 100,
                      fit: BoxFit.cover,
                    ),

                    const SizedBox(width: 15),

                    //最高気温表示
                    Text(
                      "${temperature!.celsius!.toStringAsFixed(0)}℃",
                      style: GoogleFonts.zenMaruGothic(
                        fontWeight: FontWeight.bold,
                        fontSize: 50,
                        color: SingletonUser.main,
                      ),
                    ),

                    const SizedBox(width: 30),

                    //天気表示
                    Align(
                      alignment: const Alignment(0, 0.2),
                      child: Text(
                        "$weatherDescription",
                        style: GoogleFonts.zenMaruGothic(
                          fontWeight: FontWeight.bold,
                          fontSize: 25,
                          color: Colors.grey,
                      ),
                    ),
                    //降水確率表示
                    // Text(
                    //   "降水確率\n${rain!.toStringAsFixed(0)}%",
                    //   style: GoogleFonts.zenMaruGothic(
                    //     fontWeight: FontWeight.bold,
                    //     fontSize: 25,
                    //     color: Colors.grey,
                    //   ),
                    ),
                  ],
                )
              )
              : Container(
                alignment: Alignment.center,
                width: 320,
                height: 100,
                decoration: BoxDecoration(
                  color: Constant.white,
                  borderRadius: BorderRadius.circular(30),
                  //影を表示
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.32),
                      spreadRadius: 0,
                      blurRadius: 10,
                      offset: const Offset(-1, 5),
                    ),
                  ],
                ),
                child: const Center(
                  child: CircularProgressIndicator(),
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
                ? const Alignment(-0.3, 1.07) //二行
                : (_response != null && _response!.length > 28)
                    ? const Alignment(-0.3, 1.03)  //三行
                    : const Alignment(-0.3, 1.08), //一行
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
                      fontSize: 13,
                      color: Color(0xFF707070),
                    ),
                    // textAlign: TextAlign.center,
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

Widget _DrawerWidget(
    context, String iconName, String listTitle, Widget nextPage) {
  return ListTile(
    leading: ImageIcon(
      AssetImage('assets/icon/$iconName.png'),
      color: Constant.gray,
    ),
    title: Row(
      children: [
        CustomText(text: listTitle, fontSize: 18, Color: Constant.gray),
        const SizedBox(
          width: 0,
        ),
      ],
    ),
    // 画面遷移
    onTap: () async {
      Navigator.push(
        context,
        MaterialPageRoute(builder: ((context) => nextPage)),
      );
    },
  );
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
