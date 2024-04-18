import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:quran/page_data.dart';
import 'package:quran/quran.dart' as quran;
import 'package:muslim/widgets/quran/prayer.dart';
import 'package:muslim/widgets/quran/surah/surah.dart';
import 'package:muslim/widgets/quran/surah/text.dart';
import '../../controllers/shared.dart';
import 'package:get/get.dart';
import '../../widgets/quran/surah/layout.dart';

class SurahScreen extends StatefulWidget {
  const SurahScreen({Key? key}) : super(key: key);

  @override
  State<SurahScreen> createState() => _SurahScreenState();
}

class _SurahScreenState extends State<SurahScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: settingController.bodyColor.value,
      body: SafeArea(
        child: Obx(() => CarouselSlider(
          options: CarouselOptions(
              viewportFraction: 1,
              height: Get.height,
              initialPage: quranController.surahIndex.value,
              enableInfiniteScroll: false,
              onPageChanged: (int i, reason) {
                quranController.saveIndex(i);
              }),
          items: pageData.map((i) {
            return quranController.surahIndex.value == 604
                ? Builder(builder: (BuildContext context) => const QuranPrayerScreen())
                : Builder(builder: (BuildContext context) {
              List<Widget> suras = [];
              int juz = 1;
              bool basmala = false,firstPageInSurah = true;
              for (int x = 0; x < i.length; x++) {
                String surahName = quran.getSurahNameArabic(i[x]['surah']);
                List surahPages = quran.getSurahPages(i[x]['surah']);
                juz = quran.getJuzNumber(i[x]['surah'], i[x]['start']);
                firstPageInSurah = quranController.surahIndex.value + 1 == surahPages[0];
                basmala = i[x]['surah'] != 1 && i[x]['surah'] != 9 && firstPageInSurah;

                var surah = SurahWidget(
                  basmala: basmala,
                  isFirstPage: firstPageInSurah,
                  name: surahName,
                  surahNo: i[x]['surah'],
                  start:  i[x]['start'],
                  end: i[x]['end'],
                );
                suras.add(surah);
              }
              return Stack(
                children: [
                  Layout(child: SizedBox(
                    height: Get.height,
                    child: SingleChildScrollView(
                        child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: suras
                        )
                    ),
                  ),
                  ),
                  //**************Juz Number
                  Positioned(
                    left: Get.width * 0.1, top: 0,
                    child: PositionedText(
                      radius: 5.r,
                      txt: "الجزء ${quranController.convertNum(juz)} ",
                    ),
                  ),
                  //**************Surah Name
                  surahNameWidget(quranController.getNames(firstPageInSurah)),
                  //**************Page Number
                  Positioned(
                      right: Get.width * 0.44, bottom: 2.h,
                      child: PositionedText(
                        radius: 10.r,
                        txt: quranController.convertNum(quranController.surahIndex.value+1),
                      )
                  )
                ],
              );
            });
          }).toList())),
      )
    );
  }

  Widget surahNameWidget(String name){
    return name.isEmpty? SizedBox(width: 0.w) :
    Positioned(
      right: Get.width * 0.1, top: 0,
      child: PositionedText(radius: 5.r, txt: name,)
    );
  }
}
