import 'package:alarm/alarm.dart';
import 'package:flutter/material.dart';
import 'package:kishoutenketsu_rta/view/pages/rta_page.dart';

class AlarmSetting {
  Future<void> setting(
    DateTime alarmTime,
    String? music,
    int id,
    BuildContext context,
  ) async {
    // アラームの設定を作成
    final alarmSettings = AlarmSettings(
      id: id,
      dateTime: alarmTime,
      assetAudioPath: "assets/alarm/$music.mp3",
      loopAudio: true,
      vibrate: false,
      volumeMax: false,
      fadeDuration: 3.0,
      notificationTitle: 'さあRTA開始だ!',
      notificationBody: 'ランキング一位を目指せ！',
      enableNotificationOnKill: true,
    );
    print("$music.mp3を設定したよ!");
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
