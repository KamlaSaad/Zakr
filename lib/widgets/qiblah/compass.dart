import 'dart:math';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_qiblah/flutter_qiblah.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'dart:io';
import 'package:muslim/widgets/text.dart';

class QiblahCompassWidget extends StatelessWidget {
  QiblahCompassWidget({Key? key}) : super(key: key);

  final _compassSvg = Image.asset('assets/imgs/compass1.png');
  final _needleSvg = Image.asset(
    'assets/imgs/needle.png', fit: BoxFit.contain,
    height: Get.height * 0.55, alignment: Alignment.center,
  );

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: FlutterQiblah.qiblahStream,
      builder: (_, AsyncSnapshot<QiblahDirection> snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Container(
            alignment: Alignment.center,
            child: (Platform.isAndroid)
                ? const CircularProgressIndicator()
                : const CupertinoActivityIndicator(),
          );
        }
        final qiblahDirection = snapshot.data!;
        return Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Stack(
              alignment: Alignment.center,
              children: <Widget>[
                Transform.rotate(
                  angle: (qiblahDirection.direction * (pi / 180) * -1),
                  child: _compassSvg,
                ),
                Transform.rotate(
                  angle: (qiblahDirection.qiblah * (pi / 180) * -1),
                  alignment: Alignment.center,
                  child: Padding(
                      padding: EdgeInsets.only(right: 19.w), child: _needleSvg),
                )
              ],
            ),
            Padding(
              padding: EdgeInsets.all(10.w),
              child: TextWidget(
                text: "${qiblahDirection.offset.toStringAsFixed(3)}°",
                fontSize: 22.sp,weight: FontWeight.w600,
              ),

            )
          ],
        );
      },
    );
  }

}
