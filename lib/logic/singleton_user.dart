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
  // テーマカラー
}
