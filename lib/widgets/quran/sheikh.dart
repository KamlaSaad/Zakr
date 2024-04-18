import 'package:flutter/cupertino.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:muslim/controllers/shared.dart';

class SheikhWidget extends StatelessWidget {
  final String name;
  final int index;
  const SheikhWidget({Key? key, required this.name, required this.index}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: (){
        quranController.sheikhIndex.value=index;
        Get.toNamed("sheikh");
      },
      child: Container(
        margin: EdgeInsets.symmetric(horizontal: 10.w),
        padding: EdgeInsets.symmetric(horizontal: 5.w,vertical: 10.h),
        decoration: BoxDecoration(
          color: settingController.boxColor.value,
          borderRadius: BorderRadius.circular(10.r),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Container(
              height: 80.h,width: 80.w,
              margin: EdgeInsets.only(bottom: 10.h,top: 5.h),
              decoration: BoxDecoration(
                color: settingController.bodyColor.value,
                shape: BoxShape.circle,
                image: DecorationImage(image: AssetImage("assets/imgs/$index.jpg"))
              ),
            ),

            Expanded(
              child: SingleChildScrollView(
                child: RichText(
                  textAlign: TextAlign.center,
                  text: TextSpan(text: name,
                      style: TextStyle(
                        fontSize: 20.sp,fontFamily: "font4",
                        color: settingController.txtColor.value,
                        height: 1.h
                      )
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
