import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:kishoutenketsu_rta/view/constant.dart';
import 'package:kishoutenketsu_rta/view/pages/components/custom_text_blue.dart';
import 'package:kishoutenketsu_rta/view/pages/components/elevate_button.dart';
import 'package:kishoutenketsu_rta/view/pages/components/outline_button.dart';

class RtaPage extends StatefulWidget {
  const RtaPage({super.key});

  @override
  State<RtaPage> createState() => _RtaPageState();
}

class _RtaPageState extends State<RtaPage> {
  // アイコン画像
  final List<String> icon_image = [
    'assets/rta/起.png',
    'assets/rta/床.png',
    'assets/rta/点.png',
    'assets/rta/結.png',
    'assets/rta/RTA.png'
  ];

  // running_bar 画像  
  final List<String> rta_image = [
    'assets/rta/rta_circle.png',
    'assets/rta/rta_bar.png',
    'assets/rta/rta_circle_on.png',
  ];

  // 画像番号
  int image_count = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Constant.subColor,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(
              width: 230,
              height: 230,
              child: Image.asset(icon_image[image_count]),
            ),
            SizedBox(width: 100, height: 20),
            CustomTextBlue(text: '  をタッチしてね！', fontSize: 25),
            SizedBox(width: 100, height: 30),

            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(
                  width: 35,
                  height: 35,
                  child: Image.asset(rta_image[2]),
                ),
                SizedBox(
                  width: 30,
                  height: 30,
                  child: Image.asset(rta_image[1]),
                ),
                SizedBox(
                  width: 35,
                  height: 35,
                  child: Image.asset(rta_image[2]),
                ),
                SizedBox(
                  width: 30,
                  height: 30,
                  child: Image.asset(rta_image[1]),
                ),
                SizedBox(
                  width: 35,
                  height: 35,
                  child: Image.asset(rta_image[image_count]),
                ),
                SizedBox(
                  width: 30,
                  height: 30,
                  child: Image.asset(rta_image[1]),
                ),
                SizedBox(
                  width: 35,
                  height: 35,
                  child: Image.asset(rta_image[image_count]),
                ),
                SizedBox(
                  width: 30,
                  height: 30,
                  child: Image.asset(rta_image[1]),
                ),
                SizedBox(
                  width: 35,
                  height: 35,
                  child: Image.asset(rta_image[image_count]),
                ),
              ],
            ),
            SizedBox(width: 100, height: 50),
            SizedBox(
              width: 200,
              height: 60,
              child: ElevatedButton(
                child: Text(
                  'タッチしたら',
                  style: GoogleFonts.zenMaruGothic(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Constant.mainColor,
                  ),
                ),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Constant.white,
                  elevation: 5,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(60),
                  ),
                ),
                onPressed: () {

                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
