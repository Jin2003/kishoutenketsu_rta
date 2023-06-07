import 'dart:async';
import 'package:flutter/material.dart';
import 'package:nfc_manager/nfc_manager.dart';

class NFCRead {
  // NFCから読み取ったデータを格納する変数
  String _tagvalue = "";

  // NFCから読み取ったデータを返す
  Completer<bool> completer = Completer<bool>();

  Future<bool> nfcRead(int count, dynamic id) async {
    // NFCリーダーをアクティブ状態にする
    await NfcManager.instance.startSession(
      // NFCをスキャンできたらonDiscoveredを呼び出し処理開始
      onDiscovered: (NfcTag tag) async {
        debugPrint("読み込みます");
        // NFCタグからNDEFデータを操作するための準備を行うための処理
        final ndef = Ndef.from(tag);
        //NDEF形式のデータが存在しない場合
        if (ndef == null) {
          debugPrint("読み取り失敗");
          // NDEF形式のデータが存在しない通知
          completer.complete(false);
          await NfcManager.instance.stopSession(errorMessage: 'error');
        } else {
          // NFC内のデータ読み取り
          final message = await ndef.read();
          // NFC内のレコード(最初に入っているデータ)を取り出す
          final tagValue = String.fromCharCodes(message.records.first.payload);
          // NFC内のレコードのデータを格納
          _tagvalue = tagValue.substring(3);
          // NFC内のデータを表示
          //debugPrint(_tagvalue);
          // 引数のidをString型に変換
          String nfcId = id.toString();
          // 引数のidから不要な文字を削除
          String cleanedId = nfcId.replaceAll(RegExp(r'{nfc_id: |}'), '');
          //データベースに格納されているidを表示
          //debugPrint(cleanedId);
          // NFC内のデータと引数のidが一致しているかどうか
          if(_tagvalue == cleanedId){
            completer.complete(true);     // NFC内のデータと一致していればtrueを返す
          }else{
            completer.complete(false);    // NFC内のデータと一致していればfalseを返す
          }
          // countが４の場合NFCリーダーを停止
          if (count == 4) {
            await NfcManager.instance.stopSession();
          }
        }
      },
      // NFCリーダーがエラーを吐いたらonErrorを呼び出し処理終了
      onError: (dynamic e) async {
        debugPrint('NFC error: $e');
        await NfcManager.instance.stopSession(errorMessage: 'error');
        completer.complete(false);
      },
    );

    // スキャン処理が完了するまで待機
    return await completer.future;
  }
}
