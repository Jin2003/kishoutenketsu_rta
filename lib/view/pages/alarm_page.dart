import 'package:alarm/alarm.dart';
import 'package:alarm/model/alarm_settings.dart';
import 'package:flutter/material.dart';
import 'package:flutter_datetime_picker_plus/flutter_datetime_picker_plus.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:kishoutenketsu_rta/logic/nav_bar.dart';
import 'package:kishoutenketsu_rta/logic/shared_preferences_logic.dart';
import 'package:kishoutenketsu_rta/view/pages/components/custom_text.dart';

import '../constant.dart';
import 'components/elevate_button.dart';

class AlarmPage extends StatefulWidget {
  final int? argumentAlarmTime;
  final AlarmSettings? alarmSettings;

  const AlarmPage(
      {required this.argumentAlarmTime, Key? key, this.alarmSettings})
      : super(key: key);

  @override
  State<AlarmPage> createState() => _AlarmPageState();
}

class _AlarmPageState extends State<AlarmPage> {
  // 保存中のアラーム音
  String? _music;

  // 保存中のアラーム音の表示名
  String? _musicName;

  // アラームを鳴らす時刻
  int _alarmTime = Constant.alarmTime;

  // 設定した時刻のhourのみを取得
  int? _alarmHour;

  // 設定した時刻のminuteのみを取得
  int? _alarmMinute;

  // アラームネームをkeyvalueで管理
  // TODO:名前後で考える
  final Map<String, String> _musicNameMap = {
    "circus": "サーカス",
    "domino": "ドミノ",
    "garandou": "伽藍堂",
    "hinokuruma": "火の車",
    "osyogatsu": "お正月",
  };

  bool loading = false;

  late bool creating;
  late TimeOfDay selectedTime;
  late bool loopAudio;
  late bool vibrate;
  late bool volumeMax;
  late bool showNotification;
  late String assetAudio;

  bool isToday() {
    final now = DateTime.now();
    final dateTime = DateTime(
      now.year,
      now.month,
      now.day,
      selectedTime.hour,
      selectedTime.minute,
      0,
      0,
    );

    return now.isBefore(dateTime);
  }

  @override
  void initState() {
    super.initState();
    initializeMusic().then((_) {
      setState(() {});
    });
    splitAlarmTime().then((_) {
      setState(() {});
    });
    creating = widget.alarmSettings == null;

    if (creating) {
      final dt = DateTime.now().add(const Duration(minutes: 1));
      selectedTime = TimeOfDay(hour: dt.hour, minute: dt.minute);
      loopAudio = true;
      vibrate = true;
      volumeMax = true;
      showNotification = true;
      assetAudio = 'assets/alarm/marimba.mp3';
    } else {
      selectedTime = TimeOfDay(
        hour: widget.alarmSettings!.dateTime.hour,
        minute: widget.alarmSettings!.dateTime.minute,
      );
      loopAudio = widget.alarmSettings!.loopAudio;
      vibrate = widget.alarmSettings!.vibrate;
      volumeMax = widget.alarmSettings!.volumeMax;
      showNotification = widget.alarmSettings!.notificationTitle != null &&
          widget.alarmSettings!.notificationTitle!.isNotEmpty &&
          widget.alarmSettings!.notificationBody != null &&
          widget.alarmSettings!.notificationBody!.isNotEmpty;
      assetAudio = widget.alarmSettings!.assetAudioPath;
    }
  }

  Future<void> pickTime() async {
    // final res = await showTimePicker(
    //   initialTime: selectedTime,
    //   context: context,
    // );
    final res = await DatePicker.showTimePicker(context,
        //DatetimePickerのモーダル内の「キャンセル」「完了」を表示
        showTitleActions: true,
        //「秒」の表記が不要->showSecondsColumnをfalse
        showSecondsColumn: false, onChanged: (date) {
      // print(date);
    }, onConfirm: (date) {
      setState(() {
        _alarmTime = date.hour * 60 + date.minute;
        _alarmHour = date.hour;
        _alarmMinute = date.minute;
      });
    },
        // DatetimePickerの初期値を設定
        currentTime: DateTime.now(),
        // 日本語設定
        locale: LocaleType.jp);

    // if (res != null) setState(() => selectedTime = res);
  }

  AlarmSettings buildAlarmSettings() {
    final now = DateTime.now();
    final id = creating
        ? DateTime.now().millisecondsSinceEpoch % 100000
        : widget.alarmSettings!.id;

    DateTime dateTime = DateTime(
      now.year,
      now.month,
      now.day,
      selectedTime.hour,
      selectedTime.minute,
      0,
      0,
    );
    if (dateTime.isBefore(DateTime.now())) {
      dateTime = dateTime.add(const Duration(days: 1));
    }

    final alarmSettings = AlarmSettings(
      id: id,
      dateTime: dateTime,
      loopAudio: loopAudio,
      vibrate: vibrate,
      volumeMax: volumeMax,
      notificationTitle: showNotification ? 'Alarm example' : null,
      notificationBody: showNotification ? 'Your alarm ($id) is ringing' : null,
      assetAudioPath: assetAudio,
      stopOnNotificationOpen: false,
    );
    return alarmSettings;
  }

