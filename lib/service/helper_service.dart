import 'dart:convert';

import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:get/get.dart';
import 'package:wallpaper_app/core/repository.dart';
import 'package:wallpaper_app/main.dart';
import 'package:wallpaper_app/models/post.dart';
import 'package:flutter/foundation.dart' as foundation;

import 'package:wallpaper_app/models/user.dart' as user_model;
import 'package:wallpaper_app/models/user.dart';
import 'package:wallpaper_app/pages/client/home/home_controller.dart';
import 'package:wallpaper_app/routes/app_routes.dart';

@pragma('vm:entry-point')
Future<void> firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  await Firebase.initializeApp();

  setCategory(message.data["category_id"]);
  print('Handling a background message ${message.messageId}');
}

setCategory(String? payload) {
  if (payload != null) {
    late HomeController home;
    if (Get.isRegistered<HomeController>()) {
      home = Get.find<HomeController>();
    } else {
      home = Get.put(HomeController());
    }
    home.selectCategory(int.tryParse(payload));

    home.update();
  }
}

class HelperService extends GetxService {
  // String? token;
  String? firebaseToken;
  User? user;
  Post? post;
  user_model.User? userModel;
  var productScaffoldKey = GlobalKey<ScaffoldState>();
  var categoryScaffoldKey = GlobalKey<ScaffoldState>();
  var userScaffoldKey = GlobalKey<ScaffoldState>();
  var notifScaffoldKey = GlobalKey<ScaffoldState>();
  var carouselScaffoldKey = GlobalKey<ScaffoldState>();
  var chartScaffoldKey = GlobalKey<ScaffoldState>();
  var sectionScaffoldKey = GlobalKey<ScaffoldState>();
  var settingScaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void onInit() async {
    getUserFromStorage();
    // signOut();
    super.onInit();
  }

  List<int> favoriteList = [];

  @override
  void onReady() {
    initializeNotification().then((_) {
      subscribeTopic();
    });
    favoriteList = readIntList('FavoriteList') ?? [];
    super.onReady();
  }

  Future<String?> subscribeTopic() async {
    if (TargetPlatform.android == foundation.defaultTargetPlatform ||
        TargetPlatform.iOS == foundation.defaultTargetPlatform) {
      FirebaseMessaging.instance.subscribeToTopic("all");
    }
    return null;
  }

  Future<String?> getFcmToken() async {
    if (foundation.kIsWeb ||
        TargetPlatform.android == foundation.defaultTargetPlatform ||
        TargetPlatform.iOS == foundation.defaultTargetPlatform) {
      return await FirebaseMessaging.instance.getToken();
    }
    return null;
  }

  Future getUserFromStorage() async {
    if (box?.read("user") != null) {
      userModel = user_model.User.fromJson(
        jsonDecode(box!.read("user")!),
      );
      if (userModel!.accessToken != null) {
        addTokenToHeader(userModel!.accessToken!);
      }
    } else {}
  }

  Future saveUserToStorage(user_model.User? user) async {
    if (user != null) {
      // sharedPreferences?.clear();
      // sharedPreferences?.setString("user", jsonEncode(user));

      box?.erase();
      box?.write("user", jsonEncode(user));
    }
  }

  FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();

  late AndroidNotificationChannel channel;

  Future<void> initializeNotification() async {
    if (kIsWeb ||
        TargetPlatform.android == defaultTargetPlatform ||
        TargetPlatform.iOS == defaultTargetPlatform) {
      await FirebaseMessaging.instance.requestPermission(
          announcement: false, sound: true, alert: true, badge: true);
      FirebaseMessaging.onBackgroundMessage(firebaseMessagingBackgroundHandler);
      if (!GetPlatform.isWeb) {
        channel = const AndroidNotificationChannel(
          'high_importance_channel',
          'High Importance Notifications',
          importance: Importance.max,
        );

        flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();
        var initializationSettingsAndroid =
            const AndroidInitializationSettings('mipmap/ic_launcher');
        var initSettings =
            InitializationSettings(android: initializationSettingsAndroid);

        flutterLocalNotificationsPlugin.initialize(initSettings,
            onDidReceiveNotificationResponse: (data) {
          if (data.payload != null && data.payload!.isNotEmpty) {
            setCategory(data.payload);
          }
        });
        await flutterLocalNotificationsPlugin
            .resolvePlatformSpecificImplementation<
                AndroidFlutterLocalNotificationsPlugin>()
            ?.createNotificationChannel(channel);

        await FirebaseMessaging.instance
            .setForegroundNotificationPresentationOptions(
                alert: true, badge: true, sound: true);
      }
      FirebaseMessaging.onMessage.listen(
        (RemoteMessage message) {
          RemoteNotification? notification = message.notification;
          AndroidNotification? android = message.notification?.android;
          if (notification != null && android != null && !kIsWeb) {
            flutterLocalNotificationsPlugin.show(
              notification.hashCode,
              notification.title,
              notification.body,
              NotificationDetails(
                android: AndroidNotificationDetails(
                  channel.id,
                  channel.name,
                  icon: '@mipmap/ic_launcher',
                  color: Colors.black,
                  ledOnMs: 30,
                  ledOffMs: 30,

                  // importance: Importance.max,
                  // playSound: true,
                  // enableLights: true,
                ),
              ),
              payload: message.data["category_id"],
            );
            // });
            // }
          }
        },
      );
    }
  }

  void writeIntList(String key, List<int> intList) {
    box?.write(key, intList);
  }

  // Method to read the list of integers
  List<int>? readIntList(String key) {
    return box?.read<List<dynamic>>(key)?.cast<int>();
  }

  Future signOut() async {
    // sharedPreferences?.clear();
    box?.erase();
    userModel = null;
    Get.offAllNamed(AppRoutes.login);
  }

  //
}
