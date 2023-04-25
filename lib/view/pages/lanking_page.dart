import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';

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
              height: 420,
              child: Scrollbar(
                child: ListView.separated(
                  padding: const EdgeInsets.all(20),
                  separatorBuilder: (context, index) =>
                      const SizedBox(height: 8),
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
    child: Container(
      margin: const EdgeInsets.all(10),
      child: Text(
        'Item $index',
        style: const TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
      ),
    ),
  );
}
