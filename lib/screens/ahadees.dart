import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:muslim/controllers/shared.dart';
import 'package:muslim/widgets/app_bar.dart';
import 'package:muslim/widgets/main_box.dart';
import 'package:muslim/widgets/text.dart';
import '../data/ahadees.dart';
import 'package:get/get.dart';

class AhadeesScreen extends StatefulWidget {
  const AhadeesScreen({Key? key}) : super(key: key);

  @override
  State<AhadeesScreen> createState() => _AhadeesScreenState();
}

class _AhadeesScreenState extends State<AhadeesScreen> {
  Color btn1Color = settingController.mainColor.value,
      btn2Color = settingController.boxColor.value;
  int index = 0;
  List data = list1;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: settingController.bodyColor.value,
      appBar: appBar(name: "احاديث",shadow: 0),
      body: SafeArea(child: SingleChildScrollView(
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                MainBox(
                  text: "احاديث قدسية",
                  boxColor: btn1Color,
                  txtColor: data == list1?Colors.white:settingController.txtColor.value,
                  width: Get.width * 0.44,
                  margin: 6.h,
                  noResize: true,
                  noShadow: true,
                  press: (){
                    setState(() {
                      btn1Color = settingController.mainColor.value;
                      btn2Color = settingController.boxColor.value;
                      index = 0;
                      data = list1;
                    });
                  },
                ),
                MainBox(
                  text: "احاديث نبوية",
                  boxColor: btn2Color,
                  txtColor: data == list2?Colors.white:settingController.txtColor.value,
                  width: Get.width * 0.44,
                  margin: 6.h,
                  noResize: true,
                  noShadow: true,
                  press: (){
                    setState(() {
                      btn1Color = settingController.boxColor.value;
                      btn2Color = settingController.mainColor.value;
                      index = 0;
                      data = list2;
                    });
                  },
                )
              ],
            ),
            SizedBox(height: Get.height * 0.02),

            CircleAvatar(radius: 28.r,
              backgroundColor: settingController.mainColor.value,
              child: TextWidget(text: "${index + 1}",color: Colors.white,fontSize: 20.sp,),
            ),

            SizedBox(height: Get.height * 0.02),

            MainBox(
              text: data[index],
              boxColor: settingController.boxColor.value,
              txtColor: data == list2?Colors.white:settingController.txtColor.value,
              width: Get.width * 0.86,
              margin: 6.h,radius: 10.r,
            ),

            SizedBox(height: Get.height * 0.025),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                MainBox(
                  text: "السابق",
                  boxColor: settingController.boxColor.value,
                  width: Get.width * 0.40,
                  margin: 6.h,radius: 10.r,
                  press: (){
                    setState(() {
                      if (index > 0) index--;
                    });
                  },
                ),
                MainBox(
                  text: "التالي",
                  boxColor: settingController.boxColor.value,
                  width: Get.width * 0.40,
                  margin: 6.h,radius: 10.r,
                  press: (){
                    setState(() {
                      if (index < data.length - 1) index++;
                    });
                  },
                ),
              ],
            ),
            SizedBox(height: 10.h)
          ],
        ),
      )),
    );
  }

}
