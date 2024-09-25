import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:wallpaper_app/models/setting.dart';
import 'package:get/get.dart';
import 'package:wallpaper_app/core/repository.dart';
import 'package:wallpaper_app/core/widget/custom_notification.dart';
import 'package:wallpaper_app/models/filter.dart';
import 'package:wallpaper_app/service/helper_service.dart';

class SupportController extends GetxController {
  int itemCount = 0;
  var loading = false;
  Filter postFilter = Filter(page: 1);
  final helperService = Get.find<HelperService>();

  Setting setting = Setting();
  List<Map<String, dynamic>> headers = [
    {"text": "الاسم", "value": "name"},
  ];
  TextEditingController telController = TextEditingController(text: "");
  TextEditingController emailController = TextEditingController(text: "");

  @override
  void onInit() {
    super.onInit();
    getSetting();
  }

  PlatformFile? file;

  save() async {
    setting.tel = telController.text;
    setting.email = emailController.text;

    var res = await saveDataWithFile("setting", setting.toJson(), file);
    if (res.statusCode == 200) {
      setting = Setting.fromJson(res.data["data"]);

      update();
      showNotification();
    } else {
      showNotification(title: 'فشلت العملية', isSuccess: false);
    }
  }

  Future pickFile() async {
    FilePickerResult? result = await FilePicker.platform
        .pickFiles(type: FileType.image, allowMultiple: false);

    if (result != null) {
      file = result.files.first;

      // var formData = dio.FormData.fromMap({
      //   'photo': await dio.MultipartFile.fromFile(
      //     result.files.first.bytes,
      //     filename: result.files.first.path?.split("/").last,
      //   )
      // });

      update();
    } else {
      print('No image selected.');
    }
  }

  Future getSetting() async {
    try {
      loading = true;
      update();

      final response = await getData('setting', filter: postFilter);
      if (response.statusCode == 200) {
        final data = response.data["data"];
        setting = Setting.fromJson(data);
        telController.text = setting.tel ?? "";
        emailController.text = setting.email ?? "";
        loading = false;

        update();
      }
    } catch (error, stacktrace) {
      throw Exception("Exception occured: $error stackTrace: $stacktrace");
    }
  }

  @override
  void onClose() {
    super.onClose();
  }
}
