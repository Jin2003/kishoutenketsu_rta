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
                      onTap: ()  {
                        // TODO: キャラクター変更処理
                      },
                      child: SizedBox(
                        height: 150,
                        width: 150,
                        child: Container(
                            margin: const EdgeInsets.all(8),
                            child: Image.asset('assets/characters/yellow/chicken_on.png')),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(3.0),
                    child: InkWell(
                      onTap: ()  {
        
                      },
                      child: SizedBox(
                        height: 150,
                        width: 150,
                        child: Container(
                            margin: const EdgeInsets.all(8),
                            child: Image.asset('assets/characters/yellow/medamayaki_off.png')),
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
                      onTap: ()  {
        
                      },
                      child: SizedBox(
                        height: 150,
                        width: 150,
                        child: Container(
                            margin: const EdgeInsets.all(8),
                            child: Image.asset('assets/characters/yellow/mezamashi_off.png')),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(3.0),
                    child: InkWell(
                      onTap: ()  {
        
                      },
                      child: SizedBox(
                        height: 150,
                        width: 150,
                        child: Container(
                            margin: const EdgeInsets.all(8),
                            child: Image.asset('assets/characters/yellow/toast_off.png')),
                      ),
                    ),
                  ),
                ],
              ),
        
        
              
              const SizedBox(height: 20,),
              const OutlineButton(
                title: '保存',
                width: 170,
                height: 50,
                fontsize: 20,
                shape: 15,
                nextPage: NavBar(),
              ),
            ],
          ),
          
          
        ],
      ),
    );
  }
}