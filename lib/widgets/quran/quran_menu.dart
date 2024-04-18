import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:muslim/controllers/shared.dart';
import 'package:quran/quran.dart' as quran;
import 'package:muslim/widgets/text.dart';

void quranMenu(){
  Get.defaultDialog(
    radius: 5.r,
    backgroundColor: settingController.boxColor.value,
    titleStyle: TextStyle(fontSize: 0.sp),
    contentPadding: EdgeInsets.zero,
    titlePadding: EdgeInsets.zero,
    content: Directionality(
      textDirection: TextDirection.rtl,
      child: Container(
        padding:EdgeInsets.all(2.w),
        height: Get.height*0.6,
        width: Get.width*0.75,
        child: ListView.builder(
          itemCount: quran.totalSurahCount,
          itemBuilder: (context,i){
            var surah = quranController.getSurahData(i);
            return Column(
              children: [
                Container(
                  color: settingController.mainColor.value.withOpacity(0.4),
                  height: i==0?0:1.h,width: Get.width,
                ),
                ListTile(
                  title: TextWidget(text:" سورة ${surah["arabic"]}", fontSize: 18.sp,),
                  onTap: (){
                    quranController.saveSurah(name: surah["arabic"],id:surah["id"]);
                    Get.back();
                  }
                ),
              ],
            );
          }),
      )
    ),

  );
}