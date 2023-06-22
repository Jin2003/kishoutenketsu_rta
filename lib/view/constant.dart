import 'package:flutter/material.dart';

// 定数を管理するクラス
class Constant {
  // ignore: constant_identifier_names
  static const Color blue = Color.fromARGB(255, 89, 216, 212);
  // ignore: constant_identifier_names
  static const Color subBlue = Color(0xffc8ffff);
  // ignore: constant_identifier_names
  static const Color white = Colors.white;

  static const Color yellow = Color(0xFFFFE475);
  // yellowが薄くて文字が見えない時に使うyellowのちょっと濃いver.
  static const Color accentYellow = Color(0xFFFFDC4F);
  static const Color subYellow = Color(0xFFFFF9DD);

  static const Color gray = Color(0xFF9C958F);

  static const Color main = yellow;
  static const Color sub = subYellow;
}
