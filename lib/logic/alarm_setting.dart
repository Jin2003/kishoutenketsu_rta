import 'package:alarm/alarm.dart';
import 'package:flutter/material.dart';
import 'package:kishoutenketsu_rta/view/pages/rta_page.dart';

class AlarmSetting {
  Future<void> setting(
    int timeInMinutes,
    String music,
    int id,
    BuildContext context,
  ) async {
    
    // intからDateTimeに変換する
    int hours = timeInMinutes ~/ 60;
    int minutes = timeInMinutes % 60;

    // 現在の年月日を取得
    DateTime now = DateTime.now();
    DateTime alarmTime = DateTime(now.year, now.month, now.day, hours, minutes);

    // アラームの設定を作成
    final alarmSettings = AlarmSettings(
      id: id,
      dateTime: alarmTime,
      assetAudioPath: 'assets/alarm/$music.mp3',
      loopAudio: true,
      vibrate: true,
      volumeMax: false,
      fadeDuration: 3.0,
      // notificationTitle: 'さあRTA開始だ！',
      // notificationBody: 'さあRTA開始だ！',
      enableNotificationOnKill: true,
    );

    print("$alarmTimeのアラームを設定したよ!");

    // アラームを登録
    await Alarm.set(alarmSettings: alarmSettings);

    //アラームが鳴ったらrta_pageに遷移
    Alarm.ringStream.stream.listen((event) { 
      print("アラームが鳴ってるよ！");
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: ((context) =>
            const RtaPage())),
      );
    });
  }
}
