import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:muslim/controllers/shared.dart';
import 'package:muslim/widgets/app_bar.dart';
import 'package:muslim/widgets/main_box.dart';
import 'package:muslim/widgets/text.dart';
import '../../controllers/azkar_controller.dart';

class ZikrScreen extends StatefulWidget {
  const ZikrScreen({Key? key}) : super(key: key);

  @override
  State<ZikrScreen> createState() => _ZikrScreenState();
}

class _ZikrScreenState extends State<ZikrScreen> {
  final controller=Get.put(AzkarController());
  String title = "";
  int  listIndex = Get.arguments;
  double w2 = 0,
      w = Get.width<370?Get.width * 0.9:Get.width * 0.82;
  @override
  void initState() {
    title=controller.list[listIndex];
    w2=w * 0.46;
    super.initState();
  }
  @override
  Widget build(BuildContext context) {

    return Scaffold(
        backgroundColor: settingController.bodyColor.value,
        appBar: appBar(name: title),
        body: Obx(() => SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              SizedBox(height: 15.h),
              CircleAvatar(radius: 28.r,
                backgroundColor: settingController.mainColor.value,
                child: TextWidget(text: "${controller.index.value + 1}",color: Colors.white,),
              ),
              SizedBox(height: 5.h),
              controller.data[controller.index.value]['when'] == null?const SizedBox(height: 0) :
              Center(child: Padding(
                padding: EdgeInsets.symmetric(vertical: 7.h),
                child: TextWidget(text: controller.data[controller.index.value]['when'],fontSize: 18.sp,),
              )),
              MainBox(
                text: controller.data[controller.index.value]['item'],
                boxColor: settingController.boxColor.value,
                width: w,radius: 10.r,
              ),
              MainBox(
                text: controller.getCountStr(),
                boxColor: settingController.mainColor.value,
                width: w,radius: 10.r,
                noResize: true,
              ),

              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  MainBox(
                    text: "السابق",
                    boxColor: settingController.boxColor.value,
                    width: w2,radius: 10.r,
                    noResize: true,
                    press: ()=>controller.prev(),
                  ),
                  MainBox(
                    text: "التالي ",
                    boxColor: settingController.boxColor.value,
                    width: w2,radius: 10.r,
                    noResize: true,
                    press: ()=>controller.next(),
                  ),
                ],
              ),
              SizedBox(height: 10.h)
            ],
          ),
        ))
    );
  }


}
