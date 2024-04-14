import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../controllers/shared.dart';

class TextWidget extends StatelessWidget {
  final String text;
  final Color? color;
  final bool? noResize;
  final double? fontSize;
  final FontWeight? weight;
  const TextWidget({Key? key, required this.text, this.color, this.noResize, this.fontSize, this.weight}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: TextStyle(
          color: color??settingController.txtColor.value,
          fontSize: noResize==true?fontSize:(fontSize??23+settingController.fontVal.value).sp,
          fontWeight: weight??FontWeight.w500,
          fontFamily: "font4"
      ),
    );
  }
}
