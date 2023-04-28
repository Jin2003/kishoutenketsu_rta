import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:kishoutenketsu_rta/view/constant.dart';

class LankingPage extends StatefulWidget {
  const LankingPage({super.key});

  @override
  State<LankingPage> createState() => _LankingPageState();
}

class _LankingPageState extends State<LankingPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(children: [
        Positioned.fill(
          child: Image.asset(
            "assets/ranking_page.png",
            fit: BoxFit.cover,
          ),
        ),
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
                  itemCount: 10,
                  itemBuilder: (context, index) => _buildCard(index + 1),
                ),
              ),
            ))
      ]),
    );
  }
}

Widget _buildCard(int index) {
  return Card(
    elevation: 6,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(10),
    ),
    child: Padding(
      padding: const EdgeInsets.all(9.0),
      child: Row(
        children: [
          SizedBox(
            width: 5,
            height: 0,
          ),
          // 順位の丸
          Container(
            width: 35,
            height: 35,
            decoration: BoxDecoration(
              color: Constant.mainColor,
              shape: BoxShape.circle,
            ),
            child: Center(
              child: Text(
                '$index',
                style: const TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Constant.white),
              ),
            ),
          ),
          SizedBox(
            width: 18,
            height: 0,
          ),
          // RTAのタイム
          Text(
            '10 : $index',
            style: const TextStyle(
                fontSize: 25,
                fontWeight: FontWeight.bold,
                color: Constant.mainColor),
          ),
          // 年月日のやつ
          Container(
            alignment: Alignment.center,
            margin: EdgeInsets.only(top: 10, left: 20),
            width: 75,
            height: 20,
            decoration: BoxDecoration(
              color: Constant.subColor,
              borderRadius: BorderRadius.circular(10),
            ),
            child: Text(
              "23.04/25",
              style: TextStyle(
                  color: Constant.mainColor, fontWeight: FontWeight.bold),
            ),
          )
        ],
      ),
    ),
  );
}
