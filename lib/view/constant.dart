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

  static String groupID = "groupID";

  static void updateGroupID(String newGroupID) {
    groupID = newGroupID;
    sharedPreferencesLogic.setGroupID(newGroupID);
  }

  static Map<String, String> nfcs = {};
  static void updateNfcs(Map<String, String> newNfcs) {
    nfcs = newNfcs;
  }
}
