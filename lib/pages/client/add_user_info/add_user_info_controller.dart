import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:wallpaper_app/constants_dashboard.dart';
import 'package:wallpaper_app/core/repository.dart';
import 'package:wallpaper_app/core/widget/custom_notification.dart';
import 'package:wallpaper_app/routes/app_routes.dart';
import 'package:wallpaper_app/service/helper_service.dart';

class AddUserInfoController extends GetxController {
  final helperService = Get.find<HelperService>();
  TextEditingController nameController = TextEditingController();
  TextEditingController telController = TextEditingController();

  var loading = true;
  bool uploading = false;

  @override
  void onInit() {
    super.onInit();
    nameController.text = helperService.userModel?.username ?? "";
    telController.text = helperService.userModel?.tel ?? "";
  }

  File? optimizedFile;

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
  }

  Future pickFile() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
        type: FileType.image, allowMultiple: false, allowCompression: false);
    if (result != null) {
      PlatformFile? platformFile = result.files.first;

      uploading = true;
      update();

      final response = await saveDataWithFile(
          'user/avatar', {'id': helperService.userModel?.id}, platformFile);
      if (response.statusCode == 200) {
        helperService.userModel!.photo = response.data["data"];
        helperService.saveUserToStorage(helperService.userModel);
      }
      uploading = false;
      update();
    } else {
      print('No image selected.');
    }
  }

  Future updateUserInfo() async {
    if (nameController.text.length > 2 && telController.text.length > 2) {
      helperService.userModel?.username = nameController.text;
      helperService.userModel?.tel = telController.text;

      final response =
          await updateData('users', helperService.userModel?.toJson());
      if (response.statusCode == 200) {
        helperService.saveUserToStorage(helperService.userModel);

        Get.offAndToNamed(isDashboard ? AppRoutes.posts : AppRoutes.home);
      }
    } else {
      showNotification(
          title: "إدخال إسمك أو رقم الهاتف إجباري", isSuccess: false);
    }
  }
}
