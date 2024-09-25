import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:wallpaper_app/constants_dashboard.dart';
import 'package:wallpaper_app/core/config.dart';
import 'client/custom_elevated_button.dart';

showInfoDialog() async {
  return await Get.dialog(Directionality(
    textDirection: TextDirection.rtl,
    child: AlertDialog(
      title: Text("تمت العملية بنجاح"),
      actions: [
        CustomElevatedButton(
          title: "موافق",
          onPressed: () => Get.back(result: true),
        ),
      ],
    ),
  ));
}

Future showBasicDialog(String title, List<Widget> body,
    [bool showAction = true]) async {
  return await Get.dialog(Directionality(
    textDirection: TextDirection.rtl,
    child: AlertDialog(
      backgroundColor: isDashboard ? bgColor : Colors.white,
      titlePadding: EdgeInsets.all(8),
      title: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(title,
                  style: TextStyle(
                      color: isDashboard
                          ? Config.secondColor
                          : Config.primaryColor,
                      fontSize: 18)),
              IconButton(
                  onPressed: () {
                    Get.back(result: false);
                  },
                  icon: Icon(
                    Icons.cancel_outlined,
                    color: Colors.grey,
                  ))
            ],
          ),
          const Divider(color: Colors.white),
          // const SizedBox(height: 8),
        ],
      ),
      content: SizedBox(
          width: 600,
          child: ListView(
            children: body,
          )),
      actions: showAction
          ? [
              CustomElevatedButton(
                title: "موافق",
                iconData: Icons.save,
                onPressed: () => Get.back(result: true),
              ),
              const SizedBox(width: 14),
              CustomElevatedButton(
                title: "إلغاء",
                iconData: Icons.cancel_outlined,
                backgroundColor: isDashboard ? secondaryColor : Colors.red,
                onPressed: () => Get.back(result: false),
              ),
            ]
          : [],
    ),
  ));
}
