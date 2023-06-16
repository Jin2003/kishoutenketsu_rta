import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class TestLoginPage extends StatefulWidget {
  const TestLoginPage({Key? key}) : super(key: key);

  @override
  _TestLoginPage createState() => _TestLoginPage();
}

class _TestLoginPage extends State<TestLoginPage> {
  // 入力したメールアドレス・パスワード
  String _name = '';
  String _email = '';
  String _password = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Container(
          padding: const EdgeInsets.all(24),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              TextFormField(
                decoration: const InputDecoration(labelText: 'ニックネーム'),
                onChanged: (String value) {
                  setState(() {
                    _name = value;
                  });
                },
              ),
              TextFormField(
                decoration: const InputDecoration(labelText: 'メールアドレス'),
                onChanged: (String value) {
                  setState(() {
                    _email = value;
                  });
                },
              ),
              TextFormField(
                decoration: const InputDecoration(labelText: 'パスワード'),
                obscureText: true,
                onChanged: (String value) {
                  setState(() {
                    _password = value;
                  });
                },
              ),
              ElevatedButton(
                child: const Text('ユーザ登録'),
                onPressed: () async {
                  try {
                    final User? user = (await FirebaseAuth.instance
                            .createUserWithEmailAndPassword(
                                email: _email, password: _password))
                        .user;
                    if (user != null) {
                      // usersコレクションにユーザ情報を登録
                      await FirebaseFirestore.instance
                          .collection('users')
                          .doc(user.uid)
                          .set({
                        'name': _name,
                        'userID': user.uid,
                        'groupID': null
                      });
                      // TODO:SharedPreferencesにユーザ情報を保存
                    }
                  } catch (e) {
                    print(e);
                  }
                },
              ),
              ElevatedButton(
                child: const Text('ログイン'),
                onPressed: () async {
                  try {
                    // メール/パスワードでログイン
                    final User? user = (await FirebaseAuth.instance
                            .signInWithEmailAndPassword(
                                email: _email, password: _password))
                        .user;
                    if (user != null) print("ログイン成功");
                  } catch (e) {
                    print(e);
                  }
                },
              ),
              ElevatedButton(
                  child: const Text('グループを作成'),
                  // グループを作成する処理を書く
                  onPressed: () async {
                    // groupsを作成
                    DocumentReference docRef = await FirebaseFirestore.instance
                        .collection('groups')
                        .add({});
                    // 作成したドキュメントIDを取得
                    String documentID = docRef.id;
                    // ドキュメントIDに対してgroupIDフィールドを更新
                    await FirebaseFirestore.instance
                        .collection('groups')
                        .doc(documentID)
                        .update({
                      'groupID': documentID,
                    });
                    // TODO:SharedPreferencesにグループIDを保存
                  }),
            ],
          ),
        ),
      ),
    );
  }
}
