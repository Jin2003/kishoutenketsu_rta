import 'dart:async';
import 'package:flutter/material.dart';
import 'package:nfc_manager/nfc_manager.dart';

class NFCRead {
  //NFCから読み取ったデータを格納する変数
  String _tagvalue = "";

  //NFCから読み取ったデータを返す
  Completer<void> completer = Completer<void>();

  nfcRead(int count) async {
    //NFCリーダーをアクティブ状態にする
    await NfcManager.instance.startSession(
      //NFCをスキャンできたらonDiscoveredを呼び出し処理開始
      onDiscovered: (NfcTag tag) async {
        debugPrint("読み込みます");
        //NFC内のデータを取り出す
        final ndef = Ndef.from(tag);
        //NFC内のデータがNULLであれば処理を終了（読み込み失敗）
        if (ndef == null) {
          debugPrint("読み取り失敗");
          await NfcManager.instance.stopSession(errorMessage: 'error');
          return;
        } else {
          //NFC内のデータ読み取り
          final message = await ndef.read();
          //NFC内のレコード(最初に入っているデータ)を取り出す
          final tagValue = String.fromCharCodes(message.records.first.payload);
          //NFC内のレコードのデータを格納
          _tagvalue = tagValue.substring(3);
          //NFC内のデータを表示
          debugPrint(_tagvalue);
          //スキャンが完了したことを通知
          completer.complete();
          if (count == 4) {
            await NfcManager.instance.stopSession();
          }
          return;
        }
      },
      //NFCリーダーがエラーを吐いたらonErrorを呼び出し処理終了
      onError: (dynamic e) async {
        debugPrint('NFC error: $e');
        await NfcManager.instance.stopSession(errorMessage: 'error');
      },
    );
    // スキャン処理が完了するまで待機
    await completer.future;
  }
}
