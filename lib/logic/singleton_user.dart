import 'dart:ui';

import 'package:kishoutenketsu_rta/logic/shared_preferences_logic.dart';
import 'package:kishoutenketsu_rta/view/constant.dart';

class SingletonUser {
  static SharedPreferencesLogic sharedPreferencesLogic =
      SharedPreferencesLogic();

  // グループID
  static String groupID = "groupID";

  static void updateGroupID(String newGroupID) {
    groupID = newGroupID;
    sharedPreferencesLogic.setGroupID(newGroupID);
  }

  // ユーザID
  static String userID = "userID";

  static void updateUserID(String newUserID) {
    userID = newUserID;
    sharedPreferencesLogic.setUserID(newUserID);
  }

  // 壁紙
  static String wallpaper = "dots";

  static void updateWallpaper(String newWallpaper) {
    wallpaper = newWallpaper;
    sharedPreferencesLogic.setSelectedWallpaper(newWallpaper);
  }

  // キャラクター
  static String characterName = "chicken";

  static void updateCharacterName(String newCharacterName) {
    characterName = newCharacterName;
    sharedPreferencesLogic.setSelectedCharacter(newCharacterName);
  }

  // テーマカラー
  static Color main = Constant.yellow;
  static Color sub = Constant.subYellow;
  static String themeName = "yellow";

  static final Map<String, Color> mainThemes = {
    "yellow": Constant.yellow,
    "blue": Constant.blue,
    "red": Constant.red,
    "green": Constant.green,
    "orange": Constant.orange,
  };

  static final Map<String, Color> subThemes = {
    "yellow": Constant.subYellow,
    "blue": Constant.subBlue,
    "red": Constant.subRed,
    "green": Constant.subGreen,
    "orange": Constant.subOrange,
  };

  static void updateColors(String argumentThemeName) {
    main = mainThemes[argumentThemeName]!;
    sub = subThemes[argumentThemeName]!;
    themeName = argumentThemeName;
    sharedPreferencesLogic.setSelectedColor(argumentThemeName);
  }

  // アラームON/OFF
  static bool settedAlarm = false;

  static void updateAlarmONOFF(bool newSettedAlarm) {
    settedAlarm = newSettedAlarm;
    sharedPreferencesLogic.setSettedAlarm(newSettedAlarm);
  }

  // 前回何時に設定したアラーム時刻
  // datatimeにする方がいいと思う
  static int alarmTime = 0;

  static void updateAlarmTime(int newAlarmTime) {
    alarmTime = newAlarmTime;
    sharedPreferencesLogic.setAlarmTime(newAlarmTime);
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
