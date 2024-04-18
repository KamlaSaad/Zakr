import 'package:audioplayers/audioplayers.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:workmanager/workmanager.dart';
import 'package:muslim/controllers/shared.dart';
import 'package:muslim/screens/ahadees.dart';
import 'package:muslim/screens/allah_names.dart';
import 'package:muslim/screens/azkar/azkar_screen.dart';
import 'package:muslim/screens/azkar/zikr.dart';
import 'package:muslim/screens/prayers.dart';
import 'package:muslim/screens/qiblah.dart';
import 'package:muslim/screens/quran/quran.dart';
import 'package:muslim/screens/quran/sheikh.dart';
import 'package:muslim/screens/quran/surah.dart';
import 'package:muslim/screens/sebha.dart';
import 'package:muslim/screens/setting.dart';
import 'package:muslim/screens/videos.dart';
import 'screens/home.dart';



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

AudioCache audioCache = AudioCache();

mdmdCallback() async{
  Workmanager().executeTask((task, inputData) async {
    await audioCache.play('mhmd.mp3');
    return Future.value(true);
  });
}

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
          builder: (context, child) {
            return Directionality(
              textDirection:TextDirection.rtl,
              child: child!,
            );
          },
          home: const HomeScreen(),
          getPages: [
            GetPage(name: '/home', page:() => const HomeScreen()),
            GetPage(name: '/quran', page:() => const QuranScreen()),
            GetPage(name: '/surah', page:() =>  const SurahScreen()),
            GetPage(name: '/sheikh', page:() =>  const SheikhScreen()),
            GetPage(name: '/azkar', page:() => const AzkarScreen()),
            GetPage(name: '/zikr', page:() => const ZikrScreen()),
            GetPage(name: '/allahNames', page:() => const AllahNamesScreen()),
            GetPage(name: '/ahadees', page:() => const AhadeesScreen()),
            GetPage(name: '/prayers', page:() => const PrayersScreen()),
            GetPage(name: '/sebha', page:() => const SebhaScreen()),
            GetPage(name: '/qiblah', page:() => const QiblahScreen()),
            GetPage(name: '/setting', page:() => const SettingScreen()),
            GetPage(name: '/videos', page:() => const VideosScreen()),

          ],
        );
      }
    );
  }
}




