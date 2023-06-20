import 'package:flutter/material.dart';
import 'package:kishoutenketsu_rta/view/pages/components/custom_text.dart';

import '../constant.dart';
import 'components/elevate_button.dart';
import 'group_select.dart';

class JoinGroup extends StatelessWidget {
  const JoinGroup({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Constant.subYellow,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const CustomText(
              text: 'グループ作成者のQRコードを\n読み取ることで\nグループに参加できます',
              fontSize: 20,
              Color: Constant.gray
            ),
            const SizedBox(height: 30),
            // TODO:ここでカメラ起動
            Container(
              width: 400,
              height: 400,
              color: Constant.gray,
            ),
            const SizedBox(height: 35),
            const ElevateButton(
              title: 'もどる',
              shape: 16,
              fontSize: 20,
              width: 120,
              height: 45,
              nextPage: GroupSelect(),
            ),
          ],
        ),
      ),
    );
  }
}
