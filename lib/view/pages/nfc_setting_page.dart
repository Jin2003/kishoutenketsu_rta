import 'package:flutter/material.dart';
import 'package:kishoutenketsu_rta/logic/firebase_helper.dart';
import 'package:kishoutenketsu_rta/logic/nav_bar.dart';
import 'package:kishoutenketsu_rta/logic/nfc_scan.dart';
import 'package:kishoutenketsu_rta/logic/shared_preferences_logic.dart';
import 'package:kishoutenketsu_rta/logic/singleton_user.dart';
import 'package:kishoutenketsu_rta/view/pages/components/custom_text.dart';
import 'package:uuid/uuid.dart';

import '../constant.dart';
import 'components/outline_button.dart';

class NfcSettingPage extends StatefulWidget {
  const NfcSettingPage({super.key});

  @override
  State<NfcSettingPage> createState() => _NfcSettingPageState();
}

class _NfcSettingPageState extends State<NfcSettingPage> {
  final List<String> tagname = ["起", "床", "点", "結", "RTA"];
  // NFCのIDをkey-valueで格納する辞書
  Map<String, String> nfcIdMap = {};

  int tagCount = 0;

  var uuid = const Uuid();

  @override
  void initState() {
    super.initState();
    //nfcScanFunc()呼び出し
    nfcScanFunc();
  }

  @override
  Widget build(BuildContext context) {
    String tagName = tagname[tagCount];

    return Scaffold(
      backgroundColor: Constant.sub,
      body: Stack(
        children: [
          Center(
            child: CustomText(
                text: '[$tagName]のボタンを\n壁に取り付け\nタッチしてください',
                fontSize: 30,
                Color: Constant.gray),
          ),
        ],
      ),
    );
  }

  void nfcScanFunc() async {
    String id = uuid.v4(); //uuidを生成
    //NFCScan().nfcScan(id)呼び出し
    await NFCScan().nfcScan(id, tagCount).then((_) async {
      //NFCのスキャン処理が終わったらshowDialogFunc()呼び出し
      showDialogFunc(context, tagCount);

      // nfcIdMapにtagnameに対応するキーとしてidを追加
      nfcIdMap[tagname[tagCount]] = id;

      //tagCountが4以下ならtagCountの値を増やしてnfcScanFunc()呼び出し
      if (tagCount < 4) {
        setState(() {
          tagCount++;
        });
        nfcScanFunc();
      } else {
        // firebaseにnfcIdMapを保存
        FirebaseHelper firebaseHelper = FirebaseHelper();
        String documentID = await firebaseHelper.createGroup();
        // nfcIdMapをfirebaseに保存
        await firebaseHelper.saveNfcIdMap(documentID, nfcIdMap);
        // shared_preferencesにgroupIDを保存
        SharedPreferencesLogic sharedPreferencesLogic =
            SharedPreferencesLogic();
        SingletonUser.updateGroupID(documentID);
        // groupIDをusersコレクションに登録
        String? userID = await sharedPreferencesLogic.getUserID();
        sharedPreferencesLogic.setGroupID(documentID);
        await firebaseHelper.addUser(documentID, userID!);
        // isNfcSettingをtrueに変更
        await sharedPreferencesLogic.setExistsNFC(true);
        await sharedPreferencesLogic.setSelectedCharacter('chicken');
        await sharedPreferencesLogic.setSelectedWallpaper("dots");
        await sharedPreferencesLogic.setSelectedTheme("dots");
        // TODO:circusをデフォルトにしてるけど、後で考える
        await sharedPreferencesLogic.setSelectedMusic('circus');
        await sharedPreferencesLogic.setSelectedColor("yellow");
        await sharedPreferencesLogic.setSettedAlarm(false);
        await sharedPreferencesLogic.setAlarmTime(0);
      }
    });
  }

  void showDialogFunc(BuildContext context, int tagCount) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return Dialog(
          tagCount: tagCount,
        );
      },
    );
  }
}

class Dialog extends StatelessWidget {
  final int tagCount;
  const Dialog({
    Key? key,
    required this.tagCount,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (tagCount >= 4) {
      return SimpleDialog(
        shape: RoundedRectangleBorder(
          side: const BorderSide(color: Constant.white, width: 5),
          borderRadius: BorderRadius.circular(10.0),
        ),
        backgroundColor: Constant.sub,
        children: [
          SizedBox(
            width: 200,
            height: 190,
            child: Column(
              children: [
                const SizedBox(
                  height: 40,
                ),
                const Align(
                  alignment: Alignment.center,
                  child: CustomText(
                      text: '設定が完了しました！', fontSize: 25, Color: Constant.gray),
                ),
                const SizedBox(
                  height: 20,
                ),
                OutlineButton(
                  title: 'とじる',
                  width: 120,
                  height: 50,
                  shape: 10,
                  fontsize: 17,
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: ((context) => const NavBar())),
                    );
                  },
                ),
                // Padding(
                //   padding:
                //       const EdgeInsets.only(top: 20, left: 50, right: 50, bottom: 40),
                //   child:
                // ),
              ],
            ),
          ),
        ],
      );
    }

    return SimpleDialog(
      children: [
        const SizedBox(
          height: 40,
        ),
        const Align(
          alignment: Alignment.center,
          child:
              CustomText(text: 'スキャン完了！', fontSize: 25, Color: Constant.gray),
        ),
        Padding(
          padding:
              const EdgeInsets.only(top: 20, left: 50, right: 50, bottom: 40),
          child: OutlineButton(
            title: 'とじる',
            width: 50,
            height: 50,
            shape: 10,
            fontsize: 17,
            onPressed: () => Navigator.pop(context),
          ),
        ),
      ],
    );
  }
}
