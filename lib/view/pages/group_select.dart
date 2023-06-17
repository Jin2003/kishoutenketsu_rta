import 'package:flutter/material.dart';
import 'package:kishoutenketsu_rta/view/constant.dart';
import 'package:kishoutenketsu_rta/view/pages/components/custom_text.dart';
import 'package:kishoutenketsu_rta/view/pages/nfc_setting_page.dart';
import 'package:kishoutenketsu_rta/view/pages/use_select.dart';

import 'components/elevate_button.dart';
import 'join_group.dart';

class GroupSelect extends StatelessWidget {
  const GroupSelect({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Constant.subYellow,
      body: Center(
        child: Column(
          children: [
            SizedBox(width: 100, height: 350,),
            ElevateButton(title: 'グループ作成', shape: 16, fontSize: 20, width: 200, height: 53, nextPage: NfcSettingPage(),),
            SizedBox(width: 100, height: 25,),
            ElevateButton(title: 'グループ参加', shape: 16, fontSize: 20, width: 200, height: 53, nextPage: JoinGroup(),),
            SizedBox(width: 100, height: 35,),
            ElevateButton(title: 'もどる', shape: 16, fontSize: 20, width: 120, height: 45, nextPage: UseSelect(),),
          ],
        ),
          
      ),
    );
  }
}