import 'dart:async';
import 'dart:ui';

import 'package:flutter_background_service/flutter_background_service.dart';
import 'package:flutter_background_service_android/flutter_background_service_android.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

Future<void>initializeService() async{
  final service=FlutterBackgroundService();
  AndroidNotificationChannel channel= AndroidNotificationChannel(
      "script academy",
      "foreground services",
      "used for imp notification",
      importance: Importance.high,
  );
  final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
  FlutterLocalNotificationsPlugin();
  await flutterLocalNotificationsPlugin
      .resolvePlatformSpecificImplementation<
      AndroidFlutterLocalNotificationsPlugin>()
      ?.createNotificationChannel(channel);
  await service.configure(iosConfiguration: IosConfiguration(), androidConfiguration: AndroidConfiguration(
      onStart: onStart,
      isForegroundMode: true,
    autoStart: true,
    notificationChannelId: "script academy",
    initialNotificationTitle: "foreground services",
    initialNotificationContent: "initializing",
    foregroundServiceNotificationId: 888,

  ));
  service.startService();

}
@pragma('vm-entry-point')
void onStart(ServiceInstance service) async {
  DartPluginRegistrant.ensureInitialized();
  final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
  FlutterLocalNotificationsPlugin();
  if(service is AndroidServiceInstance){
    service.on('setAsForeground').listen((event) {
      service.setAsForegroundService();
    });
    service.on('setAsBackground').listen((event) {
      service.setAsForegroundService();
    });
  }
    service.on('stopService').listen((event) {
      service.stopSelf();
    });
  Timer.periodic(Duration(seconds: 2),(timer) async {
    if(service is AndroidServiceInstance){
      if(await service.isForegroundService()){
        flutterLocalNotificationsPlugin.show(
            888,
            "women safety app",
            "shake feature added",
            NotificationDetails(
              android: AndroidNotificationDetails(
                "script academy",
                "foreground services",
                "used for imp notification",
                icon: 'ic_bg_service_small',
                ongoing: true,
              )
            ));
      }
    }
  });
}
//cc