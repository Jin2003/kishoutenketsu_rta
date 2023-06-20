import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:kishoutenketsu_rta/view/constant.dart';
import 'package:kishoutenketsu_rta/view/pages/setting/chara_set_page.dart';
import 'package:kishoutenketsu_rta/view/pages/components/custom_text.dart';
import 'package:kishoutenketsu_rta/view/pages/gatcha_page.dart';
import 'package:kishoutenketsu_rta/view/pages/setting/help_page.dart';
import 'package:kishoutenketsu_rta/view/pages/setting/invitation_page.dart';
import 'package:kishoutenketsu_rta/view/pages/join_page.dart';
import 'package:kishoutenketsu_rta/view/pages/lanking_page.dart';
import 'package:kishoutenketsu_rta/view/pages/log_in.dart';
import 'package:kishoutenketsu_rta/view/pages/main_page.dart';
import 'package:kishoutenketsu_rta/view/pages/setting/wallpaper_set_page.dart';

import '../view/pages/setting/account_set_page.dart';

class NavBar extends StatefulWidget {
  const NavBar({super.key});

  @override
  State<NavBar> createState() => _NavBarState();
}

class _NavBarState extends State<NavBar> {
  List<StatefulWidget> _selectPage = [];
  //自分が見ているページ
  var _selectedIndex = 1;
  // ScaffoldStateのGlobalKeyを変数として定義
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

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

        backgroundColor: Constant.yellow,

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
                      context, 'color_icon', 'テーマカラー変更', const NavBar()),
                  _DrawerWidget(context, 'wallpaper_icon', '壁紙変更',
                      const WallpaperSetPage()),
                  _DrawerWidget(context, 'adduser_icon', 'グループ招待',
                      const InvitationPage()),
                  _DrawerWidget(
                      context, 'invitaion_icon', 'グループ参加', const JoinPage()),
                  _DrawerWidget(context, 'help_icon', 'ヘルプ', const HelpPage()),
                ],
              ),
            ),
            // ログアウトボタン
            TextButton(
              onPressed: () async {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: ((context) => const LogIn())),
                );
              },
              child: const CustomText(
                text: 'ログアウト',
                Color: Constant.accentYellow,
                fontSize: 20,
              ),
            ),
            const SizedBox(height: 20),
          ],
        ),
      ),

      body: Stack(
        children: [
          Builder(
            builder: (context) {
              _selectPage = [
                const LankingPage(),
                const MainPage(),
                const GatchaPage(),
              ];
              return _selectPage[_selectedIndex];
            },
          ),
        ],
      ),
      bottomNavigationBar: CurvedNavigationBar(
        index: _selectedIndex,
        height: 75,
        color: Constant.yellow,
        //背景色と同色
        backgroundColor: Constant.subYellow,
        items: const <Widget>[
          ImageIcon(
            AssetImage(
              'assets/icon/ranking_icon.png',
            ),
            color: Constant.white,
            size: 40,
          ),
          ImageIcon(
            AssetImage('assets/icon/home_icon.png'),
            color: Constant.white,
            size: 40,
          ),
          ImageIcon(
            AssetImage('assets/icon/gatcha_icon.png'),
            color: Constant.white,
            size: 40,
          ),
        ],
        onTap: (index) {
          setState(() {
            _selectedIndex = index;
          });
        },
      ),
    );
  }
}

// ハンバーガーメニューの中
// ignore: non_constant_identifier_names
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
