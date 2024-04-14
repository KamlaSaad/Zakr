import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:zakr/widgets/text.dart';
import '../controllers/shared.dart';

AppBar appBar({required String name, bool? center, required double? shadow}) {
  return AppBar(
    leading: IconButton(
      icon: Icon(
        Icons.arrow_back,
        color: settingController.txtColor.value,
      ),
      onPressed: () => Get.back()
    ),
    backgroundColor: settingController.bodyColor.value,
    centerTitle: center,
    elevation: shadow,
    title: TextWidget(text: name,weight: FontWeight.w600,noResize: true,),
  );
}