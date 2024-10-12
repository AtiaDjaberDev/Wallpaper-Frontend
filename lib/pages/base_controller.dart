import 'dart:io';
import 'package:file_picker/file_picker.dart';
import 'package:wallpaper_app/core/helper/helper_function.dart';
import 'package:wallpaper_app/core/repository.dart';
import 'package:wallpaper_app/models/category.dart';
import 'package:wallpaper_app/service/helper_service.dart';
import 'package:get/get.dart';

class BaseController extends GetxController {
  final helperService = Get.find<HelperService>();
  @override
  void onInit() {
    getCategories();
    super.onInit();
  }

  var loadingCategories = false;
  List<Category> listCategories = [];

  getCategories() async {
    try {
      loadingCategories = false;

      final response = await getData('category/all');
      if (response.statusCode == 200) {
        listCategories = (response.data["data"] as List)
            .map((x) => Category.fromJson(x))
            .toList();
        loadingCategories = true;

        update();
      }
    } catch (error, stacktrace) {
      throw Exception("Exception occured: $error stackTrace: $stacktrace");
    }
  }

  PlatformFile? file;
  File? compressedFile;

  bool isCompressing = false;
  Future pickFile() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
        type: FileType.image, allowMultiple: false, allowCompression: false);

    if (result != null && result.files.isNotEmpty) {
      file = result.files.first;
      isCompressing = true;
      update();
      isCompressing = false;
      update();
    }
  }
}
