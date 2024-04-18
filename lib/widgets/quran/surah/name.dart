import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:muslim/widgets/text.dart';

class SurahNameWidget extends StatelessWidget {
  final String name;
  const SurahNameWidget({Key? key, required this.name}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 50.h,
      width: Get.width * 0.8,
      margin:  EdgeInsets.only(top: 4.h),
      decoration: const BoxDecoration(
        image: DecorationImage(
          fit: BoxFit.fill,
          image: AssetImage("assets/imgs/surahN.png"),
        )
      ),
      child: Center(
        child: TextWidget(
          text: "سورة $name ",
          weight: FontWeight.w700,
          fontSize: 17.sp,
          noResize: true
        )
      )
    );
  }
}

