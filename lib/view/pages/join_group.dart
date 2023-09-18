import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:kishoutenketsu_rta/logic/nav_bar.dart';
import 'package:kishoutenketsu_rta/logic/shared_preferences_logic.dart';
import 'package:kishoutenketsu_rta/logic/singleton_user.dart';
import 'package:kishoutenketsu_rta/view/pages/components/custom_text.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';

import '../constant.dart';
import 'components/elevate_button.dart';
import 'group_select.dart';

class JoinGroup extends StatefulWidget {
  const JoinGroup({super.key});

  @override
  State<JoinGroup> createState() => _JoinGroupState();
}

class _JoinGroupState extends State<JoinGroup> {
  // スキャンしたデータを格納する変数
  Barcode? result;

  final GlobalKey qrKey = GlobalKey(debugLabel: 'QR');

  QRViewController? controller;

  bool canRead = true;

  @override
  void initState() {
    super.initState();
  }

  // ホットリロードすると呼ばれる処理
  @override
  void reassemble() {
    super.reassemble();
    if (Platform.isAndroid) {
      controller?.pauseCamera();
    }
    controller?.resumeCamera();
  }

  @override
  void dispose() {
    controller?.dispose();
    super.dispose();
  }

  // QRカメラの初期化時
  Future<void> _onQRViewCreated(QRViewController controller) async {
    setState(() {
      this.controller = controller;
    });
    // スキャンしたデータを取得できるように、listenする
    controller.scannedDataStream.listen((scanData) {
      setState(() {
        result = scanData;
      });
      if (canRead) {
        canRead = false;
        joinGroup();
      }
    });
  }

  Future<void> joinGroup() async {
    // Firebaseへの書き込み処理を追加
    if (result != null) {
      String? groupID = result!.code;
      try {
        SharedPreferencesLogic sharedPreferencesLogic =
            SharedPreferencesLogic();
        final userID = await sharedPreferencesLogic.getUserID();
        // Firebaseへの書き込み処理を実行
        await FirebaseFirestore.instance
            .collection('users')
            .doc(userID)
            .update({
          'groupID': groupID,
        });
        SingletonUser.updateGroupID(groupID.toString());
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

        // 書き込みが成功した場合の処理
        if (!mounted) return;
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: const Text('参加成功'),
              content: const Text('グループへの参加が成功しました。'),
              actions: <Widget>[
                ElevatedButton(
                  child: const Text('OK'),
                  onPressed: () {
                    Navigator.pop(context);
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) =>
                                const NavBar())); // NavBarに遷移する
                  },
                ),
              ],
            );
          },
        );
      } catch (e) {
        // 書き込みが失敗した場合の処理
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: const Text('参加失敗'),
              content: const Text('グループへの参加に失敗しました。'),
              actions: <Widget>[
                ElevatedButton(
                  child: const Text('OK'),
                  onPressed: () {
                    canRead = true;
                    Navigator.pop(context);
                  },
                ),
              ],
            );
          },
        );
      }
    }
  }

  // カメラのパーミッションがセットされると呼ばれる処理
  void _onPermissionSet(BuildContext context, QRViewController ctrl, bool p) {
    // log('${DateTime.now().toIso8601String()}_onPermissionSet $p');
    if (!p) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('no Permission')),
      );
    }
  }

  Widget _buildQrView(BuildContext context) {
    // For this example we check how width or tall the device is and change the scanArea and overlay accordingly.
    var scanArea = (MediaQuery.of(context).size.width < 400 ||
            MediaQuery.of(context).size.height < 400)
        ? 150.0
        : 300.0;
    // To ensure the Scanner view is properly sizes after rotation
    // we need to listen for Flutter SizeChanged notification and update controller
    return QRView(
      key: qrKey,
      onQRViewCreated: _onQRViewCreated,
      overlay: QrScannerOverlayShape(
          // TODO:QRコードの周りの枠の色を相談する
          borderColor: Colors.yellowAccent,
          borderRadius: 10,
          borderLength: 30,
          borderWidth: 10,
          cutOutSize: scanArea),
      onPermissionSet: (ctrl, p) => _onPermissionSet(context, ctrl, p),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Constant.sub,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const CustomText(
                text: 'グループ作成者のQRコードを\n読み取ることで\nグループに参加できます',
                fontSize: 20,
                Color: Constant.gray),
            const SizedBox(height: 30),
            Container(
              width: 400,
              height: 400,
              color: Constant.gray,
              child: _buildQrView(context),
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
