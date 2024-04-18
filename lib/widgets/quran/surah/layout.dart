import 'package:flutter/material.dart';
import 'package:get/get.dart';

class Layout extends StatelessWidget {
  final Widget child;
  const Layout({Key? key, required this.child}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: Get.width,
      height: Get.height,
      padding: EdgeInsets.symmetric(
        horizontal: Get.width*0.09,
        vertical: Get.height * 0.05
      ),
      decoration: const BoxDecoration(
        image: DecorationImage(
          fit: BoxFit.fill,
          image: AssetImage("assets/imgs/layout.png")
        )
      ),
      child: child
    );
  }
}




