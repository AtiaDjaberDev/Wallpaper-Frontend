import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:wallpaper_app/constants_dashboard.dart';
import 'package:wallpaper_app/core/repository.dart';
import 'package:wallpaper_app/core/widget/loading_widget.dart';
import 'package:wallpaper_app/main.dart';
import 'package:wallpaper_app/models/user.dart';
import 'package:wallpaper_app/routes/app_routes.dart';
import 'package:wallpaper_app/service/helper_service.dart';

class RegisterController extends GetxController {
  final helperService = Get.find<HelperService>();

  bool saving = false;
  var too = 0;

  var title = '';
  var body = {};

  TextEditingController emailController = TextEditingController();
  TextEditingController usernameController = TextEditingController();
  TextEditingController passController = TextEditingController();
  TextEditingController confirmPassController = TextEditingController();
  bool isLoading = true;
  bool isHidden = true;
  Icon iu = const Icon(Icons.visibility_off);
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
    if (passController.text == confirmPassController.text) {
      showLoading();
      try {
        user.email = emailController.text;
        user.password = passController.text;
        user.username = usernameController.text;

        final response = await saveData('register', user);
        Get.back();
        if (response.statusCode == 200) {
          final data = response.data["data"];

          helperService.userModel = User.fromJson(data["user"]);
          helperService.userModel?.accessToken = data['token'];

          box?.write("user", jsonEncode(helperService.userModel));

          addTokenToHeader(helperService.userModel!.accessToken!);
          Get.offAllNamed(helperService.userModel?.photo == null
              ? AppRoutes.addUserInfo
              : (isDashboard ? AppRoutes.chart : AppRoutes.home));
        } else {
          Get.snackbar("error", response.data);
        }
      } catch (ex) {
        Get.back();
        print(ex);
      }
    } else {
      Get.rawSnackbar(
          message: "تأكيد كلمة المرور خاطئ", backgroundColor: Colors.red);
    }
  }

  void toggle() {
    if (too == 1) {
      too = 0;
      isHidden = false;
      iu = const Icon(Icons.remove_red_eye);
    } else if (too == 0) {
      too = 1;
      isHidden = true;
      iu = const Icon(Icons.visibility_off);
    }
    update();
  }
}
