import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:kishoutenketsu_rta/view/constant.dart';
import 'package:kishoutenketsu_rta/view/pages/components/elevate_button.dart';
import 'package:kishoutenketsu_rta/view/pages/use_select.dart';

import 'components/custom_text.dart';

class HaveNfc extends StatefulWidget {
  const HaveNfc
({super.key});

  @override
  State<HaveNfc> createState() => _HaveNfcState();
}

class _HaveNfcState extends State<HaveNfc> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Constant.sub,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const CustomText(
              text: 'このアプリはNFCタグが必要です',
              fontSize: 22,
              Color: Constant.gray,
            ),
            const SizedBox(height: 20,),
            SizedBox(
              width: 140,
              height: 140,
              child: Image.asset(
                "assets/exclamation_mark.png",
              ),
            ),
            const CustomText(
              text: 'NFCタグを持っていますか？',
              fontSize: 25,
              Color: Constant.gray,
            ),
            const SizedBox(height: 30),

            Text(
              textAlign: TextAlign.left,
              '※ お持ちの方は「このまま進む」,\n　 お持ちでない方は「購入する」\n　 を押すと、オススメのNFCタグが\n　 表示されます。',
              style: GoogleFonts.zenMaruGothic(
                fontWeight: FontWeight.bold,
                fontSize: 18,
                color: Constant.gray,
              ),
            ),

            const SizedBox(height: 30),

            const ElevateButton(title: 'このまま進む', shape: 20, fontSize: 20, width: 180, height: 55, nextPage: UseSelect()),
            const SizedBox(height: 15),
            const ElevateButton(title: '購入する', shape: 20, fontSize: 20, width: 180, height: 55),
          ],
        ),
      ),
    );
  }
}