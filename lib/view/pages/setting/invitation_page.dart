import 'package:flutter/material.dart';
import 'package:kishoutenketsu_rta/logic/shared_preferences_logic.dart';
import 'package:qr_flutter/qr_flutter.dart';

import '../../../logic/nav_bar.dart';
import '../../constant.dart';
import '../components/custom_text.dart';

class InvitationPage extends StatefulWidget {
  const InvitationPage({super.key});

  @override
  State<InvitationPage> createState() => _InvitationPageState();
}

class _InvitationPageState extends State<InvitationPage> {
  Future<String?>? groupID;

  @override
  void initState() {
    super.initState();
    SharedPreferencesLogic sharedPreferencesLogic = SharedPreferencesLogic();
    groupID = sharedPreferencesLogic.getGroupID();
  }

  // groupIDを取得

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

          FutureBuilder<String?>(
            future: groupID,
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                // フューチャーの結果を待っている間にローディングインジケータを表示
                return const CircularProgressIndicator();
              } else if (snapshot.hasData) {
                String? groupID = snapshot.data;
                // groupIDの値を必要に応じて使用
                return Column(
                  children: [
                    QrImageView(
                      data: groupID ?? '',
                      version: QrVersions.auto,
                      size: 300,
                      gapless: false,
                    ),
                    const SizedBox(height: 30),
                    const CustomText(
                      text: 'こちらのQRコードを\nグループに参加する方の\n端末で読み取ってください',
                      fontSize: 20,
                      Color: Constant.gray,
                    ),
                  ],
                );
              } else {
                // フューチャーがエラーまたはデータなしで完了した場合の処理
                return const Text('groupIDの読み込みに失敗しました');
              }
            },
          ),
        ],
      ),
    );
  }
}
