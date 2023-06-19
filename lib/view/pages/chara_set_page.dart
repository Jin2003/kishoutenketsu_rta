import 'package:flutter/material.dart';
import 'package:kishoutenketsu_rta/logic/nav_bar.dart';

import '../constant.dart';
import 'account_set_page.dart';
import 'components/custom_text.dart';
import 'components/outline_button.dart';

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
          SizedBox(
            height: 40,
          ),
          // < のアイコン表示
          Align(
            alignment: Alignment(-0.9, 0),
            child: IconButton(
              iconSize: 22,
              icon: ImageIcon(
                AssetImage('assets/icon/close_icon.png'),
                color: Constant.gray,
              ),
              onPressed: () async {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: ((context) => NavBar())),
                );
              },
            ),
          ),

          CustomText(text: 'キャラクター', fontSize: 22, Color: Constant.gray),
          SizedBox(height: 20),
          Container(
            width: 380,
            decoration: BoxDecoration(
              border:
                  Border(bottom: BorderSide(color: Constant.gray, width: 2)),
            ),
          ),

          Column(
            children: [
              SizedBox(height: 30),
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
                        child: Image.asset('assets/characters/yellow/chicken_off.png')),
                  ),
                ),
              ),
              SizedBox(
                width: 100,
                height: 10,
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
                        child: Image.asset('assets/characters/yellow/chicken_off.png')),
                  ),
                ),
              ),

              
              SizedBox(height: 20,),
              OutlineButton(
                title: '保存',
                width: 170,
                height: 50,
                fontsize: 20,
                shape: 15,
                nextPage: AccountSetPage(),
              ),
            ],
          ),
          
        ],
      ),
    );
  }
}