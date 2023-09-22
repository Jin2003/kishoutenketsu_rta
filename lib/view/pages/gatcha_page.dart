import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:kishoutenketsu_rta/logic/firebase_helper.dart';
import 'package:kishoutenketsu_rta/logic/shared_preferences_logic.dart';
import 'package:kishoutenketsu_rta/logic/singleton_user.dart';
import 'package:kishoutenketsu_rta/view/pages/components/custom_text.dart';
import 'package:kishoutenketsu_rta/view/pages/components/outline_button.dart';
import 'package:kishoutenketsu_rta/view/pages/join_group.dart';
import 'package:kishoutenketsu_rta/view/pages/log_in.dart';
import 'package:kishoutenketsu_rta/view/pages/rta_page.dart';
import 'package:kishoutenketsu_rta/view/pages/setting/account_set_page.dart';
import 'package:kishoutenketsu_rta/view/pages/setting/chara_set_page.dart';
import 'package:kishoutenketsu_rta/view/pages/setting/color_set_page.dart';
import 'package:kishoutenketsu_rta/view/pages/setting/help_page.dart';
import 'package:kishoutenketsu_rta/view/pages/setting/invitation_page.dart';
import 'package:kishoutenketsu_rta/view/pages/setting/wallpaper_set_page.dart';
import '../../logic/database_helper.dart';
import 'package:flutter_animated_dialog/flutter_animated_dialog.dart';
import 'package:lottie/lottie.dart';
import '../constant.dart';

class GatchaPage extends StatefulWidget {
  const GatchaPage({super.key});

  @override
  State<GatchaPage> createState() => _GatchaPageState();
}

class _GatchaPageState extends State<GatchaPage> {
  //現在のポイント
  int _point = 0;

  //ボタンが押されたかどうか
  bool _isPressed = false;

