import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:kishoutenketsu_rta/logic/firebase_helper.dart';
import 'package:kishoutenketsu_rta/logic/nav_bar.dart';
import 'package:kishoutenketsu_rta/logic/shared_preferences_logic.dart';
import 'package:kishoutenketsu_rta/view/pages/have_nfc.dart';
import 'package:kishoutenketsu_rta/view/pages/log_in.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  //スプラッシュ画面の設定
  final widgetsBinding = WidgetsFlutterBinding.ensureInitialized();
  FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);

  // TODO.evnから環境変数を読み込む
  // await dotenv.load(fileName: '.env');
  // OpenAI.apiKey = dotenv.get('OPEN_AI_API_KEY');

  // 画面の向きを固定
  // SystemChrome.setPreferredOrientations([
  //   DeviceOrientation.portraitUp,
  // ]);
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  // groupIDを取得する
  Future<String> getGroupID(String userId) async {
    String groupID = await FirebaseHelper().getGroupID(
      userId,
    );
    return groupID;
  }

  Future<void> updateSingletonUser() async {
    SharedPreferencesLogic().updateSingletonUser();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      // デバッグマークオフ
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.lightBlue,
      ),
      // ログイン状態を監視し、状態によって表示する画面を変更
      home: StreamBuilder<User?>(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            // スプラッシュ画面などに書き換えても良い
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
          FlutterNativeSplash.remove();
          // Userがサインインしているかどうかで条件分岐
          if (snapshot.hasData) {
            // グループに所属しているかどうか
            getGroupID(snapshot.data!.uid).then((value) {
              if (value == '') {
                // グループに所属していない場合、NFCを持っているかの画面に。
                return const HaveNfc();
              }
            });
            // サインイン済みなら
            // Shared_preferencesからSingletonUserの値を更新する関数
            updateSingletonUser();
            return const NavBar();
          }
          // サインインしていないなら
          return const LogIn();
        },
      ),
    );
  }
}
