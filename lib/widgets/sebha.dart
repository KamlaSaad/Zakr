import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:muslim/controllers/shared.dart';
import 'package:get/get.dart';
import 'package:muslim/widgets/text.dart';

BoxDecoration dec(double size, Color color) {
  return BoxDecoration(
    color: color,
    borderRadius: BorderRadius.circular(size / 2),
    boxShadow: [
      BoxShadow(color: settingController.shadowColor, blurRadius: 10,)
    ]
  );
}

void menu({required String txt, required List data,required Function change}){
  Get.defaultDialog(
    radius: 0,title: txt,
    backgroundColor: settingController.boxColor.value,
    titleStyle: TextStyle(
      color: settingController.mainColor.value,
      fontSize: 22.sp,
      fontWeight: FontWeight.w500
    ),
    contentPadding: const EdgeInsets.all(0),
    content: Directionality(
      textDirection: TextDirection.rtl,
      child: Container(
        padding:const EdgeInsets.all(2),
        height: Get.height*0.5,
        width: Get.width*0.75,
        child:ListView.builder(
          itemCount: data.length,
          itemBuilder: (context,i){
            return ListTile(
              title:  TextWidget(text: data[i],fontSize: 16.sp,),
              onTap: ()=>change(i)
            );
          })
      )
    ));
}
