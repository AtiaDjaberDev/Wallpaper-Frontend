import 'package:flutter/material.dart';

// https://www.termsfeed.com/live/77282259-4635-44b2-a993-dc0ca378e477
class Config {
  // NNka4AaFcri!L%oB
  static const String nameApp = "Photo Share";
  static const Color primaryColor = Color.fromRGBO(239, 174, 34, 1);
  static const Color secondColor = Color.fromRGBO(250, 206, 48, 1);
  static const Color backgroundColor = Color.fromRGBO(19, 17, 29, 1);
  static const Color textColor = Color.fromRGBO(214, 214, 214, 1);
  static const String googlePlayUrl =
      "https://play.google.com/store/apps/details?id=com.photo.share";

  //
  static String baseServerUrl = "https://photo.audiostickers.com/api/";
  // static String baseServerUrl = "http://localhost:8000/api/";
  // static const String baseServerUrl = "http://192.168.1.5:8000/api/";
  static final String storageUrl = baseServerUrl.replaceFirst(
      "api/",
      (baseServerUrl.contains("192") || baseServerUrl.contains("localhost"))
          ? "storage/attachments/"
          : "public/storage/attachments/");
  static String logoAsset = "assets/logo2.jpeg";
  // static String baseServerUrl = "https://host.com/api";
  static Map<int, Color> primarySwatch = {
    50: primaryColor.withOpacity(0.1),
    100: primaryColor.withOpacity(0.2),
    200: primaryColor.withOpacity(0.3),
    300: primaryColor.withOpacity(0.4),
    400: primaryColor.withOpacity(0.5),
    500: primaryColor.withOpacity(0.6),
    600: primaryColor.withOpacity(0.7),
    700: primaryColor.withOpacity(0.8),
    800: primaryColor.withOpacity(0.9),
    900: primaryColor,
  };
}
