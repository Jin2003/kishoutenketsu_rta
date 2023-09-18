import 'package:flutter/material.dart';
import 'package:kishoutenketsu_rta/logic/nav_bar.dart';
import 'package:kishoutenketsu_rta/logic/shared_preferences_logic.dart';
import 'package:kishoutenketsu_rta/logic/singleton_user.dart';
import '../../constant.dart';
import '../components/custom_text.dart';
import '../components/outline_button.dart';

class ColorSetPage extends StatefulWidget {
  const ColorSetPage({super.key});

  @override
  State<ColorSetPage> createState() => _ColorSetPageState();
}

class _ColorSetPageState extends State<ColorSetPage> {
  Color selectedMainColor = SingletonUser.main;
  Color selectedSubColor = SingletonUser.sub;
  String selectedThemeName = SingletonUser.themeName;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Constant.white,
      body: Column(
        children: [
          const SizedBox(height: 40),
          // < のアイコン表示
          Align(
            alignment: const Alignment(-0.9, 0),
            child: IconButton(
              iconSize: 22,
              icon: const ImageIcon(
                AssetImage('assets/icon/close_icon.png'),
                color: Constant.gray,
              ),
              onPressed: () async {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: ((context) => const NavBar())),
                );
              },
            ),
          ),
          const CustomText(text: 'テーマカラー', fontSize: 22, Color: Constant.gray),
          const SizedBox(height: 20),

          Container(
            width: 380,
            decoration: const BoxDecoration(
              border:
                  Border(bottom: BorderSide(color: Constant.gray, width: 2)),
            ),
          ),
          Column(
            children: [
              const SizedBox(
                height: 30,
              ),
              const CustomText(
                  text: '選択中のカラー', fontSize: 22, Color: Constant.gray),
              const SizedBox(height: 20),
              Padding(
                padding: const EdgeInsets.only(),
                child: SizedBox(
                  height: 125,
                  width: 125,
                  child: Image.asset(
                      'assets/theme/$selectedThemeName/chicken_on.png'),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(),
                child: InkWell(
                  onTap: () {
                    selectedThemeName = "yellow";
                    setState(() {});
                  },
                  child: SizedBox(
                    height: 100,
                    width: 350,
                    child: Image.asset('assets/theme/yellow/color.png'),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(3.0),
                child: InkWell(
                  onTap: () {
                    selectedThemeName = "red";
                    setState(() {});
                  },
                  child: SizedBox(
                    height: 100,
                    width: 350,
                    child: Image.asset('assets/theme/red/color.png'),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(3.0),
                child: InkWell(
                  onTap: () {
                    selectedThemeName = "blue";
                    setState(() {});
                  },
                  child: SizedBox(
                    height: 100,
                    width: 350,
                    child: Image.asset('assets/theme/blue/color.png'),
                  ),
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              OutlineButton(
                title: '保存',
                width: 170,
                height: 50,
                fontsize: 20,
                shape: 15,
                nextPage: const NavBar(),
                onPressed: () {
                  // TODO:shared_preferencesに保存する処理
                  SingletonUser.updateColors(selectedThemeName);
                },
              ),
            ],
          ),
        ],
      ),
    );
  }
}
