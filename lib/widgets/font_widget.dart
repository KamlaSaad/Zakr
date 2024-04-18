import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:muslim/widgets/text.dart';
import '../controllers/shared.dart';

void fontDialog() {
  Get.defaultDialog(
    radius: 0,
    backgroundColor: settingController.boxColor.value,
    title: "حجم الخط",
    titleStyle: TextStyle(
      color: settingController.mainColor.value,
      fontFamily: "font4",
      fontWeight: FontWeight.w600,
      fontSize: 22.sp
    ),
    content: Directionality(
        textDirection: TextDirection.rtl,
        child: Obx(() => Column(
          children: List.generate(settingController.fontOptions.length, (i){
            return Row(
              children: [
                Radio<int>(
                  activeColor: settingController.mainColor.value,
                  value: settingController.fontOptions[i]['val'],
                  groupValue: settingController.fontVal.value,
                  onChanged: (val) {
                    settingController.fontVal.value=val!;
                    settingController.saveFont();
                    Get.back();
                  },
                ),
                SizedBox(width: 6.w),
                TextWidget(text: "${settingController.fontOptions[i]['text']}",fontSize: 21.sp,)
              ],
            );
          }),
        )
        )
    )
  );
}

