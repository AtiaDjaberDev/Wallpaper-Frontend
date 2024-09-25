import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';
import 'package:wallpaper_app/core/config.dart';

showLoading() {
  Get.dialog(
    Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Center(child: SpinKitPulse(color: Config.secondColor)),
      ],
    ),
    barrierDismissible: false,
  );
}
