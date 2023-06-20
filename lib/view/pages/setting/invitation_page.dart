import 'package:flutter/material.dart';

import '../../../logic/nav_bar.dart';
import '../../constant.dart';
import '../components/custom_text.dart';

class InvitationPage extends StatefulWidget {
  const InvitationPage({super.key});

  @override
  State<InvitationPage> createState() => _InvitationPageState();
}

class _InvitationPageState extends State<InvitationPage> {
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

          const CustomText(text: 'グループ招待', fontSize: 22, Color: Constant.gray),
          const SizedBox(height: 20),

          Container(
            width: 380,
            decoration: const BoxDecoration(
              border:
                  Border(bottom: BorderSide(color: Constant.gray, width: 2)),
            ),
          ),

          const SizedBox(height: 100),

          // TODO:ここにQRコード表示
          Container(
            width: 300,
            height: 300,
            color: Constant.gray,
          ),

          const SizedBox(height: 30),

          const CustomText(text: 'こちらのQRコードを\nグループに参加する方の\n端末で読み取ってください', fontSize: 20, Color: Constant.gray),
        ],
      ),
    );
  }
}