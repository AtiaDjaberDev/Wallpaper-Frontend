import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:wallpaper_app/constants_dashboard.dart';

class Config {
  //FasOKc3IdAL3Jnh!
  static const String nameApp = "Audio Gate";
  static const Color primaryColor = Color.fromRGBO(84, 65, 120, 1);
  static const Color secondColor = Color.fromRGBO(250, 206, 48, 1);
  static const Color backgroundColor = Color.fromARGB(248, 245, 245, 250);
  static const String googlePlayUrl =
      "https://play.google.com/store/apps/details?id=com.app.audiosticker";

  //
  static String baseServerUrl = "https://dashboard.audiostickers.com/api/";
  // static String baseServerUrl = "http://localhost:8000/api/";
  // static const String baseServerUrl = "http://192.168.1.5:8000/api/";
  static final String storageUrl = baseServerUrl.replaceFirst(
      "api/",
      baseServerUrl.contains("192")
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

get theme => (context) => ThemeData(
      scaffoldBackgroundColor: isDashboard ? bgColor : null,
      canvasColor: isDashboard ? secondaryColor : null,
      hintColor: isDashboard ? Colors.grey : null,
      useMaterial3: false,
      scrollbarTheme: ScrollbarThemeData(
        thumbVisibility: WidgetStateProperty.all<bool>(true),
        thumbColor: WidgetStateProperty.all(Colors.grey),
      ),
      textTheme: isDashboard
          ? GoogleFonts.tajawalTextTheme(Theme.of(context).textTheme)
              .apply(bodyColor: isDashboard ? Colors.white : Colors.black)
          : null,
      appBarTheme: const AppBarTheme(backgroundColor: Config.primaryColor),
      primarySwatch:
          MaterialColor(Config.primaryColor.value, Config.primarySwatch),
      buttonTheme: const ButtonThemeData(
          buttonColor: isDashboard ? primaryColor : Config.primaryColor),
      fontFamily: "Tajawal",
    );
