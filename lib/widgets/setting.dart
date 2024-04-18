import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:muslim/widgets/text.dart';
import '../controllers/shared.dart';
import 'package:get/get.dart';

class SettingItem extends StatelessWidget {
  final String text;
  final IconData icon;
  final Widget? trailing;
  final Function tap;
  const SettingItem({Key? key, required this.text, required this.icon,this.trailing, required this.tap}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ListTile(
          leading: Icon(
            icon, size: 30.w,
            color:settingController.mainColor.value,
          ),
          title: TextWidget(text: text,fontSize: 22.sp,) ,
          trailing: trailing,
          onTap: ()=>tap()
        ),
        Container(
          height: 1.h,width: Get.width*0.9,
          color: settingController.mainColor.value.withOpacity(0.4),
        )
      ],
    );
  }
}
