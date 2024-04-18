import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:muslim/controllers/shared.dart';
import 'package:muslim/widgets/text.dart';

List pages = [
  {"img": "quran4.png", "page": "quran", "title": "القران الكريم","color":0xff7696DB},
  {"img": "azkar1.png", "page": "azkar", "title": "الاذكار","color":0xff562D7D},
  {"img": "pray.png", "page": "prayers", "title": "جوامع الدعاء","color":0xffAE427B},
  {"img": "ahadees.png", "page": "ahadees", "title": "احاديث","color":0xffFF8A98},
  {"img": "roqya.png", "page": "prayers", "title": "الرقية الشرعية","color":0xff562D7D},
  {"img": "allah2.png", "page": "allahNames", "title": "الاسماء الحسني","color":0xff7696DB},
  {"img": "kaba.jpg", "page": "qiblah", "title": "القبلة","color":0xffFF8A98},
  {"img": "bearish.png", "page": "sebha", "title": "السبحة","color":0xffAE427B},
];

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  var loading=true.obs;
  @override
  void initState() {
    Timer(const Duration(seconds: 5), () {
      loading.value=false;
    });
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    double padding=Get.width>370 && Get.width<800?Get.width*0.04:0;
    return Obx(() => Stack(
      children: [
        Scaffold(
          backgroundColor: settingController.bodyColor.value,
          appBar: AppBar(
            backgroundColor: settingController.bodyColor.value,
            leading:CircleAvatar(
              backgroundImage: const AssetImage("assets/imgs/azkar.png"),
              backgroundColor: Colors.transparent,
              radius: 14.r,
            ),
            title: TextWidget(text: 'ذكر',fontSize: 25.sp,),
            actions: [
              Obx(() =>
                IconButton(
                  icon: Icon(Icons.settings_rounded, color: settingController.txtColor.value),
                  onPressed: () async{
                    Get.toNamed("/setting");
                  }
                ))
            ],
          ),
          body: Center(
            child: GridView.builder(
              itemCount: pages.length,
              padding: EdgeInsets.only(top: Get.height*0.02,right: padding,left: padding),
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                mainAxisExtent:(Get.width<370?Get.width*0.13:Get.width*0.11)*3.7,
                crossAxisCount: Get.width>=800?3:2,
                crossAxisSpacing: 0, mainAxisSpacing: 15.h),
              itemBuilder: (BuildContext context, int i) {
                return Container(
                  margin: EdgeInsets.symmetric(horizontal: Get.width*0.04,),
                  padding: EdgeInsets.only(top: 6.h),
                  // height: 151,
                  decoration: BoxDecoration(
                    color: settingController.boxColor.value,
                    boxShadow: settingController.darkMode.value ? [] : [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.2),
                        spreadRadius: 3, blurRadius: 2,
                        offset: Offset(0, 3.w),
                      ),
                    ],
                    // borderRadius:BorderRadius.circular(15.r),
                    borderRadius:BorderRadius.only(
                      topLeft: Radius.circular(i.isOdd?18.r:0),
                      topRight: Radius.circular(i.isEven?18.r:0),
                      bottomRight: Radius.circular(i.isOdd?18.r:0),
                      bottomLeft: Radius.circular(i.isEven?18.r:0),
                    ),
                  ),
                  child:GestureDetector(
                      child: Column(
                        children: [
                          const Spacer(),
                          CircleAvatar(
                            backgroundImage: AssetImage("assets/imgs/${pages[i]['img']}"),
                            backgroundColor: Colors.transparent,
                            // backgroundColor: bodyColor.value,
                            radius: Get.width<370?Get.width*0.13:Get.width*0.1,
                            // radius: 42,
                          ),
                          const Spacer(),
                          // Container(
                          //   padding: EdgeInsets.all(2.w),
                          //   decoration: BoxDecoration(
                          //       color: mainColor.value,
                          //     borderRadius: BorderRadius.circular(15)
                          //   ),
                          // ),
                          Center(child: SingleChildScrollView(
                            scrollDirection: Axis.horizontal,
                            child: TextWidget(
                              text:pages[i]['title'],
                              weight: FontWeight.normal,
                              fontSize: 20.sp,
                              noResize: true
                            ),
                          )),
                          const Spacer(),
                        ],
                      ),
                      onTap: ()  {
                        Get.toNamed(pages[i]['page'], arguments: [pages[i]['title']]);
                      }
                  ),
                );
              },
            ),
          ),
        ),
        //***************************Splash
        loading.isFalse?const SizedBox(height: 0,width: 0,):
        Positioned(top: 0,bottom: 0,right: 0,left: 0,
          child: Container(
            color: settingController.bodyColor.value,
            width: Get.width,
            height: Get.height,
            child: Center(child: Image.asset("assets/imgs/azkar.png",scale: 1.15)),
          )
        )
      ],
    ));
  }
}
