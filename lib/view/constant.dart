import 'package:flutter/material.dart';
import 'package:kishoutenketsu_rta/logic/shared_preferences_logic.dart';

// 定数を管理するクラス
class Constant {
  // gray
  static const Color gray = Color(0xFF9C958F);
  // white
  static const Color white = Colors.white;

  // yellow
  static const Color yellow = Color(0xFFFFE475);
  static const Color accentYellow =
      Color(0xFFFFDC4F); // yellowが薄くて文字が見えない時に使うyellowのちょっと濃いver.
  static const Color subYellow = Color(0xFFFFF9DD);

  // blue
  static const Color blue = Color(0xFF65E4E4);
  static const Color subBlue = Color(0xFFC8FFFF);

  // red
  static const Color red = Color(0xFFFFB6A6);
  static const Color subRed = Color(0xFFFFEAE5);

  static Color main = yellow;
  static Color sub = subYellow;
  static String themeName = "yellow";

  static void updateColors(
      Color newMain, Color newSub, String argumentThemeName) {
    main = newMain;
    sub = newSub;
    themeName = argumentThemeName;
    sharedPreferencesLogic.setSelectedColor(argumentThemeName);
  }

  static SharedPreferencesLogic sharedPreferencesLogic =
      SharedPreferencesLogic();

  // アラームON/OFF
  static bool alarmONOFF = false;

  static void updateAlarmONOFF(bool newAlarmONOFF) {
    alarmONOFF = newAlarmONOFF;
    sharedPreferencesLogic.setSettedAlarm(newAlarmONOFF);
  }

  // 設定したアラーム時刻
  static int alarmTime = 0;

  static void updateAlarmTime(int newAlarmTime) {
    alarmTime = newAlarmTime;
    sharedPreferencesLogic.setAlarmTime(newAlarmTime);
  }

  // 設定した壁紙
  static String wallpaper = "dots";

  static void updateWallpaper(String newWallpaper) {
    wallpaper = newWallpaper;
    sharedPreferencesLogic.setSelectedWallpaper(newWallpaper);
  }

  // ユーザ名
  static String userName = "user";

  static void updateUserName(String newUserName) {
    userName = newUserName;
    sharedPreferencesLogic.setUserName(newUserName);
  }

  // 選択した音楽
  static String music = "circus";

  static void updateMusic(String newMusic) {
    music = newMusic;
    sharedPreferencesLogic.setSelectedMusic(newMusic);
  }
}
