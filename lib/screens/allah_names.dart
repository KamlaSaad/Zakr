import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:muslim/widgets/app_bar.dart';
import 'package:muslim/widgets/text.dart';
import '../controllers/shared.dart';
import '../data/god_names.dart';
import '../widgets/allah_name_desc.dart';

class AllahNamesScreen extends StatefulWidget {
  const AllahNamesScreen({Key? key}) : super(key: key);

  @override
  State<AllahNamesScreen> createState() => _AllahNamesScreenState();
}

class _AllahNamesScreenState extends State<AllahNamesScreen> {
  int checkedIndex = 0;
  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        appBar:appBar(name: "اسماء الله الحسني",center: true),
        backgroundColor: settingController.darkMode.isFalse?
        const Color(0xffeeeeee): settingController.bodyColor.value,
        body: GridView.builder(
          itemCount: godNames.length,
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: Get.width>380?4:(Get.width<270?2:3),
            crossAxisSpacing: 5.w, mainAxisSpacing: 5.h
          ),
          itemBuilder: (BuildContext context, int i) {
            bool checked = i == checkedIndex;

            return GestureDetector(
              child: Container(
                width: Get.width * 0.3, height: 70.h,
                color: checked ? settingController.mainColor.value : settingController.boxColor.value,
                child: Center(child: FittedBox(
                  child: TextWidget(
                    text: getName(godNames[i]['name']),
                    color: checked ? Colors.white : settingController.txtColor.value,
                    weight: FontWeight.w600,
                    fontSize: 23.sp,noResize: true
                  )
                )),
              ),
              onTap: () {
                setState(() => checkedIndex = i);
                godNameDesc(godNames[i]);
              },
            );
          },
        ),
      ),
    );
  }

  getName(String name){
    if(name=="ذو الجلال والاكرام"){
      return "ذو الجلال  \n  والاكرام";
    }else if(name=="مالك الملك"){
      return "مالك \nالملك";
    }else{
      return name;
    }
  }
}
