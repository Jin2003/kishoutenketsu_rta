import 'package:flutter/material.dart';

import 'package:google_fonts/google_fonts.dart';

import '../../constant.dart';

class CustomTextBlue extends StatelessWidget {
  final String text;
  final double fontSize;
  const CustomTextBlue({
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
        fontWeight: FontWeight.bold,
        fontSize: fontSize,
        color: Constant.mainColor,
      ),
    );
  }
}
