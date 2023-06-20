import 'package:shared_preferences/shared_preferences.dart';

class SharedPreferencesLogic {
  // firebaseのグループID
  static const keyGroupID = 'groupID';
  // firebaseのユーザーID
  static const keyUserID = 'userID';
  // 現在のポイント
  static const keyCurrentPoint = 'currentPoint';
  // 選択の音楽
  static const keySelectedMusic = 'music';
  // 選択テーマ
  static const keySelectedTheme = 'theme';
  // 選択キャラクター
  static const keySelectedCharacter = 'character';
  // アラームのONOFF
  static const keySettedAlarm = 'settedAlarm';
  // NFCを登録しているかどうか
  static const keyRegisteredNFC = 'registeredNFC';

  late SharedPreferences sharedPreferences;

  // groupIDをローカルに保存
  Future<void> setGroupID(String groupID) async {
    await sharedPreferences.setString(keyGroupID, groupID);
  }

  // userIDをローカルに保存
  Future<void> setUserID(String userID) async {
    await sharedPreferences.setString(keyUserID, userID);
  }

  // 現在のポイントをローカルに保存
  Future<void> setCurrentPoint(int currentPoint) async {
    await sharedPreferences.setInt(keyCurrentPoint, currentPoint);
  }

  // アラームのON/OFFをローカルに保存
  Future<void> setSettedAlarm(bool settedAlarm) async {
    await sharedPreferences.setBool(keySettedAlarm, settedAlarm);
  }

  // NFCを登録しているかどうかをローカルに保存
  Future<void> setRegisteredNFC(bool registeredNFC) async {
    await sharedPreferences.setBool(keyRegisteredNFC, registeredNFC);
  }

  // 選択の音楽をローカルに保存
  Future<void> setSelectedMusic(String selectedMusic) async {
    await sharedPreferences.setString(keySelectedMusic, selectedMusic);
  }

  // 選択テーマをローカルに保存
  Future<void> setSelectedTheme(String selectedTheme) async {
    await sharedPreferences.setString(keySelectedTheme, selectedTheme);
  }

  // 選択キャラクターをローカルに保存
  Future<void> setSelectedCharacter(String selectedCharacter) async {
    await sharedPreferences.setString(keySelectedCharacter, selectedCharacter);
  }

  // userIDをローカルから取得
  Future<String?> getUserID() async {
    return sharedPreferences.getString(keyUserID);
  }

  // groupIDをローカルから取得
  Future<String?> getGroupID() async {
    return sharedPreferences.getString(keyGroupID);
  }

  // 現在のポイントをローカルから取得
  Future<int?> getCurrentPoint() async {
    return sharedPreferences.getInt(keyCurrentPoint);
  }

  // アラームのON/OFFをローカルから取得
  Future<bool?> getSettedAlarm() async {
    return sharedPreferences.getBool(keySettedAlarm);
  }

  // NFCを登録しているかどうかをローカルから取得
  Future<bool?> getRegisteredNFC() async {
    return sharedPreferences.getBool(keyRegisteredNFC);
  }

  // 選択の音楽をローカルから取得
  Future<String?> getSelectedMusic() async {
    return sharedPreferences.getString(keySelectedMusic);
  }

  // 選択テーマをローカルから取得
  Future<String?> getSelectedTheme() async {
    return sharedPreferences.getString(keySelectedTheme);
  }

  // 選択キャラクターをローカルから取得
  Future<String?> getSelectedCharacter() async {
    return sharedPreferences.getString(keySelectedCharacter);
  }

  // ローカルに保存されているデータを全て削除
  Future<void> clearAllData() async {
    await sharedPreferences.clear();
  }

  // ローカルに保存されているデータを全て取得
  Future<Map<String, dynamic>> getAllData() async {
    return sharedPreferences.getKeys().fold<Map<String, dynamic>>(
        {}, (map, key) => map..[key] = sharedPreferences.get(key));
  }
}
