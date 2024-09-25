import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:wallpaper_app/firebase_options.dart';
import 'package:get/get.dart';
import 'package:wallpaper_app/core/config.dart';
import 'package:wallpaper_app/core/repository.dart';
import 'package:wallpaper_app/routes/app_pages.dart';
import 'package:wallpaper_app/routes/app_routes.dart';
import 'package:wallpaper_app/service/helper_service.dart';
import 'package:get_storage/get_storage.dart';
import 'constants_dashboard.dart';

// SharedPreferences? sharedPreferences;
GetStorage? box;

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

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

  runApp(const MyApp());
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
      initialRoute: (isDashboard
          ? (box?.read('user') != null ? AppRoutes.chart : AppRoutes.login)
          : AppRoutes.home),
      getPages: AppPages.pages,
      title: Config.nameApp,
      theme: theme(context),
    );
  }
}
