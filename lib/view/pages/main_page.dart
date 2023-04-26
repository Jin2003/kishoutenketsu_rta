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
  late TimeOfDay _timeOfDay;

  @override
  void initState() {
    _timeOfDay = TimeOfDay(hour: 0, minute: 0);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Constant.subColor,
      body: Center(
        child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
          OutlineButton(
            //timeOfDayを18:00のような時間を表示
            title:
                '${_timeOfDay.hour.toString().padLeft(2, '0')}:${_timeOfDay.minute.toString().padLeft(2, '0')}',
            width: 300,
            height: 110,
            fontsize: 60,
            shape: 100,
          ),
          SizedBox(
            width: 0,
            height: 30,
          ),
          ElevateButton(
            title: "時刻設定",
            width: 180,
            height: 55,
            fontSize: 20,
            shape: 30,
            //時刻の設定をする処理
            onPressed: () async {
              final TimeOfDay? timeOfDay = await showTimePicker(
                  context: context, initialTime: _timeOfDay);
              if (timeOfDay != null) setState(() => {_timeOfDay = timeOfDay});
            },
          ),
          SizedBox(
            width: 0,
            height: 20,
          ),
          ElevateButton(
            title: "アラーム音設定",
            width: 180,
            height: 55,
            fontSize: 20,
            shape: 30,
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
