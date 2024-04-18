import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:muslim/controllers/shared.dart';
import 'package:muslim/widgets/app_bar.dart';
import '../data/prayers.dart';
import '../data/roqya.dart';

class PrayersScreen extends StatefulWidget {
  const PrayersScreen({Key? key}) : super(key: key);

  @override
  State<PrayersScreen> createState() => _PrayersScreenState();
}

class _PrayersScreenState extends State<PrayersScreen> {
  String title = Get.arguments[0];
  bool prayer = false;
  String item = "";
  List data = [];
  @override
  void initState() {
    prayer = title == "جوامع الدعاء";
    data = prayer ? prayers : roqya;
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: settingController.darkMode.isFalse?
       const Color(0xffeeeeee): settingController.bodyColor.value,
      appBar: appBar(name: title),
      body: Padding(
        padding: EdgeInsets.only(top: 6.h),
        child: ListView.builder(
          itemCount: prayer?prayers.length:roqya.length,
          itemBuilder: (context, int index) {
            return Container(
              color: settingController.boxColor.value,
              padding: EdgeInsets.symmetric(vertical: 5.h),
              margin: EdgeInsets.symmetric(vertical: 5.h),
              child: Column(
                children: [
                  ListTile(
                    // leading: Box("${index + 1}", mainColor.value, Colors.white, 46.w, 0, 10, () => null,noResize: true),
                    title: RichText(
                      text: TextSpan(
                        text: "${data[index]}",
                        style: TextStyle(
                          fontSize: (22+settingController.fontVal.value).sp,
                          color: settingController.txtColor.value,
                            fontFamily: "font4"
                        )
                      ),
                    ),
                  ),
                ],
              ),
            );
          }),
      ),
    );
  }

}
