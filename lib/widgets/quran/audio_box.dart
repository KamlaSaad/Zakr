import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:muslim/controllers/shared.dart';
import 'package:muslim/widgets/text.dart';

class AudioBox extends StatelessWidget {
  const AudioBox({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Obx(() =>  Container(
      color: settingController.bodyColor.value,
      width:Get.width,
      child: Column(
        children: [
          Container(
            color: settingController.mainColor.value,
            width:Get.width,
            height: 1.h,
          ),
          ListTile(
            onTap: (){
              Get.toNamed("sheikh");
              quranController.openAudioBox.value=false;
            },
            leading: CircleAvatar(
              radius: 28.r,
              backgroundImage: AssetImage("assets/imgs/${quranController.sheikhIndex.value}.jpg"),
            ),
            title: TextWidget(
              text: " سورة ${quranController.surahName.value}",
              color: settingController.mainColor.value,
              fontSize: 21.sp,
            ),
            subtitle: TextWidget(
              text: " القارئ ${quranController.sheikhName.value}",
              color: settingController.mainColor.value,
              fontSize: 17.sp,
            ),
            trailing:  GestureDetector(
              child:quranController.loading.value?
              CircularProgressIndicator(color: settingController.mainColor.value):
              CircleAvatar(
                  radius: 22.r,
                  backgroundColor: settingController.mainColor.value,
                  child: Icon(quranController.playing.isTrue?Icons.pause:Icons.play_arrow,size: 28.w)
              ),
              onTap: ()async{
                await quranController.play();
              },
            ),
          ),
          SizedBox(height: 5.h),
        ],
      ),

    ));
  }
}

