import 'dart:async';
import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_qiblah/flutter_qiblah.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:geolocator/geolocator.dart';
import 'package:muslim/controllers/shared.dart';
import 'package:muslim/widgets/app_bar.dart';
import 'package:muslim/widgets/text.dart';
import '../widgets/qiblah/compass.dart';
import '../widgets/qiblah/location.dart';

class QiblahScreen extends StatefulWidget {
  const QiblahScreen({Key? key}) : super(key: key);

  @override
  State<QiblahScreen> createState() => _QiblahScreenState();
}

class _QiblahScreenState extends State<QiblahScreen> {

  final _locationStreamController =
  StreamController<LocationStatus>.broadcast();
  get stream => _locationStreamController.stream;

  @override
  void initState() {
    _checkLocationStatus();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBar(name: "القبلة",shadow: 1),
      body: Container(
        color: settingController.bodyColor.value,
        alignment: Alignment.center,
        padding: EdgeInsets.all(8.w),
        child: StreamBuilder(
          stream: stream,
          builder: (context, AsyncSnapshot<LocationStatus> snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Container(
                alignment: Alignment.center,
                child: (Platform.isAndroid)
                    ? const CircularProgressIndicator()
                    : const CupertinoActivityIndicator(),
              );
            }
            if (snapshot.data!.enabled == true) {
              switch (snapshot.data!.status) {
                case LocationPermission.always:
                case LocationPermission.whileInUse:
                  return QiblahCompassWidget();

                case LocationPermission.denied:
                  return LocationErrorWidget(
                    error: "خصية تحديد الموقع غير مفعلة",
                    callback: _checkLocationStatus,
                  );
                case LocationPermission.deniedForever:
                  return LocationErrorWidget(
                    error: "خصية تحديد الموقع غير مفعلة",
                    callback: _checkLocationStatus,
                  );
                default:
                  return Center(
                    child: TextWidget(text: "حدث خطا يرجي المحاولة مرة اخري",fontSize: 22.sp,),
                  );
              }
            } else {
              return LocationErrorWidget(
                error: "يرجي السماح بتحديد الموقع",
                callback: _checkLocationStatus,
              );
            }
          },
        ),
      ),
    );
  }

  Future<void> _checkLocationStatus() async {
    final locationStatus = await FlutterQiblah.checkLocationStatus();
    if (locationStatus.enabled &&
        locationStatus.status == LocationPermission.denied) {
      await FlutterQiblah.requestPermissions();
      final s = await FlutterQiblah.checkLocationStatus();
      _locationStreamController.sink.add(s);
    } else {
      _locationStreamController.sink.add(locationStatus);
    }
  }

  @override
  void dispose() {
    super.dispose();
    _locationStreamController.close();
    FlutterQiblah().dispose();
  }
}






