import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:wallpaper_app/core/config.dart';
import 'package:wallpaper_app/models/setting.dart';
import 'package:get/get.dart';
import 'package:wallpaper_app/core/repository.dart';
import 'package:wallpaper_app/models/category.dart';

class ContactController extends GetxController {
  Setting setting = Setting();

  final Uri emailUri = Uri(scheme: 'mailto', path: 'contact@wallpaper_app.ma');
  final Uri contactUri = Uri(scheme: 'tel', path: '0663376751');

  static const String phone = "00000000";
  List<Map<String, Object>> listContact = [
    // {
    //   "name": '$countryCode$phone',
    //   "icon": Icon(Icons.call_outlined),
    //   "scheme": 'tel',
    //   "path": '+40$phone'
    // },
    // {
    //   "name": 'واتساب',
    //   "icon": Icon(FontAwesomeIcons.whatsapp),
    //   "scheme": 'https://wa.me/212$phone?text=مرحبا'
    // },
    // {
    //   "name": 'contact@wallpaper_app.ma',
    //   "icon": Icon(Icons.alternate_email),
    //   "scheme": 'mailto',
    //   "path": 'contact@wallpaper_app.ma'
    // }
  ];
  var loading = true;
  @override
  void onInit() {
    super.onInit();
    getSetting();
  }

  Future getSetting() async {
    try {
      loading = true;
      update();

      final response = await getData('setting');
      if (response.statusCode == 200) {
        final data = response.data["data"];
        setting = Setting.fromJson(data);

        listContact.addIf(
          true,
          {
            "name": setting.tel ?? "",
            "icon": const Icon(Icons.call_outlined),
            "scheme": 'tel',
            "path": setting.tel!
          },
        );
        listContact.addIf(
          true,
          {
            "name": 'واتساب',
            "icon": const Icon(FontAwesomeIcons.whatsapp),
            "scheme":
                'https://wa.me/${setting.tel?.replaceAll("+", "")}?text=مرحبا'
          },
        );
        listContact.addIf(true, {
          "name": setting.email ?? "",
          "icon": const Icon(Icons.email_outlined),
          "scheme": 'mailto',
          "path": setting.email!
        });

        loading = false;

        update();
      }
    } catch (error, stacktrace) {
      throw Exception("Exception occured: $error stackTrace: $stacktrace");
    }
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
  }
}
