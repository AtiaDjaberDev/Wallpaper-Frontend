import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:wallpaper_app/core/config.dart';

import 'package:wallpaper_app/core/repository.dart';
import 'package:wallpaper_app/models/category.dart';
import 'package:wallpaper_app/service/helper_service.dart';

class NotificationAdminController extends GetxController {
  PlatformFile? file;
  TextEditingController titleContr = TextEditingController();
  TextEditingController descriptionContr = TextEditingController();
  final helperService = Get.find<HelperService>();
  ScrollController scrollController = ScrollController();
  List<Category> listCategories = [];
  var loadingCategories = false;

  @override
  void onInit() {
    super.onInit();
  }

  int? categoryId;
  Future<void> send() async {
    final response = await saveDataWithFile(
        'notification/add',
        {
          "title": titleContr.text,
          "description": descriptionContr.text,
          "data": categoryId
        },
        file);
    if (response.statusCode == 200) {
      titleContr.clear();
      descriptionContr.clear();
      Get.rawSnackbar(
          messageText: const Text(
            " تمت ارسال الإشعار بنحاح",
            style: TextStyle(color: Colors.white),
          ),
          backgroundColor: Config.primaryColor);
    }
  }

  Future pickFile() async {
    FilePickerResult? result = await FilePicker.platform
        .pickFiles(type: FileType.image, allowMultiple: false);

    if (result != null) {
      file = result.files.first;

      update();
    } else {
      print('No image selected.');
    }
  }
}
