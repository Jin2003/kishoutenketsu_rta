import 'package:kishoutenketsu_rta/logic/shared_preferences_logic.dart';

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
  // 壁紙
  // キャラクター
  static String characterName = "chicken";

  static void updateCharacterName(String newCharacterName) {
    characterName = newCharacterName;
    sharedPreferencesLogic.setSelectedCharacter(newCharacterName);
  }
  // テーマカラー

  // アラームON/OFF
  static bool alarmONOFF = false;

  static void updateAlarmONOFF(bool newAlarmONOFF) {
    alarmONOFF = newAlarmONOFF;
    sharedPreferencesLogic.setSettedAlarm(newAlarmONOFF);
  }

  // 前回何時に設定したアラーム時刻
  // datatimeにする方がいいと思う
  static int alarmTime = 0;

  static void updateAlarmTime(int newAlarmTime) {
    alarmTime = newAlarmTime;
    sharedPreferencesLogic.setAlarmTime(newAlarmTime);
  }
}
