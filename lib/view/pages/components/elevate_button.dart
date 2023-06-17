import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../constant.dart';

// elevatedbutton：titleだけ

// これで呼び出せる
// ElevatedButton(
//   title: '',　　テキスト
//   fontSize: ,　フォントサイズ
//   width: ,　　　ボタンの高さ
//   height: ,　　ボタンの横幅
//   nextPage: ,　次どこのページに行くか
// )
class ElevateButton extends StatelessWidget {
  final String title;
  final double shape;
  final double fontSize;
  final double width;
  final double height;
  final Widget? nextPage;
  final Function? onPressed;
  final bool isDisabled = false;

  const ElevateButton({
    Key? key,
    required this.title,
    required this.shape,
    required this.fontSize,
    required this.width,
    required this.height,
    this.nextPage,
    this.onPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width,
      height: height,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: Constant.white,
          elevation: 5,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(shape),
          ),
        ),
        onPressed: () {
          // nextPageがnullの場合はonPressed!を実行する
          if (nextPage == null) {
            onPressed!();
            return;
          }
          Navigator.push(
            context,
            MaterialPageRoute(builder: ((context) => nextPage!)),
          );
        },
        child: Text(
          title,
          style: GoogleFonts.zenMaruGothic(
            fontSize: fontSize,
            fontWeight: FontWeight.bold,
            color: Constant.gray,
          ),
        ),
      ),
    );
  }
}
