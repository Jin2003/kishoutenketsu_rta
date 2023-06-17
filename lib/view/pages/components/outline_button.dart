import 'package:flutter/material.dart';
import 'package:kishoutenketsu_rta/view/pages/components/custom_text.dart';

import '../../constant.dart';

class OutlineButton extends StatelessWidget {
  final String title;
  final double width;
  final double height;
  final double fontsize;
  final double shape;
  final Widget? nextPage;
  final Function? onPressed;
  final bool isDisabled = false;

  const OutlineButton({
    Key? key,
    required this.title,
    required this.width,
    required this.height,
    required this.fontsize,
    required this.shape,
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
        foregroundColor: Constant.gray,
        backgroundColor: Constant.white,
        fixedSize: Size(width, height),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(shape),
        ),
        side: const BorderSide(
          width: 2,
          color: Constant.gray,
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
      child: CustomText(text: title, fontSize: fontsize, Color: Constant.gray ),
    );
  }
}
