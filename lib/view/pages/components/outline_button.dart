import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:kishoutenketsu_rta/view/pages/components/custom_text_blue.dart';

import '../../constant.dart';

class OutlineButton extends StatelessWidget {
  final String title;
  final double width;
  final double height;
  final double fontsize;
  final Widget? nextPage;
  final Function? onPressed;
  final bool isDisabled = false;

  const OutlineButton({
    Key? key,
    required this.title,
    required this.width,
    required this.height,
    required this.fontsize,
    this.nextPage,
    this.onPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return OutlinedButton(
      style: OutlinedButton.styleFrom(
        textStyle: TextStyle(
          fontSize: fontsize,
          fontWeight: FontWeight.bold,
        ),
        foregroundColor: Constant.mainColor,
        backgroundColor: Constant.white,
        fixedSize: Size(width, height),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        side: BorderSide(
          width: 3,
          color: Constant.mainColor,
        ),
        elevation: 6,
      ),
      onPressed: () {
        if (onPressed != null) {
          onPressed!();
        }

        if (nextPage != null) {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => nextPage!,
            ),
          );
        }
      },
      child: CustomTextBlue(text: title, fontSize: fontsize),
    );
  }
}
