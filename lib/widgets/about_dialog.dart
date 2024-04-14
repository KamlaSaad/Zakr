import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:zakr/controllers/shared.dart';
import 'package:zakr/widgets/text.dart';

void aboutDialog() {
  Get.defaultDialog(radius: 5,
      backgroundColor: settingController.boxColor.value,
      title: "حول التطبيق",
      titleStyle: TextStyle(
        color: settingController.mainColor.value,
        fontFamily: "font4",
        fontWeight: FontWeight.w500,
        fontSize: 20.sp
      ),
      content: Directionality(
        textDirection: TextDirection.rtl,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ListTile(
              horizontalTitleGap: 2.w,
              leading: Icon(Icons.star_rate_outlined,color: settingController.mainColor.value,size: 28.w,),
              title: TextWidget(text:"قيم التطبيق", fontSize: 20.sp,),
              onTap: ()=> settingController.goToRateApp(),
            ),
            ListTile(
              horizontalTitleGap: 2.w,
              leading: Icon(Icons.person,color: settingController.mainColor.value,size: 28.w,),
              title: TextWidget(text:"راسل المطور", fontSize: 20.sp,),
              onTap: ()=> settingController.mailLauncher(),
            ),
          ],
        ),
      )
  );
}