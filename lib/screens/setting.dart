import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:muslim/controllers/shared.dart';
import 'package:muslim/widgets/app_bar.dart';
import 'package:muslim/widgets/setting.dart';
import '../widgets/about_dialog.dart';
import '../widgets/font_widget.dart';

class SettingScreen extends StatelessWidget {
  const SettingScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Obx(() => Scaffold(
      backgroundColor: settingController.bodyColor.value,
        appBar: appBar(name: ""),
        body: Container(
          // color: settingController.bodyColor.value,
          child: Column(
            children: <Widget>[
              SizedBox(height: Get.height * 0.01),
              SettingItem(
                  text: "مقتطفات",
                  icon: Icons.video_collection_sharp,
                  tap: ()=>Get.toNamed("/videos")
              ),

              //*****************************Theme
              SettingItem(
                  text: "الوضع الليلي",
                  icon: Icons.brightness_3,
                  trailing: SizedBox(
                      width: Get.width * 0.15,
                      child: Obx(() => Switch(
                          value: settingController.darkMode.value,
                          onChanged: (val) {
                            settingController.darkMode.value != settingController.darkMode.value;
                            settingController.toggleTheme();
                            settingController.saveMode();
                          })
                      )
                  ),
                  tap: (){}
              ),

              SettingItem(
                  text: "حجم الخط",
                  icon: Icons.font_download,
                  tap: ()=>fontDialog()
              ),

              SettingItem(
                  text:"حول التطبيق",
                  icon: Icons.app_blocking,
                  tap: ()=>aboutDialog()
              ),

            ],
          ),
        )
    ));
  }

}
