import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:muslim/controllers/shared.dart';
import 'package:muslim/widgets/text.dart';

void popUp(String text){
  if(Get.isDialogOpen==false) {
    Get.defaultDialog(
      backgroundColor: settingController.bodyColor.value,
      title: "",
      titlePadding: EdgeInsets.zero,
      content: Directionality(
        textDirection: TextDirection.rtl,
        child: TextWidget(text:text, weight:  FontWeight.w600, fontSize: 20.sp,)
      )
    );
  }
}