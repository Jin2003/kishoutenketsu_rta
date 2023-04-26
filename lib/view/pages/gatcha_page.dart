import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:kishoutenketsu_rta/view/pages/components/custom_text_blue.dart';
import 'package:kishoutenketsu_rta/view/pages/components/elevate_button.dart';
import 'package:kishoutenketsu_rta/view/pages/components/outline_button.dart';

import '../constant.dart';

class GatchaPage extends StatefulWidget {
  const GatchaPage({super.key});

  @override
  State<GatchaPage> createState() => _GatchaPageState();
}

class _GatchaPageState extends State<GatchaPage> {
  // point
  String _point = '0';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Constant.mainColor,
      body: Stack(
        children: [
          Image.asset(
            "assets/gatcha_page.png",
            fit: BoxFit.cover,
          ),
          Column(
            children: [
              SizedBox(
                height: 50,
                width: 1,
              ),
              CustomTextBlue(text: '現在のポイント', fontSize: 28),
              SizedBox(
                height: 10,
                width: 1,
              ),
              Container(
                alignment: Alignment.center,
                width: 260,
                height: 90,
                decoration: BoxDecoration(
                  border: Border.all(color: Constant.mainColor, width: 5),
                  borderRadius: BorderRadius.circular(60),
                  // color と boxdecorationの共存はNG
                  color: Constant.white,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      textAlign: TextAlign.center,
                      _point,
                      style: TextStyle(
                        fontSize: 50,
                        fontWeight: FontWeight.bold,
                        color: Constant.mainColor,
                      ),
                    ),
                    SizedBox(
                      width: 10,
                      height: 1,
                    ),
                    Text(
                      'pt',
                      style: TextStyle(
                        fontSize: 40,
                        fontWeight: FontWeight.bold,
                        color: Constant.mainColor,
                      ),
                    ),
                  ],
                ),
              ),
              
              //ElevateButton(title: 'ガチャをまわす'),
              SizedBox(
                height: 400,
                width: 1,
              ),
              //OutlineButton(title: 'e', width: 10, height: 10, fontsize: 10, shape: 10)
              //ElevateButton(title: 'ガチャをまわす'),
              SizedBox(
                width: 210,
                height: 60,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Constant.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(25),
                    ),
                  ),
                  onPressed: () {},
                  child: CustomTextBlue(
                    text: 'ガチャをまわす',
                    fontSize: 23,
                  ),
                  // child: Text(
                  //   style: TextStyle(
                  //     color: Constant.mainColor,
                  //   ),
                  //   'ガチャを回す'
                  // ),
                ),
              ), 
            ],
          ),
        ],
        fit: StackFit.expand,
      ),
    );
  }
}
