import 'package:geolocator/geolocator.dart';


class UserPosition {
  /// デバイスの現在位置を決定する。
  /// 位置情報サービスが有効でない場合、または許可されていない場合。
  /// エラーを返す。
  Future<Position> determinePosition() async {
    bool serviceEnabled;
    LocationPermission permission;

    // 位置情報サービスが有効かどうかをテスト
    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      // 位置情報サービスを有効にするようアプリに要請する。
      return Future.error('位置情報を有効にしてね.');
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      // ユーザーに位置情報を許可してもらうよう促す
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        // 拒否された場合エラーを返す
        return Future.error('位置情報を有効にしてね');
      }
    }
    
    // 永久に拒否されている場合のエラーを返す
    if (permission == LocationPermission.deniedForever) {
      return Future.error(
        '位置情報を有効にしてね');
    } 

    // デバイスの位置情報を返す。
    return await Geolocator.getCurrentPosition(desiredAccuracy : LocationAccuracy.high);
  }
}