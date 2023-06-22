import 'package:flutter/material.dart';
import '../../../logic/nav_bar.dart';
import '../../constant.dart';
import '../components/custom_text.dart';

class HelpPage extends StatefulWidget {
  const HelpPage({super.key});

  @override
  State<HelpPage> createState() => _HelpPageState();
}

class _HelpPageState extends State<HelpPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Constant.white,
      body: Column(
        children: [
          const SizedBox(height: 40),
          // × のアイコン表示
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

          const CustomText(text: 'ヘルプ', fontSize: 22, Color: Constant.gray),
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
              Container(
                width: 300,
                child: RichText(
                  text: const TextSpan(children: [
                    TextSpan(
                      text: 'こちらのリンクから\nNFCタグを購入してください',
                      style: TextStyle(color: Constant.gray, fontSize: 20),
                    ),
                    TextSpan(
                      text:
                          // TODO:NFCのリンク貼る
                          'https://qiita.com/megumu-u/items/73b728ad1d381717d731',
                      style: TextStyle(color: Colors.blue, fontSize: 20),
                    )
                  ]),
                ),
              ),
              const SizedBox(
                height: 200,
              ),
              Container(
                width: 300,
                child: const Column(
                  children: [
                    CustomText(
                        text: 'お問い合わせはこちらから',
                        fontSize: 20,
                        Color: Constant.gray),
                    SizedBox(
                      height: 20,
                    ),
                    CustomText(
                        text: '000-0000-0000',
                        fontSize: 20,
                        Color: Constant.gray),
                  ],
                ),
              ),
            ],
          )
        ],
      ),
    );
  }
}
