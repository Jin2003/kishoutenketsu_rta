import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';

import '../view/constant.dart';

class NavBar extends StatefulWidget {
  const NavBar({super.key});

  @override
  State<NavBar> createState() => _NavBarState();
}

class _NavBarState extends State<NavBar> {
  // 自分が見ているページ
  var _selectedIndex = 1;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
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
              icon: ImageIcon(
                AssetImage('assets/icon/setting_icon.png'),
              ),
              onPressed: () {
                showModalBottomSheet(
                  context: context,
                  builder: (context) {
                    return _bottomSheetWidget(context);
                  },
                );
              }
            )
          ],
        ),
        bottomNavigationBar: CurvedNavigationBar(
          initialIndex: _selectedIndex,
          items: <Widget>[
            ImageIcon(
                AssetImage('assets/icon/ranking_icon.png',),
                size: 30,
              ),
              ImageIcon(
                AssetImage('assets/icon/home_icon.png'),
                size: 30,
              ),
              ImageIcon(
                AssetImage('assets/icon/gatcha_icon.png'),
                size: 30,
              ),
          ],
          color: Constant.mainColor,
          buttonBackgroundColor: Constant.white,
          backgroundColor: Constant.subColor,
          animationCurve: Curves.easeInOut,
          animationDuration: Duration(milliseconds: 600),
          onTap: (index) {
            setState(() {
              _selectedIndex = index;
            });
          },
        ),
        body: Container(
          color: Colors.blueAccent,
          child: Center(
            child: Text(toString(), textScaleFactor: 10.0),
          ),
        ));
  }

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
}



// import 'package:curved_navigation_bar/curved_navigation_bar.dart';

// void main() => runApp(MaterialApp(home: NavBar()));

// class NavBar extends Statefulwidget {

//   @override
//   State<Navbar> createState() => _NavBarState();
// }

// class _NavBarState extends State<NavBar> {
//   int _page = 0;

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//         bottomNavigationBar: CurvedNavigationBar(
//           initialIndex: 0,
//           items: <Widget>[
//             Icon(Icons.add, size: 30),
//             Icon(Icons.list, size: 30),
//             Icon(Icons.compare_arrows, size: 30),
//             Icon(Icons.call_split, size: 30),
//             Icon(Icons.perm_identity, size: 30),
//           ],
//           color: Colors.white,
//           buttonBackgroundColor: Colors.white,
//           backgroundColor: Colors.blueAccent,
//           animationCurve: Curves.easeInOut,
//           animationDuration: Duration(milliseconds: 600),
//           onTap: (index) {
//             setState(() {
//               _page = index;
//             });
//           },
//         ),
//         body: Container(
//           color: Colors.blueAccent,
//           child: Center(
//             child: Text(_page.toString(), textScaleFactor: 10.0),
//           ),
//         ));
//   }
// }
// 