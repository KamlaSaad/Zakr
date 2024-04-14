import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:zakr/controllers/shared.dart';
import 'package:zakr/widgets/text.dart';

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