import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:kishoutenketsu_rta/view/constant.dart';
import 'package:kishoutenketsu_rta/view/pages/gatcha_page.dart';
import 'package:kishoutenketsu_rta/view/pages/lanking_page.dart';
import 'package:kishoutenketsu_rta/view/pages/main_page.dart';

class NavBar extends StatefulWidget {
  const NavBar({super.key});

  @override
  State<NavBar> createState() => _NavBarState();
}

class _NavBarState extends State<NavBar> {
  List<StatefulWidget> _selectPage = [];
  //自分が見ているページ
  var _selectedIndex = 1;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        // titleをcenter固定
        centerTitle: true,
        // 戻るボタンオフ
        automaticallyImplyLeading: false,
        // ロゴ表示
        title: Image.asset(
          'assets/logo.png',
          height: 40,
          width: 120,
        ),
        backgroundColor: Constant.mainColor,
        actions: <Widget>[
          IconButton(
              icon: const ImageIcon(
                AssetImage('assets/icon/setting_icon.png'),
                color: Constant.white,
              ),
              onPressed: () {
                showModalBottomSheet(
                  context: context,
                  builder: (context) {
                    return _bottomSheetWidget(context);
                  },
                );
              })
        ],
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
          Positioned(
            bottom: 15,
            right: 10,
            child: FloatingActionButton(
              backgroundColor: Constant.white,
              foregroundColor: Constant.mainColor,
              onPressed: (() {}),
              child: const Icon(Icons.question_mark),
            ),
          ),
        ],
      ),
      bottomNavigationBar: CurvedNavigationBar(
        index: _selectedIndex,
        height: 75,
        color: Constant.mainColor,
        //背景色と同色
        backgroundColor: Constant.subColor,
        items: const <Widget>[
          ImageIcon(
            AssetImage(
              'assets/icon/ranking_icon.png',
            ),
            color: Constant.white,
            size: 30,
          ),
          ImageIcon(
            AssetImage('assets/icon/home_icon.png'),
            color: Constant.white,
            size: 30,
          ),
          ImageIcon(
            AssetImage('assets/icon/gatcha_icon.png'),
            color: Constant.white,
            size: 30,
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

// import 'package:curved_navigation_bar/curved_navigation_bar.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter/src/widgets/container.dart';
// import 'package:flutter/src/widgets/framework.dart';

// import '../view/constant.dart';

//         body: Container(
//           color: Colors.blueAccent,
//           child: Center(
//             child: Text(toString(), textScaleFactor: 10.0),
//           ),
//         ));
//   }

// 設定の中
Widget _bottomSheetWidget(BuildContext context) {
  return SizedBox(
      height: 400,
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: ListView(
          children: [
            ListTile(
              leading: const Icon(Icons.settings, size: 36),
              title: const Text('設定'),
              onTap: () {},
            ),
          ],
        ),
      ));
}


//}


