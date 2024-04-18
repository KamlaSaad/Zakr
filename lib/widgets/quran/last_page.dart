import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:muslim/controllers/shared.dart';
import 'package:muslim/widgets/text.dart';

void openLastPage() {
  Get.defaultDialog(
      radius: 0,
      backgroundColor: settingController.boxColor.value,
      title: "اخر قراءة",
      titleStyle: TextStyle(
        color: settingController.mainColor.value,
        fontFamily: "font4",
        fontSize: 22.sp
      ),
      contentPadding: EdgeInsets.zero,
      content: Directionality(
        textDirection: TextDirection.rtl,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: EdgeInsets.only(left: 8,right: 8.w, bottom: 8.h),
              child: TextWidget(text: "هل تريد فتح اخر قراءة؟",fontSize: 20.w,)
            ),
            Transform.translate(offset: Offset(0,20.w),
              child: Row(children: [
                button(
                  txt: "نعم",
                  txtColor: Colors.white,
                  boxColor: settingController.mainColor.value,
                  action: (){
                    Get.back();
                    Get.toNamed("surah");
                  }
                ),
                button(txt: "لا", boxColor: settingController.bodyColor.value,action: ()=>Get.back())
               ],
              ),
            )
          ],
        )),
      confirm: null,
      cancel: null
  );
}
Widget button({required String txt, Color? txtColor, Color? boxColor, action}){
  return Expanded(
    child: TextButton(
      style: ButtonStyle(backgroundColor: MaterialStateProperty.all(boxColor)),
      child: TextWidget(text: txt,fontSize: 17.w,weight: FontWeight.w600,color: txtColor,),
      onPressed: ()=>action()
    )
  );
}