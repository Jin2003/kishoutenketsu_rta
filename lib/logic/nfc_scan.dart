import 'dart:async';
import 'package:flutter/material.dart';
import 'package:nfc_manager/nfc_manager.dart';

class NFCScan {
  Future<void> nfcScan(String id, int tag_count) async {
    // NFCから読み取ったデータを返す
    Completer<void> completer = Completer<void>();

    // NFCリーダーをアクティブ状態にする
    await NfcManager.instance.startSession(
      // NFCをスキャンできたらonDiscoveredを呼び出し処理開始
      onDiscovered: (NfcTag tag) async {
        final ndef = Ndef.from(tag);
        // NFC内のデータがNULLであれば処理を終了（読み込み失敗）
        if (ndef == null) {
          debugPrint("値がNULLです");
          NfcManager.instance.stopSession(errorMessage: 'error');
          return;
        } else {
          // レコードを生成
          NdefRecord textRecord = NdefRecord.createText(id);
          // レコード内にメッセージ生成
          NdefMessage message = NdefMessage([textRecord]);
          // NFCに書き込み
          await ndef.write(message);
          debugPrint(id);
          debugPrint('書き込みました!"');
          if (tag_count == 4) {
            await NfcManager.instance.stopSession();
          }
          completer.complete(); // スキャン処理が完了したことを通知
          return;
        }
      },
      // NFCリーダーがエラーを吐いたらonErrorを呼び出し処理終了
      onError: (dynamic e) async {
        debugPrint('NFC error: $e');
        NfcManager.instance.stopSession(errorMessage: 'error');
        return;
      },
    );
    // スキャン処理が完了するまで待機
    await completer.future;
  }
}




    // //デバイスが読み込み可能かどうか
    // NfcManager.instance.isAvailable().then((bool isAvailable) {
    //   if (isAvailable) {
    //     debugPrint("このデバイスは読み込み可能です");
    //     // debugPrint(_generatedID);
    //   } else {
    //     debugPrint("このデバイスは読み込み不可です");
    //     return;
    //   }
    // });

    // //NFCリーダーをアクティブ状態にする
    // pollingOptions: {NfcPollingOption.iso14443, NfcPollingOption.iso15693},


    // //インスタンスを生成
    // final writeNFC = NFCWrite();
    // //書き込み処理を実行
    // await writeNFC.nfcWrite(id);
