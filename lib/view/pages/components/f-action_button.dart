import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../constant.dart';

class FactionButton extends StatelessWidget {
  final String title;
  final double? fontSize;
  final double? width;
  final double? height;
  final Widget? nextPage;
  final Function? onPressed;
  final bool isDisabled = false;

  const FactionButton({
    Key? key,
    required this.title,
    this.fontSize,
    this.width,
    this.height,
    this.nextPage,
    this.onPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width,
      height: height,
      child: ElevatedButton(
        child: Text(
          title,
          style: GoogleFonts.zenMaruGothic(
            fontSize: fontSize,
            fontWeight: FontWeight.bold,
            color: Constant.mainColor,
          ),),
        style: ElevatedButton.styleFrom(
          backgroundColor: Constant.white,
          elevation: 16,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
        ),
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: ((context) => nextPage!)),
          );
        },
      ),
    );
  }
}
