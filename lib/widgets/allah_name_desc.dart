import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:muslim/controllers/shared.dart';
import 'package:flutter/material.dart';
import 'package:muslim/widgets/text.dart';
import 'package:get/get.dart';

void godNameDesc(Map item) {
  Get.defaultDialog(
      radius: 5.r,
      backgroundColor: settingController.boxColor.value,
      title: " ﴿${item['name']}﴾",
      titleStyle: TextStyle(
          color: settingController.mainColor.value,
          fontFamily: "font4",
          fontWeight: FontWeight.w600,
          fontSize: 23.sp
      ),
      content: Directionality(
          textDirection: TextDirection.rtl,
          child: TextWidget(text: item['desc'],fontSize: 20.sp,)
      ),
      cancel: null,
      confirm: null
  );
}