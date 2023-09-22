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

              //レッド
              Padding(
                padding: const EdgeInsets.all(3.0),
                  child: InkWell(
                    onTap: () {
                      selectedThemeName = "red";
                      setState(() {});
                    },
                    child: Container(
                      width: 340,
                      height: 70,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(22),
                        color: Constant.white,
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.2),
                            spreadRadius: 0,
                            blurRadius: 3,
                            offset: const Offset(0, 4),
                          ),
                        ],
                      ),
                      child: Row(
                        children: [
                          //カラー表示
                          Padding(
                            padding: const EdgeInsets.only(left: 25),
                            child: Container(
                              height: 55,
                              width: 55,
                              decoration: BoxDecoration(
                                color: Constant.red,
                                borderRadius: BorderRadius.circular(50),
                              ),
                            ),
                          ),
                          const SizedBox(width: 20),

                          //テキストの表示
                          const Text('red',
                            style: TextStyle(
                              fontSize: 22,
                              fontWeight: FontWeight.bold,
                              color: Constant.gray,
                            )
                          ),
                        ],
                    ),
                  ),
                ),
              ),

              const SizedBox(height: 10),

              //オレンジ
              Padding(
                padding: const EdgeInsets.all(3.0),
                  child: InkWell(
                    onTap: () {
                      selectedThemeName = "orange";
                      setState(() {});
                    },
                    child: Container(
                      width: 340,
                      height: 70,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(22),
                        color: Constant.white,
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.2),
                            spreadRadius: 0,
                            blurRadius: 3,
                            offset: const Offset(0, 4),
                          ),
                        ],
                      ),
                      child: Row(
                        children: [
                          //カラー表示
                          Padding(
                            padding: const EdgeInsets.only(left: 25),
                            child: Container(
                              height: 55,
                              width: 55,
                              decoration: BoxDecoration(
                                color: Constant.orange,
                                borderRadius: BorderRadius.circular(50),
                              ),
                            ),
                          ),
                          const SizedBox(width: 20),

                          //テキストの表示
                          const Text('orange',
                            style: TextStyle(
                              fontSize: 22,
                              fontWeight: FontWeight.bold,
                              color: Constant.gray,
                            )
                          ),
                        ],
                    ),
                  ),
                ),
              ),

              const SizedBox(height: 10),

              //イエロー
              Padding(
                padding: const EdgeInsets.all(3.0),
                  child: InkWell(
                    onTap: () {
                      selectedThemeName = "yellow";
                      setState(() {});
                    },
                    child: Container(
                      width: 340,
                      height: 70,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(22),
                        color: Constant.white,
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.2),
                            spreadRadius: 0,
                            blurRadius: 3,
                            offset: const Offset(0, 4),
                          ),
                        ],
                      ),
                      child: Row(
                        children: [
                          //カラー表示
                          Padding(
                            padding: const EdgeInsets.only(left: 25),
                            child: Container(
                              height: 55,
                              width: 55,
                              decoration: BoxDecoration(
                                color: Constant.yellow,
                                borderRadius: BorderRadius.circular(50),
                              ),
                            ),
                          ),
                          const SizedBox(width: 20),

                          //テキストの表示
                          const Text('yellow',
                            style: TextStyle(
                              fontSize: 22,
                              fontWeight: FontWeight.bold,
                              color: Constant.gray,
                            )
                          ),
                        ],
                    ),
                  ),
                ),
              ),

              const SizedBox(height: 10),

              //グリーン
              Padding(
                padding: const EdgeInsets.all(3.0),
                  child: InkWell(
                    onTap: () {
                      selectedThemeName = "green";
                      setState(() {});
                    },
                    child: Container(
                      width: 340,
                      height: 70,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(22),
                        color: Constant.white,
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.2),
                            spreadRadius: 0,
                            blurRadius: 3,
                            offset: const Offset(0, 4),
                          ),
                        ],
                      ),
                      child: Row(
                        children: [
                          //カラー表示
                          Padding(
                            padding: const EdgeInsets.only(left: 25),
                            child: Container(
                              height: 55,
                              width: 55,
                              decoration: BoxDecoration(
                                color: Constant.green,
                                borderRadius: BorderRadius.circular(50),
                              ),
                            ),
                          ),
                          const SizedBox(width: 20),

                          //テキストの表示
                          const Text('green',
                            style: TextStyle(
                              fontSize: 22,
                              fontWeight: FontWeight.bold,
                              color: Constant.gray,
                            )
                          ),
                        ],
                    ),
                  ),
                ),
              ),

              const SizedBox(height: 10),

              //ブルー
              Padding(
                padding: const EdgeInsets.all(3.0),
                  child: InkWell(
                    onTap: () {
                      selectedThemeName = "blue";
                      setState(() {});
                    },
                    child: Container(
                      width: 340,
                      height: 75,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(22),
                        color: Constant.white,
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.2),
                            spreadRadius: 0,
                            blurRadius: 3,
                            offset: const Offset(0, 4),
                          ),
                        ],
                      ),
                      child: Row(
                        children: [
                          //カラー表示
                          Padding(
                            padding: const EdgeInsets.only(left: 25),
                            child: Container(
                              height: 55,
                              width: 55,
                              decoration: BoxDecoration(
                                color: Constant.blue,
                                borderRadius: BorderRadius.circular(50),
                              ),
                            ),
                          ),
                          const SizedBox(width: 20),

                          //テキストの表示
                          const Text('blue',
                            style: TextStyle(
                              fontSize: 22,
                              fontWeight: FontWeight.bold,
                              color: Constant.gray,
                            )
                          ),
                        ],
                    ),
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
