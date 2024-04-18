import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:muslim/controllers/shared.dart';
import 'package:muslim/widgets/text.dart';

class MainBox extends StatelessWidget {
  final String text;
  final Color? boxColor;
  final Color? txtColor;
  final double? width;
  final double? margin;
  final double? radius;
  final bool? noResize;
  final bool? noShadow;
  final Function? press;
  const MainBox({Key? key, required this.text, this.boxColor, this.txtColor,
  this.width, this.margin, this.radius, this.noResize, this.noShadow,
  this.press}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: ()=>press!(),
      child: Container(
        width: width,
        margin: EdgeInsets.symmetric(vertical: margin??6.h),
        padding: EdgeInsets.symmetric(horizontal: 5.w,vertical: 6.h),
        decoration: BoxDecoration(
          color: boxColor,
          borderRadius: BorderRadius.circular(radius??0),
          boxShadow: settingController.darkMode.value || noShadow==true ? [] : [
            BoxShadow(
              color: Colors.grey.withOpacity(0.2),
              spreadRadius: 2,
              blurRadius: 2,
              offset: Offset(0, 2.w)
            )
          ]
        ),
       child: Center(child: TextWidget(
           text: text,color: txtColor,
           weight: FontWeight.normal,
           noResize: noResize,
           fontSize: 20.sp,
        )
       )
      )
    );
  }
}

