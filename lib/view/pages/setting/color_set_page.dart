import 'package:flutter/material.dart';
import 'package:kishoutenketsu_rta/logic/nav_bar.dart';
import '../../constant.dart';
import '../components/custom_text.dart';
import '../components/outline_button.dart';

class ColorSetPage extends StatefulWidget {
  const ColorSetPage({super.key});

  @override
  State<ColorSetPage> createState() => _ColorSetPageState();
}

class _ColorSetPageState extends State<ColorSetPage> {
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
                  // TODO: 押したカラーによって色が変わる処理
                  child: Image.asset('assets/theme/yellow/chicken_on.png'),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(),
                child: InkWell(
                  onTap: () {
                    Constant.updateColors(
                        Constant.yellow, Constant.subYellow, "yellow");
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
                    Constant.updateColors(Constant.red, Constant.subRed, "red");
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
                    Constant.updateColors(
                        Constant.blue, Constant.subBlue, "blue");
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
                nextPage: NavBar(),
                // onPressed: () {
                // TODO:保存処理
                // },
              ),
            ],
          ),
        ],
      ),
    );
  }
}
