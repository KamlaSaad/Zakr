import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../data/quran_doaa.dart';
import '../text.dart';
import 'surah/layout.dart';

class QuranPrayerScreen extends StatelessWidget {
  const QuranPrayerScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Layout(child: Padding(
      padding: EdgeInsets.all(10.w),
      child: ListView.builder(
        itemCount: quranDo3a.length,
        itemBuilder: (context,i){
          return Column(
            children: [
              i>0?SizedBox(height: 0.h,):
              Padding(
                  padding: EdgeInsets.symmetric(vertical: 5.h),
                  child: TextWidget(text: "دعاء ختم القران",weight: FontWeight.w700,fontSize: 21.sp,)
              ),
              TextWidget(text: "${quranDo3a[i]}",fontSize: 21.sp,),
            ],
          );
        }
      ),
    ));
  }
}