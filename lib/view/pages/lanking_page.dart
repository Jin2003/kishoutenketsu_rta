import 'package:flutter/material.dart';
import 'package:kishoutenketsu_rta/view/constant.dart';
import '../../logic/database_helper.dart';
import 'components/custom_text.dart';

class LankingPage extends StatefulWidget {
  const LankingPage({super.key});

  @override
  State<LankingPage> createState() => _LankingPageState();
}

class _LankingPageState extends State<LankingPage> {
  //Lankingを表示するためのリスト
  List<Map<String, dynamic>> _times = [];
  //Lankingを何個表示するか
  int _lankingCount = 0;

  @override
  void initState() {
    super.initState();
    _loadLank();
  }

  //_timeを取得する関数
  Future<void> _loadLank() async {
    final db = await DatabaseHelper().db;
    //timesテーブルからtime_recordとtime_datetimeを取得し、time_recordの昇順で並び替える
    final times = await db.rawQuery(
        'SELECT time_record, time_datetime FROM times ORDER BY time_record ASC');
    //timesの中身の数を_lankingCountに代入
    final lankingCount = times.length;

    setState(() {
      _times = times;
      _lankingCount = lankingCount;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(children: [
        Positioned.fill(
          child: Image.asset(
            "assets/y_ranking_page.png",
            fit: BoxFit.cover,
          ),
        ),
        Column(
          children: [
            SizedBox(height: 58),
            Align(
              alignment: Alignment.center,
              child: Container(
                padding: const EdgeInsets.only(top: 55),
                width: 310,
                height: 420,
                child: Scrollbar(
                  child: ListView.separated(
                    padding: const EdgeInsets.all(20),
                    separatorBuilder: (context, index) =>
                        const SizedBox(height: 9),
                    //ここでリストの数を決めている
                    itemCount: _lankingCount,
                    itemBuilder: (context, index) =>
                        _buildCard(index + 1, _times[index]),
                  ),
                ),
              )),
          ],
        ),
          // 吹き出し
            Align(
              alignment: Alignment(-0.5, 0.85),
              child: Container(
                width: 250,
                height: 190,
                child: Image.asset(
                  "assets/speech_bubble.png",
                ),
              ),
            ),
            // TODO: ここにchatGPT
            Align(
              alignment: Alignment(-0.40, 0.62),
              child: CustomText(text:'今日のラッキーアイテム', fontSize: 18, Color: Constant.gray,),
            ),
            // 鶏の画像
            Align(
              alignment: Alignment(0.8, 0.95),
              child: Container(
                width: 120,
                height: 120,
                child: Image.asset(
                  "assets/chicken.png",
                ),
              ),
            ),
      ]),
    );
  }
}

Widget _buildCard(int index, Map<String, dynamic> time) {
  debugPrint(time.toString());
  return Card(
    elevation: 6,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(10),
    ),
    child: Padding(
      padding: const EdgeInsets.all(9.0),
      child: Row(
        children: [
          const SizedBox(
            width: 5,
            height: 0,
          ),
          // 順位の丸
          Container(
            width: 35,
            height: 35,
            decoration: BoxDecoration(
              border: Border.all(color: Constant.accentYellow),
              color: Constant.white,
              shape: BoxShape.circle,
            ),
            child: Center(
              child: Text(
                '$index',
                style: const TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Constant.accentYellow),
              ),
            ),
          ),
          const SizedBox(
            width: 23,
            height: 0,
          ),
          // RTAのタイム
          Column(
            children: [
              CustomText(text: 'りんご', fontSize: 14, Color: Constant.gray),
              Text(
                //timesが秒数で入っているので分と秒に変換し、00:00の形にする
                '${time['time_record'] ~/ 60}'.padLeft(2, '0') +
                    ':' +
                    '${time['time_record'] % 60}'.padLeft(2, '0'),
                style: const TextStyle(
                    fontSize: 25,
                    fontWeight: FontWeight.bold,
                    color: Constant.accentYellow),
              ),
            ],
          ),
          const SizedBox(
            width: 20,
            height: 0,
          ),
          // 年月日のやつ
          Container(
            alignment: Alignment.center,
            margin: const EdgeInsets.only(top: 10, left: 20),
            width: 75,
            height: 20,
            decoration: BoxDecoration(
              color: Constant.subYellow,
              borderRadius: BorderRadius.circular(10),
            ),
            child: Text(
              "${time['time_datetime']}",
              style: const TextStyle(
                  color: Constant.accentYellow, fontWeight: FontWeight.bold),
            ),
          )
        ],
      ),
    ),
  );
}
