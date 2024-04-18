import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:muslim/controllers/shared.dart';

class LargeText extends StatelessWidget {
  final String text;
  const LargeText({Key? key, required this.text}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double s=Get.width>400?24:21;
    return RichText(
        textAlign: TextAlign.center,
        text: TextSpan(
          text: text,
          style: TextStyle(
            color: settingController.txtColor.value,
            fontWeight: FontWeight.w600,
            fontFamily: "font4",
            fontSize: (s+settingController.fontVal.value).sp
          )
        )
    );
  }
}



