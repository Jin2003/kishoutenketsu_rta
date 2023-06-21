import 'package:flutter/material.dart';
import 'package:kishoutenketsu_rta/logic/nav_bar.dart';
import 'package:kishoutenketsu_rta/logic/shared_preferences_logic.dart';
import 'package:kishoutenketsu_rta/view/pages/log_in.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';
import 'package:dart_openai/dart_openai.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  //スプラッシュ画面の設定
  final widgetsBinding = WidgetsFlutterBinding.ensureInitialized();
  FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);
  // .evnから環境変数を読み込む
  await dotenv.load(fileName: '.env');
  OpenAI.apiKey = dotenv.get('OPEN_AI_API_KEY');
  // 画面の向きを固定
  // SystemChrome.setPreferredOrientations([
  //   DeviceOrientation.portraitUp,
  // ]);
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  // TODO:removeしないとずっとスプラッシュ画面が表示される(かまのに後で聞く)
  FlutterNativeSplash.remove();

  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  bool isExistsNFC = false; // デフォルト値を設定しておく

  @override
  void initState() {
    super.initState();
    initializeNFC(); // initState内で非同期の初期化処理を実行
  }

  Future<void> initializeNFC() async {
    SharedPreferencesLogic sharedPreferencesLogic = SharedPreferencesLogic();
    bool? nfcResult = await sharedPreferencesLogic.getExistsNFC();
    setState(() {
      isExistsNFC = nfcResult ?? false; // 取得した結果を変数に代入
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      // デバッグマークオフ
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.lightBlue,
      ),

      // isExistsNFCの値に応じて遷移先を決定
      home: isExistsNFC ? const NavBar() : const LogIn(),
    );
  }
}
