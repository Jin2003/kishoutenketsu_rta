import 'package:flutter/material.dart';

import 'package:google_fonts/google_fonts.dart';

import '../../constant.dart';

class CustomTextWhite extends StatelessWidget {
  final String text;
  final double fontSize;
  const CustomTextWhite({
    super.key,
    required this.text,
    required this.fontSize,
  });

  @override
  Widget build(BuildContext context) {
    return Text(
      textAlign: TextAlign.center,
      text,
      style: GoogleFonts.zenMaruGothic(
        height: 1.5,
        fontWeight: FontWeight.bold,
        fontSize: fontSize,
        color: Constant.white,
      ),
    );
  }
}
