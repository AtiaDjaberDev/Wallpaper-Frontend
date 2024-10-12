import 'dart:async';
import 'dart:io';

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_image_compress/flutter_image_compress.dart';
import 'package:wallpaper_app/firebase_options.dart';
import 'package:get/get.dart';
import 'package:wallpaper_app/core/config.dart';
import 'package:wallpaper_app/core/repository.dart';
import 'package:wallpaper_app/routes/app_pages.dart';
import 'package:wallpaper_app/routes/app_routes.dart';
import 'package:wallpaper_app/service/helper_service.dart';
import 'package:get_storage/get_storage.dart';
import 'package:wallpaper_app/theme.dart/dark_theme.dart';
import 'constants_dashboard.dart';

// SharedPreferences? sharedPreferences;
GetStorage? box;

Future<void> main() async {
  await GetStorage.init();
  box = GetStorage();

  Get.put(HelperService());

  if (kIsWeb ||
      TargetPlatform.android == defaultTargetPlatform ||
      TargetPlatform.iOS == defaultTargetPlatform) {
    await Firebase.initializeApp(
        options: DefaultFirebaseOptions.currentPlatform);

    // await FirebaseAppCheck.instance.activate(
    //     // Set appleProvider to `AppleProvider.debug`
    //     androidProvider: AndroidProvider.debug,
    //     webRecaptchaSiteKey: "6LfGUF4nAAAAAHxYF41HKd0fsp-KQ0Q575FNyBoH");
  }
  // }

  addInterceptors();

  await runZonedGuarded(() async {
    HttpOverrides.global = MyHttpOverrides();

    WidgetsFlutterBinding.ensureInitialized();
    runApp(const MyApp());
  }, (err, st) {
    print(err);
    print(st);
  });
  FlutterImageCompress.showNativeLog = true;
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
        systemNavigationBarColor: Colors.white,
        systemNavigationBarIconBrightness: Brightness.dark));
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: isDashboard
          ? (box?.read('user') != null ? AppRoutes.chart : AppRoutes.login)
          : AppRoutes.home,
      getPages: AppPages.pages,
      title: Config.nameApp,
      darkTheme: darkTheme(context),
      themeMode: ThemeMode.dark,
    );
  }
}

class MyHttpOverrides extends HttpOverrides {
  @override
  HttpClient createHttpClient(SecurityContext? context) {
    return super.createHttpClient(context)
      ..badCertificateCallback =
          (X509Certificate cert, String host, int port) => true;
  }
}
