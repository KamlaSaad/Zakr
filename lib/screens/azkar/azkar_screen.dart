import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:muslim/controllers/azkar_controller.dart';
import 'package:muslim/controllers/shared.dart';
import 'package:muslim/widgets/app_bar.dart';
import 'package:muslim/widgets/text.dart';


class AzkarScreen extends StatefulWidget {
  const AzkarScreen({Key? key}) : super(key: key);

  @override
  State<AzkarScreen> createState() => _AzkarScreenState();
}

class _AzkarScreenState extends State<AzkarScreen> {
  final controller=Get.put(AzkarController());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: settingController.bodyColor.value,
      appBar: appBar(name: "اذكار المسلم"),
      body: Container(
          alignment: Alignment.center,
          padding:EdgeInsets.symmetric(horizontal: Get.width*0.05),
          child: SingleChildScrollView(
            child: Column(mainAxisAlignment: MainAxisAlignment.center,
              children: List.generate(controller.list.length, (i){
                return Container(
                  constraints: BoxConstraints(maxWidth: Get.width<370?Get.width*0.8:Get.width*0.7),
                  margin: EdgeInsets.symmetric(vertical: 7.h),
                  padding: EdgeInsets.symmetric(vertical: 6.h),
                  decoration: BoxDecoration(
                    color: settingController.darkMode.isTrue?settingController.boxColor.value
                        :settingController.mainColor.value,
                    borderRadius: BorderRadius.circular(20.r)
                  ),
                  child: GestureDetector(
                    onTap: () {
                      controller.initData(i);
                      Get.toNamed("zikr", arguments: i);
                    },
                    child: Center(child:
                      TextWidget(
                        text: controller.list[i],
                        color: Colors.white,
                        noResize: true,
                        fontSize: 20.sp,
                        weight: FontWeight.w600,
                      )
                    ),
                  ),
                );
              } ),
            ),
          )
      ),
    );
  }
}
