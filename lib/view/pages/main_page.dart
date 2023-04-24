import 'package:flutter/material.dart';
import 'package:kishoutenketsu_rta/view/pages/components/custom_text_blue.dart';
import 'package:kishoutenketsu_rta/view/pages/components/elevate_button.dart';
import '../constant.dart';
import 'components/outline_button.dart';

class MainPage extends StatefulWidget {
  const MainPage({super.key});

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Constant.subColor,
      body: Center(
        child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: const [
              OutlineButton(
                title: "8 : 40",
                width: 250,
                height: 80,
                fontsize: 50,
              ),
              SizedBox(
                width: 0,
                height: 40,
              ),
              ElevateButton(
                title: "時刻設定",
                width: 180,
                height: 40,
                fontSize: 20,
              ),
              SizedBox(
                width: 0,
                height: 20,
              ),
              ElevateButton(
                title: "アラーム音設定",
                width: 180,
                height: 40,
                fontSize: 20,
              )
            ]),
      ),
    );
  }
}

// class MainPage extends StatefulWidget {
//   const MainPage({super.key});

//   @override
//   State<MainPage> createState() => _MainPage();
// }

// class _MainPage extends State<MainPage> {
//   void main() {}

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Constant.mainColor,
//       body: Column(children: const [
//         OutlineButton(title: "8:40", width: 300, height: 100),
//         ElevateButton(title: "時刻設定"),
//         ElevateButton(title: "アラーム音設定")
//       ]),
//     );
//   }
// }
