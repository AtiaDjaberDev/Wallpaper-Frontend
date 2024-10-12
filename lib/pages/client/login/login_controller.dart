import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:wallpaper_app/constants_dashboard.dart';
import 'package:wallpaper_app/core/repository.dart';
import 'package:wallpaper_app/core/widget/loading_widget.dart';
import 'package:wallpaper_app/main.dart';
import 'package:wallpaper_app/models/user.dart';
import 'package:wallpaper_app/routes/app_routes.dart';
import 'package:wallpaper_app/service/helper_service.dart';

class LoginController extends GetxController {
  final helperService = Get.find<HelperService>();

  bool saving = false;

  var title = '';
  var body = {};

  TextEditingController emailController = TextEditingController();
  TextEditingController passController = TextEditingController();
  bool isLoading = true;
  bool isHidden = true;
  Icon eyesIcon = const Icon(Icons.visibility_off);
  late String selectedCountryCode = "06";
  List<String> countryCodes = ['05', '06', "07"];

  @override
  Future<void> onInit() async {
    super.onInit();
    user.token = await helperService.getFcmToken();
  }

  User user = User();
  bool loading = false;

  Future login() async {
    showLoading();
    try {
      // user.firebaseToken = idToken;
      user.email = emailController.text;
      user.password = passController.text;

      final response = await saveData('login', user);
      if (response.statusCode == 200) {
        final data = response.data["data"];
        Get.back();
        helperService.userModel = User.fromJson(data["user"]);
        helperService.userModel?.accessToken = data['token'];

        box?.write("user", jsonEncode(helperService.userModel));

        addTokenToHeader(helperService.userModel!.accessToken!);
        Get.offAllNamed(isDashboard ? AppRoutes.chart : AppRoutes.home);
      } else {
        Get.back();
        var errorMessages = (response.data["data"] as List).join("\n");

        Get.rawSnackbar(message: errorMessages, backgroundColor: Colors.red);
      }
    } catch (ex) {
      // Get.back();
    }
  }

  void toggle() {
    if (isHidden) {
      isHidden = false;
      eyesIcon = const Icon(Icons.remove_red_eye, color: Colors.grey);
    } else {
      isHidden = true;
      eyesIcon = const Icon(Icons.visibility_off, color: Colors.grey);
    }
    update();
  }
}
