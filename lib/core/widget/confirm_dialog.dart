import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:wallpaper_app/constants_dashboard.dart';
import 'package:wallpaper_app/core/widget/client/custom_elevated_button.dart';

showConfirmDialog([String title = "هل انت متاكد من الحذف ؟"]) async {
  return await Get.dialog(Directionality(
    textDirection: TextDirection.rtl,
    child: AlertDialog(
      title: Text(title),
      backgroundColor: isDashboard ? bgColor : Colors.white,
      actions: [
        CustomElevatedButton(
          title: "موافق",
          onPressed: () => Get.back(result: true),
        ),
        CustomElevatedButton(
          title: "إلغاء",
          backgroundColor: Colors.grey.shade300,
          foregroundColor: Colors.grey.shade800,
          onPressed: () => Get.back(result: false),
        )
      ],
    ),
  ));
}

showBlockDialog([String title = "تم حظر حسابك"]) async {
  return await Get.dialog(
    Directionality(
      textDirection: TextDirection.rtl,
      child: AlertDialog(
        title: Text(title),
        backgroundColor: isDashboard ? bgColor : Colors.white,
        actions: [
          CustomElevatedButton(
            title: "موافق",
            onPressed: () =>
                SystemChannels.platform.invokeMethod('SystemNavigator.pop'),
          ),
        ],
      ),
    ),
    barrierDismissible: false,
  );
}
