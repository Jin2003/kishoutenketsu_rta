import 'package:kishoutenketsu_rta/logic/singleton_user.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SharedPreferencesLogic {
  // firebaseのグループID
  static const keyGroupID = 'groupID';
  // firebaseのユーザーID
  static const keyUserID = 'userID';
  // 選択の音楽
  static const keySelectedMusic = 'music';
  // 選択の色
  static const keySelectedColor = 'color';
  // 選択キャラクター
  static const keySelectedCharacter = 'character';
  // 選択中の壁紙
  static const keySelectedWallpaper = 'wallpaper';
  // アラームのONOFF
  static const keySettedAlarm = 'settedAlarm';
  // NFCを登録しているかどうか
  static const keyExistsNFC = 'ExistsNFC';
  // アラームを鳴らしたい時刻
  static const keyAlarmTime = 'alarmTime';
  // ユーザ名
  static const keyUserName = 'userName';

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

  // 選択の色をローカルに保存
  Future<void> setSelectedColor(String selectedColor) async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    await sharedPreferences.setString(keySelectedColor, selectedColor);
  }

  // 選択キャラクターをローカルに保存
  Future<void> setSelectedCharacter(String selectedCharacter) async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    await sharedPreferences.setString(keySelectedCharacter, selectedCharacter);
  }

  // 選択中の壁紙をローカルに保存
  Future<void> setSelectedWallpaper(String selectedWallpaper) async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    await sharedPreferences.setString(keySelectedWallpaper, selectedWallpaper);
  }

  // アラームを鳴らしたい時刻をローカルに保存
  Future<void> setAlarmTime(int alarmTime) async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    await sharedPreferences.setInt(keyAlarmTime, alarmTime);
  }

  // ユーザ名をローカルに保存
  Future<void> setUserName(String userName) async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    await sharedPreferences.setString(keyUserName, userName);
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

  // 選択キャラクターをローカルから取得
  Future<String?> getSelectedCharacter() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    return sharedPreferences.getString(keySelectedCharacter);
  }

  // 選択中の壁紙をローカルから取得
  Future<String?> getSelectedWallpaper() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    return sharedPreferences.getString(keySelectedWallpaper);
  }

  // 選択の色をローカルから取得
  Future<String?> getSelectedColor() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    return sharedPreferences.getString(keySelectedColor);
  }

  // アラームを鳴らしたい時刻をローカルから取得
  Future<int?> getAlarmTime() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    return sharedPreferences.getInt(keyAlarmTime);
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

  // ユーザ名をローカルから取得
  Future<String?> getUserName() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    return sharedPreferences.getString(keyUserName);
  }

  // Shared_preferencesからSingletonUserの値を更新する関数
  Future<void> updateSingletonUser() async {
    // ユーザID
    getUserID().then((value) => SingletonUser.userID = value!);
    // グループID
    // _TypeError (Null check operator used on a null value)
    getGroupID().then((value) => SingletonUser.groupID = value!);
    // アラームを設定しているかどうか
    getSettedAlarm().then((value) => SingletonUser.settedAlarm = value!);
    // 壁紙
    getSelectedWallpaper().then((value) => SingletonUser.wallpaper = value!);
    // キャラクター
    getSelectedCharacter()
        .then((value) => SingletonUser.characterName = value!);
    // 音楽
    getSelectedMusic().then((value) => SingletonUser.music = value!);
    // テーマカラー
    getSelectedColor().then((value) {
      SingletonUser.main = SingletonUser.mainThemes[value]!;
      SingletonUser.sub = SingletonUser.subThemes[value]!;
      SingletonUser.themeName = value!;
    });
    //アラーム時刻
    getAlarmTime().then((value) => SingletonUser.alarmTime = value!);
    // ユーザ名
    getUserName().then((value) => SingletonUser.userName = value!);
  }
}