  // ScaffoldStateのGlobalKeyを変数として定義
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    _loadPoint();
  }

  //_pointを取得し、画面を更新する関数
  Future<void> _loadPoint() async {
    int point = await FirebaseHelper().getPoint();
    if (mounted){ 
      setState(() {
        _point = point;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        // appbarの高さ指定
        toolbarHeight: 90,
        // 影の深さ
        elevation: 5,
        // titleをcenter固定
        centerTitle: true,
        // 戻るボタンオフ
        automaticallyImplyLeading: false,
        // ロゴ表示
        title: Image.asset(
          'assets/logo.png',
          height: 50,
          width: 130,
        ),

        backgroundColor: SingletonUser.main,

        actions: <Widget>[
          // ハンバーガーボタンをカスタム
          InkWell(
            onTap: () => _scaffoldKey.currentState?.openEndDrawer(),
            child: const Row(
              children: [
                ImageIcon(
                  AssetImage('assets/icon/humberger_icon.png'),
                  color: Constant.white,
                ),
                SizedBox(width: 10),
              ],
            ),
          ),
        ],
      ),
      // 定義した _scaffoldKey をkeyプロパティに適用
      key: _scaffoldKey,

      // drawerの表示（ハンバーガーメニュー）
      endDrawer: Drawer(
        child: Column(
          children: [
            Expanded(
              child: ListView(
                padding: EdgeInsets.zero,
                children: [
                  const SizedBox(
                    height: 120,
                    child: DrawerHeader(
                      decoration: BoxDecoration(
                        color: Constant.white,
                        border: Border(
                            bottom: BorderSide(color: Constant.gray, width: 2)),
                      ),
                      child: Column(
                        children: [
                          CustomText(
                              text: '設定', fontSize: 20, Color: Constant.gray),
                        ],
                      ),
                    ),
                  ),
                  _DrawerWidget(context, 'person_icon', 'アカウント設定',
                      const AccountSetPage()),
                  _DrawerWidget(context, 'character_icon', 'キャラクター変更',
                      const CharaSetPage()),
                  // 時間があれば
                  _DrawerWidget(
                      context, 'color_icon', 'テーマカラー変更', const ColorSetPage()),
                  _DrawerWidget(context, 'wallpaper_icon', '壁紙変更',
                      const WallpaperSetPage()),
                  _DrawerWidget(context, 'adduser_icon', 'グループ招待',
                      const InvitationPage()),
                  _DrawerWidget(
                      context, 'invitaion_icon', 'グループ参加', const JoinGroup()),
                  _DrawerWidget(context, 'help_icon', 'ヘルプ', const HelpPage()),
                ],
              ),
            ),
            // ログアウトボタン
            TextButton(
              onPressed: () async {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: ((context) => const RtaPage())),
                );
              },
              child: const CustomText(
                text: 'RTAテスト',
                Color: Constant.red,
                fontSize: 20,
              ),
            ),
            TextButton(
              onPressed: () async {
                // firebaseからログアウト
                // print(Constant.groupID);
                // FirebaseHelper().getNfcIdMap();
                await FirebaseAuth.instance.signOut();
                SharedPreferencesLogic sharedPreferencesLogic =
                    SharedPreferencesLogic();
                // sharedPreferenceのデータを全て削除
                sharedPreferencesLogic.clearAllData();
                if (!mounted) return;
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: ((context) => const LogIn())),
                );
              },
              child: const CustomText(
                text: 'ログアウト',
                Color: Constant.red,
                fontSize: 20,
              ),
            ),
            const SizedBox(height: 20),
          ],
        ),
      ),
      backgroundColor: SingletonUser.sub,
      body: Stack(
        fit: StackFit.expand,
        children: [
          Image.asset(
            "assets/pages/${SingletonUser.themeName}/${SingletonUser.wallpaper}/gatcha_page.png",
            fit: BoxFit.cover,
          ),
          //画像を表示する
          Column(
            children: [
              const SizedBox(
                height: 70,
                width: 1,
              ),
              const CustomText(
                  text: '現在のポイント', fontSize: 28, Color: Constant.gray),
              const SizedBox(
                height: 10,
                width: 1,
              ),
              Container(
                alignment: Alignment.center,
                width: 260,
                height: 90,
                decoration: BoxDecoration(
                  border: Border.all(color: SingletonUser.main, width: 5),
                  borderRadius: BorderRadius.circular(60),
                  // color と boxdecorationの共存はNG
                  color: Constant.white,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      textAlign: TextAlign.center,
                      _point.toString(),
                      style: TextStyle(
                        fontSize: 50,
                        fontWeight: FontWeight.bold,
                        color: SingletonUser.main, //accentYellow
                      ),
                    ),
                    const SizedBox(
                      width: 10,
                      height: 1,
                    ),
                    Text(
                      'pt',
                      style: TextStyle(
                        fontSize: 40,
                        fontWeight: FontWeight.bold,
                        color: SingletonUser.main, //accentYellow
                      ),
                    ),
                  ],
                ),
              ),

              //ElevateButton(title: 'ガチャをまわす'),
              const SizedBox(
                //デバッグ用に300にしている
                height: 380,
                width: 1,
              ),
              //OutlineButton(title: 'e', width: 10, height: 10, fontsize: 10, shape: 10)
              //ElevateButton(title: 'ガチャをまわす'),
              SizedBox(
                width: 210,
                height: 60,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Constant.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(25),
                    ),
                    elevation: 5,
                  ),
                  onPressed: () async {
                    // ポップアップ表示
                    showDialog<void>(
                        context: context,
                        builder: (_) {
                          return AlertDialog(
                            title: const CustomText(
                                text: '10ポイント消費して\nガチャを回しますか？',
                                fontSize: 20,
                                Color: Constant.gray),
                            actions: <Widget>[
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  GestureDetector(
                                    child: OutlineButton(
                                      title: 'はい',
                                      fontsize: 15,
                                      height: 40,
                                      width: 80,
                                      shape: 10,
                                      onPressed: () async {
                                        final db = await DatabaseHelper().db;
                                        // ポイントが10ポイント以下の場合はガチャを回せない
                                        if (_point < 10) {
                                          return;
                                        }
                                        // 持っていないアイテムをランダムに1つ取得
                                        final items = await db.rawQuery(
                                            'SELECT * FROM items WHERE has_item = 0 ORDER BY RANDOM() LIMIT 1');
                                        // 持っていないアイテムがない場合は処理を終了
                                        if (items.isEmpty) {
                                          return;
                                        }
                                        setState(() {
                                          _isPressed = true;
                                        });
                                        // 引いたアイテムを所持アイテムにする
                                        await db.rawUpdate(
                                            'UPDATE items SET has_item = 1 WHERE item_id = ${items[0]["item_id"]}');
                                        //10ポイント消費する
                                        await db.rawUpdate(
                                            'UPDATE user SET point = point - 10');
                                        // 変更後のポイントの取得
                                        final point = await db
                                            .rawQuery('SELECT point FROM user');
                                        //表示するポイントの更新
                                        setState(() {
                                          _point = point[0]['point'] as int;
                                        });
                                        // ignore: use_build_context_synchronously
                                        Navigator.pop(context);
                                        // まわるポップアップ表示
                                        Future.delayed(
                                            const Duration(milliseconds: 2500),
                                            () {
                                          showAnimatedDialog<void>(
                                            context: context,
                                            builder: (_) {
                                              return AlertDialog(
                                                title: CustomText(
                                                    text:
                                                        '${items[0]["item_name"]}が当たりました！',
                                                    fontSize: 20,
                                                    Color: Constant.gray),
                                                actions: <Widget>[
                                                  Container(
                                                    alignment: Alignment.center,
                                                    child: Column(
                                                      children: [
                                                        // SizedBox(
                                                        //   height: 6,
                                                        // ),
                                                        GestureDetector(
                                                          child: OutlineButton(
                                                            fontsize: 15,
                                                            width: 80,
                                                            height: 40,
                                                            title: 'とじる',
                                                            shape: 10,
                                                            onPressed: () {
                                                              setState(() {
                                                                _isPressed =
                                                                    false;
                                                              });
                                                              Navigator.pop(
                                                                  context);
                                                            },
                                                          ),
                                                        ),
                                                        const SizedBox(
                                                          height: 20,
                                                        )
                                                      ],
                                                    ),
                                                  ),
                                                ],
                                              );
                                            },
                                            animationType: DialogTransitionType
                                                .scaleRotate,
                                            duration: const Duration(
                                                milliseconds: 300),
                                          );
                                        });
                                      },
                                    ),
                                  ),
                                  const SizedBox(
                                    width: 30,
                                    height: 0,
                                  ),
                                  GestureDetector(
                                    child: OutlineButton(
                                        title: 'いいえ',
                                        fontsize: 15,
                                        height: 40,
                                        width: 80,
                                        shape: 10,
                                        onPressed: () {
                                          Navigator.pop(context);
                                        }),
                                  ),
                                ],
                              )
                            ],
                          );
                        });
                  },
                  child: const CustomText(
                      text: 'ガチャをまわす', fontSize: 21, Color: Constant.gray),
                  // child: Text(
                  //   style: TextStyle(
                  //     color: Constant.blue,
                  //   ),
                  //   'ガチャを回す'
                  // ),
                ),
              ),
            ],
          ),
          if (_isPressed)
            Container(
              color: const Color.fromARGB(255, 11, 11, 11).withOpacity(0.5),
            ),
          //_isPressedがtrueの時に表示する
          if (_isPressed)
            Positioned(
              child: Lottie.asset(
                "assets/gacha/${SingletonUser.themeName}/capsule.json",
                fit: BoxFit.cover,
                repeat: false,
              ),
            ),
        ],
      ),
    );
  }
}

Widget _DrawerWidget(
    context, String iconName, String listTitle, Widget nextPage) {
  return ListTile(
    leading: ImageIcon(
      AssetImage('assets/icon/$iconName.png'),
      color: Constant.gray,
    ),
    title: Row(
      children: [
        CustomText(text: listTitle, fontSize: 18, Color: Constant.gray),
        const SizedBox(
          width: 0,
        ),
      ],
    ),
    // 画面遷移
    onTap: () async {
      Navigator.push(
        context,
        MaterialPageRoute(builder: ((context) => nextPage)),
      );
    },
  );
}

