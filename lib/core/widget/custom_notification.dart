import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:wallpaper_app/core/config.dart';

showNotification({String title = "تمت العملية بنجاح", bool isSuccess = true}) {
  Get.rawSnackbar(
    backgroundColor: isSuccess ? Config.primaryColor : Colors.red,
    duration: Duration(seconds: 1),
    messageText: Text(
      title,
      style: const TextStyle(color: Colors.white, fontSize: 18),
    ),
    icon: const Icon(Icons.check_circle_outline, color: Colors.white),
    overlayBlur: 1,
  );
}
