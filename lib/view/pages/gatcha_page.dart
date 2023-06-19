import 'package:flutter/material.dart';
import 'package:kishoutenketsu_rta/view/pages/components/custom_text.dart';
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
  int _point = 0;

  //ボタンが押されたかどうか
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Constant.subYellow,
      body: Stack(
        fit: StackFit.expand,
        children: [
          Image.asset(
            "assets/pages/yellow/gatcha_page.png",
            fit: BoxFit.cover,
          ),
          //画像を表示する
          Column(
            children: [
              const SizedBox(
                height: 70,
                width: 1,
              ),
              const CustomText(text: '現在のポイント', fontSize: 28, Color: Constant.gray),
              const SizedBox(
                height: 10,
                width: 1,
              ),
              Container(
                alignment: Alignment.center,
                width: 260,
                height: 90,
                decoration: BoxDecoration(
                  border: Border.all(color: Constant.yellow, width: 5),
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
                      style: const TextStyle(
                        fontSize: 50,
                        fontWeight: FontWeight.bold,
                        color: Constant.accentYellow,
                      ),
                    ),
                    const SizedBox(
                      width: 10,
                      height: 1,
                    ),
                    const Text(
                      'pt',
                      style: TextStyle(
                        fontSize: 40,
                        fontWeight: FontWeight.bold,
                        color: Constant.accentYellow,
                      ),
                    ),
                  ],
                ),
              ),

              //ElevateButton(title: 'ガチャをまわす'),
              const SizedBox(
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
                    elevation: 5,
                  ),
                  onPressed: () async {
                    // ポップアップ表示
                    showDialog<void>(
                        context: context,
                        builder: (_) {
                          return AlertDialog(
                            title: const CustomText(
                                text: '10ポイント消費して\nガチャを回しますか？', fontSize: 20, Color: Constant.gray),
                            actions: <Widget>[
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  GestureDetector(
                                    child: OutlineButton(
                                      title: 'はい',
                                      fontsize: 15,
                                      height: 40,
                                      width: 80,
                                      shape: 10,
                                      onPressed: () async {
                                        final db = await DatabaseHelper().db;
                                        // ポイントが10ポイント以下の場合はガチャを回せない
                                        if (_point < 10) {
                                          return;
                                        }
                                        // 持っていないアイテムをランダムに1つ取得
                                        final items = await db.rawQuery(
                                            'SELECT * FROM items WHERE has_item = 0 ORDER BY RANDOM() LIMIT 1');
                                        // 持っていないアイテムがない場合は処理を終了
                                        if (items.isEmpty) {
                                          return;
                                        }
                                        setState(() {
                                          _isPressed = true;
                                        });
                                        // 引いたアイテムを所持アイテムにする
                                        await db.rawUpdate(
                                            'UPDATE items SET has_item = 1 WHERE item_id = ${items[0]["item_id"]}');
                                        //10ポイント消費する
                                        await db.rawUpdate(
                                            'UPDATE user SET point = point - 10');
                                        // 変更後のポイントの取得
                                        final point = await db
                                            .rawQuery('SELECT point FROM user');
                                        //表示するポイントの更新
                                        setState(() {
                                          _point = point[0]['point'] as int;
                                        });
                                        Navigator.pop(context);
                                        // まわるポップアップ表示
                                        Future.delayed(
                                            const Duration(milliseconds: 3500),
                                            () {
                                          showAnimatedDialog<void>(
                                            context: context,
                                            builder: (_) {
                                              return AlertDialog(
                                                title: CustomText(
                                                    text:
                                                        '${items[0]["item_name"]}が当たりました！',
                                                    fontSize: 20,
                                                    Color: Constant.gray
                                                    ),
                                                actions: <Widget>[
                                                  Container(
                                                    alignment: Alignment.center,
                                                    child: Column(
                                                      children: [
                                                        // SizedBox(
                                                        //   height: 6,
                                                        // ),
                                                        GestureDetector(
                                                          child: OutlineButton(
                                                            fontsize: 15,
                                                            width: 80,
                                                            height: 40,
                                                            title: 'とじる',
                                                            shape: 10,
                                                            onPressed: () {
                                                              setState(() {
                                                                _isPressed =
                                                                    false;
                                                              });
                                                              Navigator.pop(
                                                                  context);
                                                            },
                                                          ),
                                                        ),
                                                        const SizedBox(
                                                          height: 20,
                                                        )
                                                      ],
                                                    ),
                                                  ),
                                                ],
                                              );
                                            },
                                            animationType: DialogTransitionType
                                                .scaleRotate,
                                            duration: const Duration(
                                                milliseconds: 300),
                                          );
                                        });
                                      },
                                    ),
                                  ),
                                  const SizedBox(
                                    width: 30,
                                    height: 0,
                                  ),
                                  GestureDetector(
                                    child: OutlineButton(
                                        title: 'いいえ',
                                        fontsize: 15,
                                        height: 40,
                                        width: 80,
                                        shape: 10,
                                        onPressed: () {
                                          Navigator.pop(context);
                                        }),
                                  ),
                                ],
                              )
                            ],
                          );
                        });
                  },
                  child: const CustomText(
                    text: 'ガチャをまわす',
                    fontSize: 21,
                    Color: Constant.gray
                  ),
                  // child: Text(
                  //   style: TextStyle(
                  //     color: Constant.blue,
                  //   ),
                  //   'ガチャを回す'
                  // ),
                ),
              ),
            ],
          ),
          if (_isPressed)
            Container(
              color: const Color.fromARGB(255, 11, 11, 11).withOpacity(0.5),
            ),
          //_isPressedがtrueの時に表示する
          if (_isPressed)
            Positioned(
              top: 250,
              left: 118,
              child: SizedBox(
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
                      // TODO:今、水色のまま。そもそもアニメーションになる
                      "assets/capsule.png",
                      fit: BoxFit.cover,
                      height: 500,
                    ),
                  )),
            ),
        ],
      ),
    );
  }
}
