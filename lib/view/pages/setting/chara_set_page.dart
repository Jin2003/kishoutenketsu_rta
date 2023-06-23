import 'package:flutter/material.dart';
import 'package:kishoutenketsu_rta/logic/nav_bar.dart';
import '../../constant.dart';
import '../components/custom_text.dart';
import '../components/outline_button.dart';

class CharaSetPage extends StatefulWidget {
  const CharaSetPage({super.key});

  @override
  State<CharaSetPage> createState() => _CharaSetPageState();
}

class _CharaSetPageState extends State<CharaSetPage> {
  // 選択して変更後に保存するキャラクター
  String? _selectedCharacter = Constant.characterName;

  @override
  void initState() {
    super.initState();
  }

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

          const CustomText(text: 'キャラクター', fontSize: 22, Color: Constant.gray),
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
              const SizedBox(height: 30),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(3.0),
                    child: InkWell(
                      onTap: () {
                        setState(() {
                          _selectedCharacter = 'chicken';
                        });
                      },
                      child: SizedBox(
                        height: 150,
                        width: 150,
                        child: Container(
                          margin: const EdgeInsets.all(8),
                          child: Image.asset(
                            _selectedCharacter == 'chicken'
                                ? 'assets/characters/${Constant.themeName}/chicken_on.png'
                                : 'assets/characters/${Constant.themeName}/chicken_off.png',
                          ),
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(3.0),
                    child: InkWell(
                      onTap: () {
                        setState(() {
                          _selectedCharacter = 'medamayaki';
                        });
                      },
                      child: SizedBox(
                        height: 150,
                        width: 150,
                        child: Container(
                          margin: const EdgeInsets.all(8),
                          child: Image.asset(
                            _selectedCharacter == 'medamayaki'
                                ? 'assets/characters/${Constant.themeName}/medamayaki_on.png'
                                : 'assets/characters/${Constant.themeName}/medamayaki_off.png',
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(3.0),
                    child: InkWell(
                      onTap: () {
                        setState(() {
                          _selectedCharacter = 'mezamashi';
                        });
                      },
                      child: SizedBox(
                          height: 150,
                          width: 150,
                          child: Container(
                            margin: const EdgeInsets.all(8),
                            child: Image.asset(
                              _selectedCharacter == 'mezamashi'
                                  ? 'assets/characters/${Constant.themeName}/mezamashi_on.png'
                                  : 'assets/characters/${Constant.themeName}/mezamashi_off.png',
                            ),
                          )),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(3.0),
                    child: InkWell(
                      onTap: () {
                        setState(() {
                          _selectedCharacter = 'toast';
                        });
                      },
                      child: SizedBox(
                          height: 150,
                          width: 150,
                          child: Container(
                            margin: const EdgeInsets.all(8),
                            child: Image.asset(
                              _selectedCharacter == 'toast'
                                  ? 'assets/characters/${Constant.themeName}/toast_on.png'
                                  : 'assets/characters/${Constant.themeName}/toast_off.png',
                            ),
                          )),
                    ),
                  ),
                ],
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
                onPressed: () {
                  Constant.updateCharacterName(_selectedCharacter!);
                },
              ),
            ],
          ),
        ],
      ),
    );
  }
}
