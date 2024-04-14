import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:zakr/widgets/text.dart';
import '../controllers/shared.dart';

void fontBox() {
  Get.defaultDialog(
    radius: 0,
    backgroundColor: settingController.boxColor.value,
    title: "حجم الخط",
    titleStyle: TextStyle(
      color: settingController.mainColor.value,
      fontFamily: "font4",
      fontWeight: FontWeight.w600,
      fontSize: 22.sp
    ),
    content: Directionality(
        textDirection: TextDirection.rtl,
        child: Obx(() => Fonts(
          options: settingController.fontOptions,
          groupVal: settingController.fontVal.value,
        ))
    )
  );
}
class Fonts extends StatelessWidget {
  final List options;
  final int groupVal;
  const Fonts({Key? key, required this.options, required this.groupVal}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: List.generate(options.length, (i){
        return Row(
          children: [
            Radio<int>(
              activeColor: settingController.mainColor.value,
              value: options[i]['val'],
              groupValue: groupVal,
              onChanged: (val) {
                settingController.fontVal.value=val!;
                settingController.saveFont();
                Get.back();
              },
            ),
            SizedBox(width: 6.w),
            TextWidget(text: "${options[i]['text']}",fontSize: 21.sp,)
          ],
        );
      }),
    );
  }
}
