import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:wallpaper_app/constants_dashboard.dart';
import 'package:wallpaper_app/core/config.dart';

get darkTheme => (context) => ThemeData(
      scaffoldBackgroundColor: isDashboard ? bgColor : Config.backgroundColor,
      canvasColor: isDashboard ? secondaryColor : null,
      hintColor: Colors.grey,
      useMaterial3: false,
      scrollbarTheme: ScrollbarThemeData(
        thumbVisibility: WidgetStateProperty.all<bool>(true),
        thumbColor: WidgetStateProperty.all(Colors.grey),
      ),
      textTheme: GoogleFonts.tajawalTextTheme(Theme.of(context).textTheme)
          .apply(bodyColor: Config.textColor)
          .copyWith(
              titleMedium: TextStyle(color: Config.textColor, fontSize: 14),
              titleLarge: const TextStyle(
                  color: Colors.white,
                  fontSize: 18,
                  fontWeight: FontWeight.bold)),
      drawerTheme: DrawerThemeData(
          backgroundColor:
              isDashboard ? secondaryColor : Config.backgroundColor,
          width: 220),
      primaryTextTheme:
          GoogleFonts.tajawalTextTheme(Theme.of(context).textTheme).apply(
        bodyColor: Config.textColor,
      ),
      appBarTheme: const AppBarTheme(
          backgroundColor: Config.primaryColor,
          iconTheme: IconThemeData(color: Color.fromARGB(255, 230, 230, 230))),
      primarySwatch:
          MaterialColor(Config.primaryColor.value, Config.primarySwatch),
      buttonTheme: const ButtonThemeData(
          buttonColor: isDashboard ? primaryColor : Config.primaryColor),
      fontFamily: "Tajawal",
    );
