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
  static const keyExistsNFC = 'ExistsNFC';

  late SharedPreferences sharedPreferences;

  // groupIDをローカルに保存
  Future<void> setGroupID(String groupID) async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    await sharedPreferences.setString(keyGroupID, groupID);
  }

  // userIDをローカルに保存
  Future<void> setUserID(String userID) async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    await sharedPreferences.setString(keyUserID, userID);
  }

  // 現在のポイントをローカルに保存
  Future<void> setCurrentPoint(int currentPoint) async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    await sharedPreferences.setInt(keyCurrentPoint, currentPoint);
  }

  // アラームのON/OFFをローカルに保存
  Future<void> setSettedAlarm(bool settedAlarm) async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    await sharedPreferences.setBool(keySettedAlarm, settedAlarm);
  }

  // NFCを登録しているかどうかをローカルに保存
  Future<void> setExistsNFC(bool existsNFC) async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    await sharedPreferences.setBool(keyExistsNFC, existsNFC);
  }

  // 選択の音楽をローカルに保存
  Future<void> setSelectedMusic(String selectedMusic) async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    await sharedPreferences.setString(keySelectedMusic, selectedMusic);
  }

  // 選択テーマをローカルに保存
  Future<void> setSelectedTheme(String selectedTheme) async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    await sharedPreferences.setString(keySelectedTheme, selectedTheme);
  }

  // 選択キャラクターをローカルに保存
  Future<void> setSelectedCharacter(String selectedCharacter) async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    await sharedPreferences.setString(keySelectedCharacter, selectedCharacter);
  }

  // userIDをローカルから取得
  Future<String?> getUserID() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    return sharedPreferences.getString(keyUserID);
  }

  // groupIDをローカルから取得
  Future<String?> getGroupID() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    return sharedPreferences.getString(keyGroupID);
  }

  // 現在のポイントをローカルから取得
  Future<int?> getCurrentPoint() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    return sharedPreferences.getInt(keyCurrentPoint);
  }

  // アラームのON/OFFをローカルから取得
  Future<bool?> getSettedAlarm() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    return sharedPreferences.getBool(keySettedAlarm);
  }

  // NFCを登録しているかどうかをローカルから取得
  Future<bool?> getExistsNFC() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    return sharedPreferences.getBool(keyExistsNFC);
  }

  // 選択の音楽をローカルから取得
  Future<String?> getSelectedMusic() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    return sharedPreferences.getString(keySelectedMusic);
  }

  // 選択テーマをローカルから取得
  Future<String?> getSelectedTheme() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    return sharedPreferences.getString(keySelectedTheme);
  }

  // 選択キャラクターをローカルから取得
  Future<String?> getSelectedCharacter() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    return sharedPreferences.getString(keySelectedCharacter);
  }

  // ローカルに保存されているデータを全て削除
  Future<void> clearAllData() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    await sharedPreferences.clear();
  }

  // ローカルに保存されているデータを全て取得
  Future<Map<String, dynamic>> getAllData() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    return sharedPreferences.getKeys().fold<Map<String, dynamic>>(
        {}, (map, key) => map..[key] = sharedPreferences.get(key));
  }
}
