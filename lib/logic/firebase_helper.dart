import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:kishoutenketsu_rta/view/constant.dart';

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

  // グループにnfcIdListを取得するメソッド
  // Future<Map<String, String>> getNfcIdMap() async {
  Future<Map<String, String>> getNfcIdMap() async {
    print(Constant.groupID);
    DocumentSnapshot documentSnapshot = await FirebaseFirestore.instance
        .collection('groups')
        .doc(Constant.groupID)
        .get();
    dynamic data = documentSnapshot.data() as Map<String, dynamic>;
    Map<String, String> nfcIdMap =
        Map<String, String>.from(data['nfcIdMap'] as Map<String, dynamic>);
    return nfcIdMap;
  }

  // ユーザにgroupIDを追加するメソッド
  Future<void> addUser(String groupID, String userID) async {
    await FirebaseFirestore.instance.collection('users').doc(userID).update({
      'groupID': groupID,
    });
  }

  // ユーザのニックネームを変更するメソッド
  Future<void> changeName(String name, String userID) async {
    await FirebaseFirestore.instance.collection('users').doc(userID).update({
      'name': name,
    });
  }

  // ユーザのメールアドレスを変更するメソッド
  Future<void> changeEmail(String newEmail) async {
    //　なんかログインもう一回しないとエラー出るっぽい

    // User? user = FirebaseAuth.instance.currentUser;
    // if (user != null && user.email != null) {
    //   // ユーザがログインしているか確認
    //   if (!user.emailVerified) {
    //     throw FirebaseAuthException(
    //       code: 'requires-recent-login',
    //       message:
    //           'This operation requires recent authentication. Please log in again.',
    //     );
    //   }

    //   // メールアドレスを変更
    //   await user.updateEmail(newEmail);
    // }
  }
}
