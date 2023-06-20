import 'package:flutter/material.dart';
import 'package:kishoutenketsu_rta/view/constant.dart';
import 'package:kishoutenketsu_rta/view/pages/components/custom_text.dart';
import 'package:kishoutenketsu_rta/view/pages/nfc_setting_page.dart';

import 'components/elevate_button.dart';
import 'group_select.dart';

class UseSelect extends StatelessWidget {
  const UseSelect({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      backgroundColor: Constant.subYellow,
      body: Center(
        child: Column(
          children: [
            SizedBox(width: 100, height: 350,),
            CustomText(text: '利用方法を選んでね！', fontSize: 25, Color: Constant.gray),
            SizedBox(width: 100, height: 30,),
            ElevateButton(title: '個人で利用', shape: 16, fontSize: 20, width: 200, height: 53, nextPage: NfcSettingPage(),),
            SizedBox(width: 100, height: 20,),
            ElevateButton(title: '家族で利用', shape: 16, fontSize: 20, width: 200, height: 53, nextPage: GroupSelect(),),
          ],
        ),
          
      ),
    );
  }
}