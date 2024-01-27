
import 'dart:async';
import 'dart:ui';

import 'package:background_sms/background_sms.dart';
import 'package:flutter_background_service/flutter_background_service.dart';
import 'package:flutter_background_service_android/flutter_background_service_android.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:geolocator/geolocator.dart';
import 'package:shake/shake.dart';
import 'package:telephony/telephony.dart';
import 'package:vibration/vibration.dart';
import 'package:after_marjana/db/db_services.dart';
import 'package:after_marjana/model/contactsm.dart';

int shakeCount = 0;
bool isEmergencySent = false;
bool isShakeEventHandled = false;

sendMessage(String messageBody) async {
  List<TContact> contactList = await DatabaseHelper().getContactList();
  if (contactList.isEmpty) {
    Fluttertoast.showToast(msg: "No numbers exist. Please add a number.");
  } else {
    for (var i = 0; i < contactList.length; i++) {
      Telephony.backgroundInstance
          .sendSms(to: contactList[i].number, message: messageBody)
          .then((value) {
        Fluttertoast.showToast(msg: "Emergency message sent");
      });
    }
  }
}

Future<void> initializeService() async {
  final service = FlutterBackgroundService();
  AndroidNotificationChannel channel = AndroidNotificationChannel(
    "script academy",
    "foreground service",
    "Used for important notifications",
    importance: Importance.high,
  );
  final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
  FlutterLocalNotificationsPlugin();

  await flutterLocalNotificationsPlugin
      .resolvePlatformSpecificImplementation<
      AndroidFlutterLocalNotificationsPlugin>()
      ?.createNotificationChannel(channel);

  await service.configure(
    iosConfiguration: IosConfiguration(),
    androidConfiguration: AndroidConfiguration(
      onStart: onStart,
      isForegroundMode: true,
      autoStart: true,
      notificationChannelId: "script academy",
      initialNotificationTitle: "foreground service",
      initialNotificationContent: "Initializing",
      foregroundServiceNotificationId: 888,
    ),
  );
  service.startService();
}

@pragma('vm-entry-point')
void onStart(ServiceInstance service) async {
  DartPluginRegistrant.ensureInitialized();
  final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
  FlutterLocalNotificationsPlugin();

  if (service is AndroidServiceInstance) {
    service.on('setAsForeground').listen((event) {
      service.setAsForegroundService();
    });
    service.on('setAsBackground').listen((event) {
      service.setAsBackgroundService();
    });
  }
  service.on('stopService').listen((event) {
    service.stopSelf();
  });

  Timer.periodic(Duration(seconds: 2), (timer) async {
    Position? _currentPosition;

    if (service is AndroidServiceInstance) {
      if (await service.isForegroundService()) {
        await Geolocator.getCurrentPosition(
          desiredAccuracy: LocationAccuracy.high,
          forceAndroidLocationManager: true,
        ).then((Position position) {
          _currentPosition = position;
          print("bg location ${position.latitude}");
        }).catchError((e) {
          Fluttertoast.showToast(msg: e.toString());
        });

        if (!isShakeEventHandled) {
          ShakeDetector.autoStart(
            shakeThresholdGravity: 7,
            shakeSlopTimeMS: 500,
            shakeCountResetTime: 3000,
            minimumShakeCount: 1,
            onPhoneShake: () async {
              shakeCount++;

              if (shakeCount >= 3) {
                isEmergencySent = true;
                isShakeEventHandled = true;

                if (await Vibration.hasVibrator() ?? false) {
                  if (await Vibration.hasCustomVibrationsSupport() ?? false) {
                    Vibration.vibrate(duration: 3000);
                  } else {
                    Vibration.vibrate();
                    await Future.delayed(Duration(milliseconds: 500));
                    Vibration.vibrate();
                  }
                }
                shakeCount=0;
                String messageBody =
                    "Emergency! I need help! Location: https://www.google.com/maps/search/?api=1&query=${_currentPosition!.latitude}%2C${_currentPosition!.longitude}";
                sendMessage(messageBody);

                flutterLocalNotificationsPlugin.show(
                  888,
                  "Women safety app",
                  "Shake feature enabled",
                  NotificationDetails(
                    android: AndroidNotificationDetails(
                      "script academy",
                      "foreground service",
                      "Used for important notifications",
                      icon: 'ic_bg_service_small',
                      ongoing: true,
                    ),
                  ),
                );

                // Reset shake count after handling the emergency
                shakeCount = 0;
              }
            },
          );
        }

        if (isEmergencySent) {
          // Perform actions related to an ongoing emergency
        }
      }
    }
  });
}