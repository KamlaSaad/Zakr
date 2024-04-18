import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:muslim/controllers/shared.dart';
import 'package:muslim/widgets/quran/surah/name.dart';
import 'package:muslim/widgets/text.dart';
import 'package:quran/quran.dart' as quran;

class SurahWidget extends StatelessWidget {
  final bool basmala;
  final bool isFirstPage;
  final String name;
  final int surahNo;
  final int start;
  final int end;
  const SurahWidget({Key? key, required this.basmala, required this.isFirstPage,
    required this.name, required this.surahNo, required this.start,
    required this.end}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      // crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        isFirstPage ? SurahNameWidget(name:name) : SizedBox(height: 0.h),
        basmala ? Padding(
          padding:EdgeInsets.only(top: 10.h),
          child: TextWidget(
            text: quran.basmala,
            color: settingController.mainColor.value,
            weight: FontWeight.w600,fontSize: 18.sp,
          ),
        ) : const SizedBox(height: 0),

        SizedBox(height: 10.h),
        //how to make text cover all the screen with
        RichText(
          textAlign: TextAlign.center,
          text: TextSpan(
            text: '',
            style: TextStyle(
              color: settingController.txtColor.value,
              fontSize: (22+settingController.fontVal.value).sp,
              fontWeight: FontWeight.w600,
              height: 1.8.h,
              fontFamily:  'RobotoMono',
            ),
            children: <InlineSpan>[
              for (var i = start; i <= end; i++) ...{
                TextSpan(text: quran.getVerse(surahNo, i)),
                TextSpan(
                  text: "﴿${quranController.convertNum(i)}﴾ ",
                  style: TextStyle(
                    color: settingController.mainColor.value,
                    fontWeight: FontWeight.w600,
                    fontFamily: "font4",
                    fontSize: 24.sp
                  )
                ),
              }
            ],
          ),
        )
      ],
    );
  }
}

