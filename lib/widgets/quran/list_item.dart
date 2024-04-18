import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:quran/quran.dart' as quran;
import 'package:get/get.dart';
import 'package:muslim/controllers/shared.dart';
import 'package:muslim/widgets/text.dart';

String ayah(int num){
  String txt=num<10?"آيات":"اية";
  return "$num $txt";
}
class QuranListItem extends StatelessWidget {
  final int id;
  final int aya;
  final int index;
  final String name;
  final String type;
  const QuranListItem({Key? key, required this.id, required this.aya, required this.index,
    required this.name, required this.type}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    List pages = quran.getSurahPages(id);
    List pageData=[];
    pageData=quran.getPageData(pages[0]);
    Iterable surahPage=pageData.where((element) => element['surah']==id);
    int juz=quran.getJuzNumber(id, surahPage.first['start']);
    return Container(
      color:settingController.bodyColor.value,
      margin: EdgeInsets.only(top: 10.h),
      child: GestureDetector(
        child: ListTile(
          leading: Padding(
            padding: EdgeInsets.only(top: 5.h),
            child: CircleAvatar(
              radius:Get.width>400?26.r:23.r,
              backgroundColor: settingController.mainColor.value,
              child: TextWidget(
                text: "${index + 1}",
                color: Colors.white,
                fontSize: 18.sp,
                noResize: true
              ),
            ),
          ),
          title: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              TextWidget(
                text: " سورة $name",
                color: settingController.mainColor.value,
                fontSize: 19.sp,
                weight: FontWeight.w600,
              ),
              TextWidget(text: type, fontSize: 16.sp),
            ],
          ) ,
          subtitle: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  TextWidget(text: "الجزء $juz ", fontSize: 16.sp),
                  SizedBox(width: Get.width*0.04),
                  TextWidget(text: ayah(aya), fontSize: 16.sp),
                ],
              ),

            ],
          ),
        ),
        onTap: (){
          quranController.surahIndex.value = pages[0] - 1;
          Get.toNamed("surah");
        },
      ),
    );
  }
}


