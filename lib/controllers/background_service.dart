// import 'package:background_fetch/background_fetch.dart';
// import 'package:flutter/foundation.dart';
// import '../main.dart';

// import 'dart:async';
// import 'dart:ui';
//
// // import 'package:flutter_background_service/flutter_background_service.dart';
// import 'package:flutter_local_notifications/flutter_local_notifications.dart';

// class BackgroundService {

//   static void _onBackgroundFetch(String taskId) async {
//     BackgroundFetch.finish(taskId);
//   }
//
//   static init(){
//     BackgroundFetch.registerHeadlessTask(backgroundFetchHeadlessTask);
//   }
//   static configure(){
//     BackgroundFetch.configure(BackgroundFetchConfig(
//       minimumFetchInterval: 15, // should be 15<=minimumFetchInterval
//       forceAlarmManager: false,
//       stopOnTerminate: false,
//       startOnBoot: true,
//       enableHeadless: true,
//       requiresBatteryNotLow: false,
//       requiresCharging: false,
//       requiresStorageNotLow: false,
//       requiresDeviceIdle: false,
//       // requiredNetworkType: ,
//     ), _onBackgroundFetch).then((int status) {
//       if(kDebugMode){
//         print('[BackgroundFetch] configure success: $status');
//       }
//     }).catchError((e) {
//       if(kDebugMode) {
//         print('[BackgroundFetch] configure ERROR: $e');
//       }
//     });
//   }
//
//   static void backgroundFetchHeadlessTask(HeadlessTask task)async {
//     bool isTimeout = task.timeout;
//     if (isTimeout) {
//       // This task has exceeded its allowed running-time.
//       // You must stop what you're doing and immediately .finish(taskId)
//       if(kDebugMode){
//         print("[BackgroundFetch] Headless task timed-out");
//       }
//       BackgroundFetch.finish(task.taskId);
//       return;
//     }
//     await audioCache.play('mhmd.mp3');
//     BackgroundFetch.finish(task.taskId);
//   }
// }
