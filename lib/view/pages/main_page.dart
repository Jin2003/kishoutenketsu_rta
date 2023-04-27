import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:kishoutenketsu_rta/view/pages/components/custom_text_blue.dart';
import 'package:kishoutenketsu_rta/view/pages/components/elevate_button.dart';
import 'package:kishoutenketsu_rta/view/rta_page.dart';
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
        child: Column(mainAxisAlignment: MainAxisAlignment.center, 
        children: [
          Container(
            alignment: Alignment.center,
            width: 260,
            height: 90,
            decoration: BoxDecoration(
              border: Border.all(color: Constant.mainColor, width: 5),
              borderRadius: BorderRadius.circular(60),
              // color と boxdecorationの共存はNG
              color: Constant.white,
            ),
            child: Center(
              child: SizedBox(
                width: 240,
                height: 120,
                //timeOfDayを18:00のような時間を表示する
                child: Text(
                  textAlign: TextAlign.center,
                  '${_timeOfDay.hour.toString().padLeft(2, '0')}:${_timeOfDay.minute.toString().padLeft(2, '0')}',
                  style: GoogleFonts.zenMaruGothic(
                    fontWeight: FontWeight.bold,
                    fontSize: 60,
                    color: Constant.mainColor,
                  ),
                ),
              ),
            ),
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
          ),

          SizedBox(
            width: 0,
            height: 40,
          ),
          ElevateButton(
            title: "アラームが鳴ったら",
            width: 250,
            height: 55,
            fontSize: 20,
            shape: 30,
            nextPage: RtaPage(),
          )
        ]),
      ),
    );
  }
}

