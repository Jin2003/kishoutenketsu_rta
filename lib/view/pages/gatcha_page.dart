import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:kishoutenketsu_rta/view/pages/components/custom_text_blue.dart';

import '../constant.dart';

class GatchaPage extends StatefulWidget {
  const GatchaPage({super.key});

  @override
  State<GatchaPage> createState() => _GatchaPageState();
}

class _GatchaPageState extends State<GatchaPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Constant.mainColor,
        body: Stack(
          children: [
            Positioned.fill(
              child: Image.asset(
                "assets/gatcha_page.png",
                fit: BoxFit.cover,
              ),
            ),//floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
          ],
        ),
        
      );
  }
}