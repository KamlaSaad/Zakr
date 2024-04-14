import 'package:flutter/foundation.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

class NotificationService {

  final FlutterLocalNotificationsPlugin _flutterLocalNotificationsPlugin =
  FlutterLocalNotificationsPlugin();
  final AndroidInitializationSettings _androidInitializationSettings =
  const AndroidInitializationSettings('ic_launcher');

  void init() async {
    final InitializationSettings initializationSettings =
    InitializationSettings(
      android: _androidInitializationSettings,
    );
    await _flutterLocalNotificationsPlugin.initialize(initializationSettings);
  }

  void createNotification(int count, int i,String name) {
    var androidPlatformChannelSpecifics = AndroidNotificationDetails(
        'progress channel', 'progress channel',
        channelDescription: 'progress channel description',
        channelShowBadge: false,
        importance: Importance.max,
        priority: Priority.high,
        onlyAlertOnce: true,
        showProgress: true,
        maxProgress: count,
        progress: i);
    var platformChannelSpecifics =
    NotificationDetails(android: androidPlatformChannelSpecifics);
    _flutterLocalNotificationsPlugin.show(0, 'جاري التحميل',
        name, platformChannelSpecifics,
        payload: 'item x');
  }
}

class NotificationHelper{
  static late FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin;


  static init()async{
    flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();
  }

  static Future<void> requestPermission() async{
    flutterLocalNotificationsPlugin.resolvePlatformSpecificImplementation<
        AndroidFlutterLocalNotificationsPlugin>()?.requestPermission();

  }
  get onDidReceiveLocalNotification => null;

  static initInfo()async{
    init();
    await NotificationHelper.requestPermission();
    var androidInitialize = const AndroidInitializationSettings('@mipmap/ic_launcher');
    final DarwinInitializationSettings iosInitialize =
    DarwinInitializationSettings(
      requestSoundPermission: false,
      requestBadgePermission: false,
      requestAlertPermission: false,
      onDidReceiveLocalNotification: (x,y,z,w){

      },
    );
    var initializationSettings = InitializationSettings(android: androidInitialize,iOS: iosInitialize);

    NotificationHelper.flutterLocalNotificationsPlugin.initialize(initializationSettings,
      onDidReceiveNotificationResponse:( payload)async{
        if(kDebugMode){
          print("Notification payload $payload");
        }
      },
    );
  }
  static void createNotification(int count, int i,String title,String name) async{

    var androidPlatformChannelSpecifics = AndroidNotificationDetails(
        'progress channel', 'progress channel',
        channelDescription: 'progress channel description',
        channelShowBadge: false,
        importance: Importance.max,
        priority: Priority.high,
        onlyAlertOnce: true,
        showProgress: true,
        maxProgress: count,
        progress: i,
    );
    var platformChannelSpecifics =
    NotificationDetails(android: androidPlatformChannelSpecifics);
    flutterLocalNotificationsPlugin.show(0, title,
        name, platformChannelSpecifics,
        payload: 'item x');
  }
}
