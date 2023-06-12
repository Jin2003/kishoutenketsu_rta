import 'package:flutter/material.dart';
import 'package:kishoutenketsu_rta/view/pages/start_page.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';

void main() {
  // 画面の向きを固定
  // SystemChrome.setPreferredOrientations([
  //   DeviceOrientation.portraitUp,
  // ]);

  //スプラッシュ画面の設定
  final widgetsBinding = WidgetsFlutterBinding.ensureInitialized();
  FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      //デバッグマークオフ
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.lightBlue,
      ),
      home: const StartPage(),
    );
  }
}
