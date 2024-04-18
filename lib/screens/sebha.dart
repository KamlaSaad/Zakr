import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:muslim/controllers/sebha_controller.dart';
import 'package:muslim/controllers/shared.dart';
import 'package:muslim/widgets/app_bar.dart';
import 'package:muslim/widgets/large_text.dart';
import 'package:muslim/widgets/main_box.dart';
import 'package:muslim/widgets/text.dart';
import '../widgets/sebha.dart';

class SebhaScreen extends StatelessWidget {
  const SebhaScreen({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    var controller=Get.put(SebhaController());
    return Scaffold(
      backgroundColor: settingController.bodyColor.value,
      appBar: appBar(name: "السبحة",shadow: 0),
      body: Obx(() => Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              MainBox(
                text: "الذكر",
                boxColor: settingController.mainColor.value,
                width: Get.width * 0.5,
                margin: 6.h,
                noResize: true,
                noShadow: true,
                press: (){
                  menu(
                    txt: "اختر ذكر",
                    data: controller.azkar,
                    change:(i){
                      controller.chooseZikr(i);
                      Get.back();
                    }
                  );
                },
              ),
              MainBox(
                text: "الصيغة",
                boxColor: settingController.darkMode.isFalse?const Color(0xffeeeeee):
                 settingController.boxColor.value,
                width: Get.width * 0.5,
                margin: 6.h,
                noResize: true,
                noShadow: true,
                press: (){
                  menu(
                    txt: "اختر صيغة",
                    data: controller.sygh,
                    change:(i){
                      controller.changeSygh(i);
                      Get.back();
                    }
                  );
                },
              ),
            ],
          ),
          SizedBox(height: Get.height * 0.03),
          Expanded(child: SingleChildScrollView(
            child: Column(children: [
              Container(
                padding:EdgeInsets.symmetric(horizontal: Get.width * 0.15),
                child: Center(child: LargeText(text: controller.zkr.value,))
              ),

              SizedBox(height: Get.height * 0.02),
              TextWidget(text: "${controller.counter}",weight: FontWeight.w600,fontSize: 40.sp,),

              SizedBox(height: Get.height * 0.03),
              CircleAvatar(
                radius: Get.height * 0.14,
                backgroundColor: settingController.mainColor.value.withOpacity(0.8),
                child: Container(
                  height: Get.height * 0.18,
                  width: Get.height * 0.18,
                  decoration: dec(Get.height * 0.18, settingController.mainColor.value),
                  child: GestureDetector(
                    onTap: () async {
                      controller.counter.value++;
                    },
                  ),
                )
              ),
              SizedBox(height: Get.height* 0.03),
              TextButton(
                child: TextWidget(
                  text: "اعادة",fontSize: 20.sp,
                  color: settingController.mainColor.value,
                ),
                onPressed: () => controller.counter.value=0
              ),
            ],),
          )),

        ],
      )),
    );
  }


}