import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:muslim/controllers/shared.dart';
import 'package:muslim/widgets/text.dart';
import '../../widgets/quran/quran_menu.dart';

class SheikhScreen extends StatefulWidget {
  const SheikhScreen({Key? key}) : super(key: key);

  @override
  State<SheikhScreen> createState() => _SheikhScreenState();
}

class _SheikhScreenState extends State<SheikhScreen> {
  @override
  void initState() {
    Timer(const Duration(milliseconds: 50), () {
      quranController.initLink();
    });
    super.initState();
  }
  @override
  void dispose() {
    if(quranController.playing.isTrue){
      Timer(const Duration(milliseconds: 20), () {
        quranController.openAudioBox.value=true;
      });
    }
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: settingController.bodyColor.value,
      body: SafeArea(
        child: Obx(() => Container(
          width: Get.width,
          padding: EdgeInsets.symmetric(horizontal: 20.w),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const Spacer(),
              GestureDetector(
                onTap: ()=>quranMenu(),
                child: Row(mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    TextWidget(
                      text: " سورة ${quranController.surahName.value}",
                      color: settingController.mainColor.value,
                      fontSize: 25.w,
                    ),
                    Icon(
                      Icons.keyboard_arrow_down_sharp,
                      color: settingController.mainColor.value,
                      size: 40.w
                    ),
                  ],
                ),
              ),

              Padding(
                padding: EdgeInsets.symmetric(vertical: 10.h),
                child: CircleAvatar(
                  radius: 100.r,
                  backgroundImage: AssetImage("assets/imgs/${quranController.sheikhIndex.value}.jpg"),
                ),
              ),
              TextWidget(text: " القارئ ${quranController.sheikhName.value}",fontSize: 20.sp),
              // SizedBox(height: 20.h,),
              const Spacer(),
              const Spacer(),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  GestureDetector(
                    onTap: ()=>quranController.prevSurah(),
                    child: CircleAvatar(
                      radius: 20.r,
                      backgroundColor: settingController.boxColor.value,
                      child:Icon(Icons.keyboard_double_arrow_right,size: 28.w)
                    )
                  ),
                  GestureDetector(
                    onTap: ()async{
                      quranController.play();
                    },
                    child: quranController.loading.value?
                    CircularProgressIndicator(color: settingController.mainColor.value):
                    CircleAvatar(
                      radius: 25.r,
                      backgroundColor: settingController.mainColor.value,
                      child:Icon(
                        quranController.playing.isTrue?Icons.pause:Icons.play_arrow,
                        size: 28.w
                      )
                    ),
                  ),
                  GestureDetector(
                    onTap: ()=>quranController.nextSurah(),
                    child: CircleAvatar(
                      radius: 20.r,
                      backgroundColor: settingController.boxColor.value,
                      child:Icon(Icons.keyboard_double_arrow_left,size: 28.w)
                    ),
                  ),
                ],
              ),
              //*******************progress
              Row(mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  TextWidget(text:quranController.playedDur.value, fontSize: 16.sp,noResize: true),
                  Expanded(
                    child: Container(
                      padding: EdgeInsets.only(top: 10.h),
                      child: Center(
                        child: Transform.translate(
                          offset: Offset(0,-5.w),
                          child: Slider(
                            value: quranController.progress.value==0?0.0 :quranController.progress.value,
                            onChanged: (value) {},
                            activeColor: settingController.mainColor.value,
                            inactiveColor: const Color(0xffdddddd),
                            onChangeEnd: (value) {
                              quranController.seekAudioPosition(value);
                            },
                          ),
                        ),
                      )),
                  ),
                  TextWidget(text:quranController.time.value, fontSize: 16.sp,noResize: true),
                ],
              ),
              const Spacer(),
            ],
          ),
        )),
      ),
    );
  }
}
