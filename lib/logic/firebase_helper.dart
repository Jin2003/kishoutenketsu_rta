import 'package:cloud_firestore/cloud_firestore.dart';

class FirebaseHelper {
  // グループを作成するメソッド
  Future<String> createGroup() async {
    DocumentReference docRef =
        await FirebaseFirestore.instance.collection('groups').add({});
    // 作成したドキュメントIDを取得
    String documentID = docRef.id;
    // ドキュメントIDに対してgroupIDフィールドを更新
    await FirebaseFirestore.instance
        .collection('groups')
        .doc(documentID)
        .update({
      'groupID': documentID,
    });
    return documentID;
  }

  // グループにnfcIdListを保存するメソッド
  Future<void> saveNfcIdMap(
      String documentID, Map<String, String> nfcIdMap) async {
    await FirebaseFirestore.instance
        .collection('groups')
        .doc(documentID)
        .update({
      'nfcIdMap': nfcIdMap,
    });
  }
}
