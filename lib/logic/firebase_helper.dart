import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:kishoutenketsu_rta/logic/singleton_user.dart';
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

  // ユーザに紐づいたグループを取得するメソッド
  Future<String> getGroupID(String userID) async {
    DocumentSnapshot documentSnapshot =
        await FirebaseFirestore.instance.collection('users').doc(userID).get();
    dynamic data = documentSnapshot.data() as Map<String, dynamic>;
    String groupId;
    if (data['groupID'] == null) {
      groupId = '';
    } else {
      groupId = data['groupID'] as String;
    }
    return groupId;
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
  Future<Map<String, String>> getNfcIdMap() async {
    DocumentSnapshot documentSnapshot = await FirebaseFirestore.instance
        .collection('groups')
        .doc(SingletonUser.groupID)
        .get();
    if (documentSnapshot.exists) {
      // ドキュメントが存在する場合のみデータを取得し、キャストします
      dynamic data = documentSnapshot.data();
      if (data is Map<String, dynamic>) {
        Map<String, String> nfcIdMap =
            Map<String, String>.from(data['nfcIdMap'] as Map<String, dynamic>);
        return nfcIdMap;
      }
    }
    // ドキュメントが存在しないか、データが不正な場合は空のマップを返すか、エラー処理を行います
    return {}; // または例外をスローするなどの適切なエラーハンドリングを行う
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

  // rtaの結果を保存するメソッド
  Future<void> saveRtaResult(int rtaResult, String date) async {
    await FirebaseFirestore.instance
        .collection('groups')
        .doc(SingletonUser.groupID)
        .collection('rtaResults')
        .doc()
        .set({
      'rtaResult': rtaResult,
      'name': SingletonUser.userName,
      'date': date
    });
  }

  // Future<List<Map<String, dynamic>>> getRtaResults() async {
  //   DateTime now = DateTime.now();
  //   QuerySnapshot querySnapshot = await FirebaseFirestore.instance
  //       .collection('groups')
  //       .doc(SingletonUser.groupID)
  //       .collection('rtaResults')
  //       .orderBy('rtaResult', descending: false)
  //       .get();
  //   List<Map<String, dynamic>> rtaResults = [];
  //   List<Map<String, dynamic>> monthlyResults = [];

  //   for (var doc in querySnapshot.docs) {
  //     Map<String, dynamic> rtaResult = doc.data() as Map<String, dynamic>;
  //     // エントリの日付をDateTimeに変換
  //     DateTime entryDate = rtaResult['date'].toDate();

  //     // 今月の1日から現在までのエントリを抽出
  //     if (entryDate.isAfter(DateTime(now.year, now.month, 1))) {
  //       monthlyResults.add(rtaResult);
  //     }

  //     rtaResults.add(rtaResult);
  //   }
  // }

  // rtaResults には全体の結果が含まれ、monthlyResults には今月の結果が含まれます
  // 全体のrtaの結果と月間のrtaの結果を取得するメソッド
  Future<Map<String, List<Map<String, dynamic>>>> getRtaResults() async {
    DateTime now = DateTime.now();
    QuerySnapshot querySnapshot = await FirebaseFirestore.instance
        .collection('groups')
        .doc(SingletonUser.groupID)
        .collection('rtaResults')
        .orderBy('rtaResult', descending: false)
        .get();
    List<Map<String, dynamic>> rtaResults = [];
    List<Map<String, dynamic>> monthlyResults = [];

    for (var doc in querySnapshot.docs) {
      Map<String, dynamic> rtaResult = doc.data() as Map<String, dynamic>;
      // エントリの日付をDateTimeに変換
      // TODO
      DateTime entryDate = rtaResult['date'].toDate();

      // 今月の1日から現在までのエントリを抽出
      if (entryDate.isAfter(DateTime(now.year, now.month, 1))) {
        monthlyResults.add(rtaResult);
      }

      rtaResults.add(rtaResult);
    }

    print(rtaResults);
    print(monthlyResults);

    // rtaResults には全体の結果が含まれ、monthlyResults には今月の結果が含まれます
    return {'rtaResults': rtaResults, 'monthlyResults': monthlyResults};
  }

// 全体のrtaの結果を取得するメソッド
// Future<List<Map<String, dynamic>>> getRtaResults() async {
//   QuerySnapshot querySnapshot = await FirebaseFirestore.instance
//       .collection('groups')
//       .doc(SingletonUser.groupID)
//       .collection('rtaResults')
//       .orderBy('rtaResult', descending: false)
//       .get();
//   List<Map<String, dynamic>> rtaResults = [];
//   for (var doc in querySnapshot.docs) {
//     rtaResults.add(doc.data() as Map<String, dynamic>);
//   }
//   return rtaResults;
// }

// // 月間のrtaの結果を取得し、ランキング順に
// Future<List<Map<String, dynamic>>> getMonthlyRtaResults() async {
//   QuerySnapshot querySnapshot = await FirebaseFirestore.instance
//       .collection('groups')
//       .doc(SingletonUser.groupID)
//       .collection('rtaResults')
//       .where('date', isGreaterThanOrEqualTo: DateTime.now().month)
//       .orderBy('rtaResult', descending: false)
//       .get();
//   List<Map<String, dynamic>> rtaResults = [];
//   for (var doc in querySnapshot.docs) {
//     rtaResults.add(doc.data() as Map<String, dynamic>);
//   }
//   print(rtaResults);
//   return rtaResults;
// }

// 自分の最新のrtaの結果を取得するメソッド
  Future<Map<String, dynamic>> getMyLateestRtaResult() async {
    QuerySnapshot querySnapshot = await FirebaseFirestore.instance
        .collection('groups')
        .doc(SingletonUser.groupID)
        .collection('rtaResults')
        .where('name', isEqualTo: SingletonUser.userName)
        .orderBy('date', descending: true)
        .limit(1)
        .get();
    Map<String, dynamic> myRtaResult = {};
    for (var doc in querySnapshot.docs) {
      myRtaResult = doc.data() as Map<String, dynamic>;
    }
    return myRtaResult;
  }

// 順位をFirestoreから取得するメソッド
  Future<int> getRanking(int thisTime) async {
    // Firestoreの"rankings"コレクションからthisTimeの順位を取得
    QuerySnapshot querySnapshot = await FirebaseFirestore.instance
        .collection('groups')
        .doc(SingletonUser.groupID)
        .collection('rtaResults')
        .where('rtaResult', isLessThanOrEqualTo: thisTime)
        .get();
    return querySnapshot.size;
    // return underThisTimeLength;
  }

// ユーザ情報からポイントを取得するメソッド
  Future<int> getPoint() async {
    DocumentSnapshot documentSnapshot = await FirebaseFirestore.instance
        .collection('users')
        .doc(SingletonUser.userID)
        .get();
    dynamic data = documentSnapshot.data() as Map<String, dynamic>;
    int point = data['point'] as int;
    return point;
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