  void saveAlarm() {
    setState(() => loading = true);
    Alarm.set(alarmSettings: buildAlarmSettings()).then((res) {
      if (res) Navigator.pop(context, true);
    });
    setState(() => loading = false);
  }

  void deleteAlarm() {
    Alarm.stop(widget.alarmSettings!.id).then((res) {
      if (res) Navigator.pop(context, true);
    });
  }

  // 現在保存している音楽を取得
  Future<void> initializeMusic() async {
    SharedPreferencesLogic sharedPreferencesLogic = SharedPreferencesLogic();
    _music = (await sharedPreferencesLogic.getSelectedMusic());
    setState(() {
      _musicName = _musicNameMap[_music!];
    });
  }

  // 音楽を変更
  Future<void> changeMusic() async {
    SharedPreferencesLogic sharedPreferencesLogic = SharedPreferencesLogic();
    await sharedPreferencesLogic.setSelectedMusic(_music!);
    setState(() {
      _musicName = _musicNameMap[_music!];
    });
  }

  // init時に渡されたalarmTimeをalarmHourとalarmMinuteに分割
  Future<void> splitAlarmTime() async {
    if (widget.argumentAlarmTime != null) {
      setState(() {
        _alarmHour = widget.argumentAlarmTime! ~/ 60;
        _alarmMinute = widget.argumentAlarmTime! % 60;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Constant.subYellow,
      body: Stack(
        fit: StackFit.expand,
        children: [
          // 背景画像
          Image.asset(
            "assets/pages/${Constant.themeName}/dots/alarm_page.png",
            fit: BoxFit.cover,
          ),

          Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const SizedBox(
                  height: 60,
                ),
                // 時刻設定
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(25),
                    ),
                    side: const BorderSide(
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
                  },
                  child: SizedBox(
                    width: 270,
                    height: 110,
                    child: Column(
                      children: [
                        const SizedBox(height: 23),
                        Row(
                          children: [
                            const SizedBox(width: 10),
                            Image.asset(
                              "assets/icon/alarm_icon.png",
                              width: 40,
                            ),
                            const SizedBox(width: 10),
                            const CustomText(
                                text: '時刻設定',
                                fontSize: 20,
                                Color: Constant.gray),
                          ],
                        ),
                        Align(
                            alignment: Alignment(0.9, 0),
                            child: CustomText(
                              text:
                                  '${_alarmHour.toString().padLeft(2, '0')}:${_alarmMinute.toString().padLeft(2, '0')}',
                              fontSize: 25,
                              Color: Constant.gray,
                            )),
                      ],
                    ),
                  ),
                ),

                const SizedBox(height: 20),

                //　アラーム音設定
                Container(
                  alignment: Alignment.center,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(25),
                      ),
                      side: const BorderSide(
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
                        // print(selectedAlarm);
                      }
                    },
                    // アラーム音設定
                    child: SizedBox(
                      width: 270,
                      height: 110,
                      child: Column(
                        children: [
                          const SizedBox(height: 20),
                          Row(
                            children: [
                              const SizedBox(width: 12),
                              Image.asset(
                                "assets/icon/music_icon.png",
                                width: 32,
                              ),
                              const SizedBox(width: 15),
                              const CustomText(
                                  text: 'アラーム音設定',
                                  fontSize: 20,
                                  Color: Constant.gray),
                            ],
                          ),
                          const SizedBox(height: 14),
                          Align(
                            alignment: Alignment(0.9, 0),
                            child: CustomText(
                                text: '♪ $_musicName',
                                fontSize: 19,
                                Color: Constant.gray),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),

                const SizedBox(height: 35),

                // 変更内容保存ボタン
                ElevateButton(
                  title: "保存",
                  width: 160,
                  height: 50,
                  fontSize: 20,
                  shape: 16,
                  onPressed: () async {
                    saveAlarm();
                    // sharedPreferencesにアラームを鳴らす時刻を保存
                    SharedPreferencesLogic sharedPreferencesLogic =
                        SharedPreferencesLogic();
                    sharedPreferencesLogic.setAlarmTime(_alarmTime!);
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: ((context) => const NavBar())),
                    );
                  },
                ),
                const SizedBox(height: 12),
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
                      MaterialPageRoute(builder: ((context) => const NavBar())),
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
// ignore: camel_case_types
class _alarmSelectorDialog extends StatelessWidget {
  _alarmSelectorDialog({
    Key? key,
    this.music,
  }) : super(key: key);

  // 選択中のアラーム音
  final String? music;

  static const _musics = ['サーカス', 'ドミノ', '伽藍堂', '火の車', 'お正月'];
  //TODO: アラーム音のファイル名を入れる
  //　これ逆にしたらいけそう
  final Map<String, String> _musicNameMap = {
    "circus": "サーカス",
    "domino": "ドミノ",
    "garandou": "伽藍堂",
    "hinokuruma": "火の車",
    "osyogatsu": "お正月",
  };

  @override
  Widget build(BuildContext context) {
    return SimpleDialog(
      children: _musics
          .map(
            (p) => ListTile(
              leading: Visibility(
                visible: p == music,
                child: Icon(
                  Icons.circle,
                  color: Constant.main, //accentYellow
                ),
              ),
              title: Text(
                p,
                style: GoogleFonts.zenMaruGothic(
                  fontWeight: FontWeight.bold,
                  fontSize: 21,
                  color: Constant.gray,
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
