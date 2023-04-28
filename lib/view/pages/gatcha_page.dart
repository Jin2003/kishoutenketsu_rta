import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:kishoutenketsu_rta/view/pages/components/custom_text_blue.dart';
import 'package:kishoutenketsu_rta/view/pages/components/elevate_button.dart';
import 'package:kishoutenketsu_rta/view/pages/components/outline_button.dart';
import '../../logic/database_helper.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_animated_dialog/flutter_animated_dialog.dart';

import '../constant.dart';

class GatchaPage extends StatefulWidget {
  const GatchaPage({super.key});

  @override
  State<GatchaPage> createState() => _GatchaPageState();
}

class _GatchaPageState extends State<GatchaPage> {
  //現在のポイント
  int _point = 10;

  //ボタンが押されたかどうk
  bool _isPressed = false;

  @override
  void initState() {
    super.initState();
    _loadPoint();
  }

  //_pointを取得し、画面を更新する関数
  Future<void> _loadPoint() async {
    final db = await DatabaseHelper().db;
    //userテーブルからpointカラムを取得
    final point = await db.rawQuery('SELECT * FROM user');
    setState(() {
      _point = point[0]['point'] as int;
    });
  }

  //デバッグ用の_point
  // int _point = 100;
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
          //画像を表示する
          Column(
            children: [
              SizedBox(
                height: 70,
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
                      _point.toString(),
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
                //デバッグ用に300にしている
                height: 380,
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
                  onPressed: () async {
                    // ポップアップ表示
                    showDialog<void>(
                        context: context,
                        builder: (_) {
                          return AlertDialog(
                            title: CustomTextBlue(
                                text: '10ポイント消費して\nガチャを回しますか？', fontSize: 20),
                            actions: <Widget>[
                              GestureDetector(
                                child:
                                    CustomTextBlue(text: 'いいえ', fontSize: 15),
                                onTap: () {
                                  Navigator.pop(context);
                                },
                              ),
                              GestureDetector(
                                child: CustomTextBlue(text: 'はい', fontSize: 15),
                                onTap: () async {
                                  final db = await DatabaseHelper().db;
                                  if (_point < 10) {
                                    return;
                                  }

                                  setState(() {
                                    _isPressed = true;
                                  });
                                  //userテーブルのpointカラムを10減らす
                                  await db.rawUpdate(
                                      'UPDATE user SET point = point - 10');
                                  //userテーブルのpointカラムを取得
                                  final point =
                                      await db.rawQuery('SELECT * FROM user');
                                  setState(() {
                                    _point = point[0]['point'] as int;
                                  });
                                  Navigator.pop(context);
                                  // まわるポップアップ表示
                                  Future.delayed(Duration(milliseconds: 3500),
                                      () {
                                    showAnimatedDialog<void>(
                                      context: context,
                                      builder: (_) {
                                        return AlertDialog(
                                          title: CustomTextBlue(
                                              text: 'せせらぎが当たりました！',
                                              fontSize: 20),
                                          actions: <Widget>[
                                            GestureDetector(
                                              child: CustomTextBlue(
                                                  text: '閉じる', fontSize: 15),
                                              onTap: () {
                                                setState(() {
                                                  _isPressed = false;
                                                });
                                                Navigator.pop(context);
                                              },
                                            ),
                                          ],
                                        );
                                      },
                                      animationType:
                                          DialogTransitionType.scaleRotate,
                                      duration: Duration(milliseconds: 300),
                                    );
                                  });
                                },
                              ),
                            ],
                          );
                        });
                  },
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
          if (_isPressed)
            Container(
              color: Color.fromARGB(255, 11, 11, 11).withOpacity(0.5),
            ),
          //_isPressedがtrueの時に表示する
          if (_isPressed)
            Positioned(
              top: 250,
              left: 118,
              child: Container(
                  width: 150,
                  height: 150,
                  child: Animate(
                    effects: [
                      SlideEffect(duration: 1.seconds),
                      ShakeEffect(delay: 1.seconds, duration: 500.milliseconds),
                      ShimmerEffect(
                          delay: 2.seconds, duration: 800.milliseconds),
                    ],
                    child: Image.asset(
                      "assets/capsule.png",
                      fit: BoxFit.cover,
                      height: 500,
                    ),
                  )),
            ),
        ],
        fit: StackFit.expand,
      ),
    );
  }
}
