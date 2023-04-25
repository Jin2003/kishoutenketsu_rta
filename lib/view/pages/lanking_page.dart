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
            "assets/lanking_page.png",
            fit: BoxFit.cover,
          ),
        ),
        Align(
            alignment: Alignment.center,
            child: Container(
              padding: const EdgeInsets.only(top: 50),
              width: 300,
              height: 380,
              child: Scrollbar(
                child: ListView.separated(
                  padding: const EdgeInsets.all(20),
                  separatorBuilder: (context, index) =>
                      const SizedBox(height: 2),
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
            width: 10,
            height: 0,
          ),
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
                    fontSize: 25,
                    fontWeight: FontWeight.bold,
                    color: Constant.white),
              ),
            ),
          ),
          Text(
            '$index',
            style: const TextStyle(
                fontSize: 30,
                fontWeight: FontWeight.bold,
                color: Constant.white),
          ),
          SizedBox(
            width: 20,
            height: 0,
          ),
          Text(
            'item $index',
            style: const TextStyle(
                fontSize: 30,
                fontWeight: FontWeight.bold,
                color: Constant.mainColor),
          ),
        ],
      ),
    ),
  );
}
