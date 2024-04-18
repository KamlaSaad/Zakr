import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:quran/quran.dart' as quran;
import 'package:get/get.dart';
import 'package:muslim/widgets/quran/audio_box.dart';
import 'package:muslim/widgets/quran/list_item.dart';
import 'package:muslim/widgets/text.dart';
import '../../controllers/shared.dart';
import '../../data/qur3a.dart';
import '../../widgets/quran/last_page.dart';
import '../../widgets/quran/sheikh.dart';

class QuranScreen extends StatefulWidget {
  const QuranScreen({Key? key}) : super(key: key);

  @override
  State<QuranScreen> createState() => _QuranScreenState();
}

class _QuranScreenState extends State<QuranScreen> {
  String quranImg="quranTxtL";
  double bottom=-Get.height*0.2;
  @override
  void initState() {
    quranImg=settingController.darkMode.value?"quranTxtD2":"quranTxtL";
    quranController.getIndex();
    if(quranController.surahIndex>0){
      Timer(const Duration(seconds: 1), () => openLastPage());
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: settingController.bodyColor.value,
        body: Obx(() => SafeArea(
          child: Stack(
            children: [
              SizedBox(height: Get.height,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Container(
                      width: Get.width,
                      color: settingController.bodyColor.value,
                      // height: height * 0.19,
                      child: Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              SizedBox(
                                width: Get.width * 0.45,
                                height: Get.height * 0.17,
                                child: Image.asset("assets/imgs/$quranImg.png"),
                              ),
                              SizedBox(
                                width: Get.width * 0.45,
                                height: Get.height * 0.17,
                                child: Image.asset("assets/imgs/quran3.png"),
                              ),
                            ],
                          ),
                          Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: List.generate(2, (i){
                                return GestureDetector(
                                  onTap: (){
                                    quranController.tapIndex.value = i;
                                  },
                                  child: Container(
                                    width: Get.width*0.45,
                                    margin: EdgeInsets.symmetric(vertical: 8.h),
                                    padding: EdgeInsets.symmetric(horizontal: 4.w,vertical: 2.h),
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(20.r),
                                      color: quranController.tapIndex.value!=i?settingController.bodyColor.value
                                          :settingController.boxColor.value
                                    ),
                                    child: Center(child: TextWidget(
                                      text: i==0?"قراءة":"استماع",
                                      color: settingController.mainColor.value,
                                      fontSize: 22.sp,
                                    )),
                                  ),
                                );
                              })
                          )
                        ],
                      ),
                    ),
                    // SizedBox(height: height * 0.01),
                    quranController.tapIndex.value==0? Expanded(
                      child: Container(
                        padding: EdgeInsets.only(bottom: quranController.openAudioBox.isTrue?80.h:0),
                        height: Get.height * 0.76,
                        width: Get.width,
                        child: ListView.builder(
                          itemCount: quran.totalSurahCount,
                          itemBuilder: (context, i) {
                            var surah = quranController.getSurahData(i);
                            return QuranListItem(
                              id: surah['id'],
                              aya: surah["aya"],
                              index: i,
                              name: surah["arabic"],
                              type: surah["type"]
                            );
                          }),
                      ),
                    ):Expanded(
                      child: GridView.builder(
                        itemCount: qur3a.length,
                        padding: EdgeInsets.only(bottom: quranController.openAudioBox.isTrue?80.h:0),
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          mainAxisExtent:(Get.width<370?Get.width*0.13:Get.width*0.11)*3.7,
                          crossAxisCount: Get.width>=800?3:2,
                          mainAxisSpacing: 15.h
                        ),
                        itemBuilder: (BuildContext context, int i) {
                          return SheikhWidget(index: i, name: qur3a[i]['name']);
                        },
                      ),
                    ),
                  ],
                ),
              ),
              Obx(() => AnimatedPositioned(
                bottom:quranController.openAudioBox.isTrue?0:-240.h,left: 0,
                duration: const Duration(milliseconds: 800),
                child: const AudioBox()
              ))
            ],
          ),
        ),)
    );
  }

}

