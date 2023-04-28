import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:kishoutenketsu_rta/view/pages/start_page.dart';

void main() {
  // 画面の向きを固定
  // SystemChrome.setPreferredOrientations([
  //   DeviceOrientation.portraitUp,
  // ]);

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      //　デバッグマークオフ
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.lightBlue,
      ),
      home: const StartPage(),
    );
  }
}
