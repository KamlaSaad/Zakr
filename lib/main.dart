import 'package:audioplayers/audioplayers.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:workmanager/workmanager.dart';
import 'package:zakr/controllers/shared.dart';
import 'dart:async';
import 'screens/home.dart';

// mdmdCallback doesn't work in release mode , ony work in debug
AudioCache audioCache = AudioCache();

mdmdCallback() async{
  Workmanager().executeTask((task, inputData) async {
    await audioCache.play('mhmd.mp3');
    return Future.value(true);
  });
}

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  Workmanager().initialize(mdmdCallback,isInDebugMode:false );
  Workmanager().registerPeriodicTask(
    "periodic-task-identifier", "simplePeriodicTask",
    initialDelay: const Duration(milliseconds: 0),
    frequency: const Duration(minutes: 5),
  );
  await ScreenUtil.ensureScreenSize();
  await Firebase.initializeApp(options:
  const FirebaseOptions(apiKey: "AIzaSyC7CLUMMwiaMEbj8r2dy2Wkd0-SBUBRg9o",
      appId: "1:812195004860:android:33617ac4cc6d4f01a3ebb9",
      messagingSenderId: "messagingSenderId",
      projectId: "muslim-26f12"));

  await settingController.initializeVars();

  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp,DeviceOrientation.portraitDown]);
  runApp(const MyApp());
}
// var loading=true.obs;
class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(360, 690),
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (_,context) {
        return GetMaterialApp(
          debugShowCheckedModeBanner: false,
          home: const HomeScreen(),
          getPages: [
            GetPage(name: '/home', page:() => const HomeScreen()),
            // GetPage(name: '/quran', page:() => const QuranList()),
            // GetPage(name: '/quranPage', page:() =>  const QuranPage()),
            // GetPage(name: '/sheikh', page:() =>  const SheikhScreen()),
            // GetPage(name: '/azkarList', page:() => const AzkarList()),
            // GetPage(name: '/azkar', page:() => Azkar()),
            // GetPage(name: '/allahNames', page:() => AllahNames()),
            // GetPage(name: '/ahadees', page:() => const Ahadees()),
            // GetPage(name: '/prayers', page:() => Prayers()),
            // GetPage(name: '/bearish', page:() => Bearish()),
            // GetPage(name: '/qiblah', page:() => QiblahCompass()),
            // GetPage(name: '/setting', page:() => Setting()),
            // GetPage(name: '/videos', page:() => const Videos()),

          ],
        );
      }
    );
  }
}




