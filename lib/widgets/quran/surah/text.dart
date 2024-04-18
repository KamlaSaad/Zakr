import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:muslim/controllers/shared.dart';
import '../../text.dart';

class PositionedText extends StatelessWidget {
  final String txt;
  final double radius;
  final double? width;
  const PositionedText({Key? key, required this.txt, required this.radius, this.width}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        height: 37.h,
        constraints: BoxConstraints(minWidth: 50.w),
        padding: EdgeInsets.only(left: 5.w,right: 5.w),
        decoration: BoxDecoration(
          color: settingController.bodyColor.value,
          borderRadius: BorderRadius.circular(0)
        ),
        child: Center(
          child: TextWidget(
            text: txt,
            weight: FontWeight.w600,
            fontSize: 21.sp,
            noResize: true
          )
        )
    );
  }
}

