import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:kishoutenketsu_rta/logic/nfc_read.dart';
import 'package:kishoutenketsu_rta/view/constant.dart';
import 'package:kishoutenketsu_rta/view/pages/components/custom_text_blue.dart';
import 'package:kishoutenketsu_rta/view/pages/components/elevate_button.dart';
import 'package:kishoutenketsu_rta/view/pages/components/outline_button.dart';

import '../../logic/nav_bar.dart';

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
    'assets/rta/RTA.png',
    'assets/rta/RTA.png',
  ];

  // タッチしたかしてないか判定
  List<bool> on_off = [
    false,
    false,
    false,
    false,
    false,
    false,
  ];

  // running_bar 画像
  final List<String> rta_image = [
    'assets/rta/rta_circle.png',
    'assets/rta/rta_circle_on.png',
    'assets/rta/rta_bar.png',
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
                  child: Image.asset(rta_image[on_off[0] ? 1 : 0]),
                ),
                SizedBox(
                  width: 30,
                  height: 30,
                  child: Image.asset(rta_image[2]),
                ),
                SizedBox(
                  width: 35,
                  height: 35,
                  child: Image.asset(rta_image[on_off[1] ? 1 : 0]),
                ),
                SizedBox(
                  width: 30,
                  height: 30,
                  child: Image.asset(rta_image[2]),
                ),
                SizedBox(
                  width: 35,
                  height: 35,
                  child: Image.asset(rta_image[on_off[2] ? 1 : 0]),
                ),
                SizedBox(
                  width: 30,
                  height: 30,
                  child: Image.asset(rta_image[2]),
                ),
                SizedBox(
                  width: 35,
                  height: 35,
                  child: Image.asset(rta_image[on_off[3] ? 1 : 0]),
                ),
                SizedBox(
                  width: 30,
                  height: 30,
                  child: Image.asset(rta_image[2]),
                ),
                SizedBox(
                  width: 35,
                  height: 35,
                  child: Image.asset(rta_image[on_off[4] ? 1 : 0]),
                ),
              ],
            ),
            // SizedBox(width: 100, height: 50),
            // SizedBox(
            //   width: 200,
            //   height: 60,
            //   child: ElevatedButton(
            //     child: Text(
            //       'タッチしたら',
            //       style: GoogleFonts.zenMaruGothic(
            //         fontSize: 20,
            //         fontWeight: FontWeight.bold,
            //         color: Constant.mainColor,
            //       ),
            //     ),
            //     style: ElevatedButton.styleFrom(
            //       backgroundColor: Constant.white,
            //       elevation: 5,
            //       shape: RoundedRectangleBorder(
            //         borderRadius: BorderRadius.circular(60),
            //       ),
            //     ),
            //     onPressed: () {
            //       on_off[image_count] = true;
            //       setState(() {
            //         image_count++;
            //       });
            //       if (image_count == 5) {
            //         endDialog();
            //       }
            //     },
            //   ),
            // ),
          ],
        ),
      ),
    );
  }
  
  @override
  void initState() {
    super.initState();
    //nfcReadFunc()呼び出し
    nfcReadFunc();
  }

  //nfcReadFunc()関数
  void nfcReadFunc() async {
    //NFCRead().nfcRead()呼び出し
    await NFCRead().nfcRead().then((_) {
      setState(() {
        //on_off[image_count]をtrueにする
        on_off[image_count] = true;
        //image_countの値を増やす
        image_count++;
      });
      //image_countが5になったらendDialog()呼び出し
      if (image_count == 5) {
        endDialog();
      }else{
        //image_countが5になっていない場合はnfcReadFunc()呼び出し
        nfcReadFunc();
      }
    });
  }


  void endDialog() {
    Future.delayed(const Duration(milliseconds: 500), () {
    showDialog(
        context: context,
        builder: (context) {
          return Scaffold(
            backgroundColor: Constant.subColor,
            body: Stack(
              children: [
                SimpleDialog(
                  children: [
                    const SizedBox(
                      height: 40,
                    ),
                    const Align(
                      alignment: Alignment.center,
                      child: CustomTextBlue(text: '設定が完了しました！', fontSize: 25),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(
                          top: 20, left: 50, right: 50, bottom: 40),
                      child: Container(
                        child: OutlineButton(
                          title: 'とじる',
                          width: 50,
                          height: 50,
                          shape: 10,
                          fontsize: 17,
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: ((context) => NavBar()!)),
                            );
                          },
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          );
        });
    });
  }
}
