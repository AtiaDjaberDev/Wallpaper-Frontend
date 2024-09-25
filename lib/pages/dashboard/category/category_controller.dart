import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:wallpaper_app/core/repository.dart';
import 'package:wallpaper_app/core/widget/custom_notification.dart';
import 'package:wallpaper_app/core/widget/confirm_dialog.dart';
import 'package:wallpaper_app/models/category.dart';
import 'package:wallpaper_app/models/filter.dart';
import 'package:wallpaper_app/service/helper_service.dart';

class CategoryController extends GetxController {
  int itemCount = 0;
  var loadingPosts = false;
  Filter postFilter = Filter(page: 1);
  Category category = Category(sections: []);
  final helperService = Get.find<HelperService>();
  String? nextPage;
  String? prevPage;
  ScrollController scrollController = ScrollController();

  List<Map<String, dynamic>> headers = [
    {"text": "الاسم", "value": "name"},
  ];
  TextEditingController titleController = TextEditingController(text: "");
  TextEditingController positionController = TextEditingController(text: "");

  var loadingCategories = false;
  List<Category> listCategories = [];

  @override
  void onInit() {
    super.onInit();
    getCategories();
  }

  PlatformFile? file;

  saveCategory() async {
    category.name = titleController.text;
    category.position = int.tryParse(positionController.text) ?? 1;

    var res = await saveDataWithFile("categories", category.toJson(), file);
    if (res.statusCode == 200) {
      Category categoryNew = Category.fromJson(res.data["data"]);
      if (category.id == null) {
        listCategories.insert(0, categoryNew);
      } else {
        listCategories[listCategories.indexWhere((e) => e.id == category.id)] =
            categoryNew;
      }
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

  Future getCategories() async {
    try {
      loadingPosts = true;
      update();

      final response = await getData('categories', filter: postFilter);
      if (response.statusCode == 200) {
        final data = response.data["data"];
        listCategories =
            (data["data"] as List).map((x) => Category.fromJson(x)).toList();
        loadingPosts = false;
        postFilter.page = data["current_page"];
        nextPage = data["next_page_url"];
        prevPage = data["prev_page_url"];
        itemCount = data["total"];
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

  Future<void> deleteCategory(Map<String?, dynamic> row) async {
    int id = row["id"];
    if (await showConfirmDialog()) {
      var res = await deleteData("categories", id);
      if (res.statusCode == 200) {
        listCategories.removeWhere((element) => element.id == id);
        showNotification();
        itemCount--;
        update();
      } else {
        showNotification(isSuccess: false, title: "فشلت العملية");
      }
    }
  }

  void initializeForm(Map<String?, dynamic> row) {
    category = Category(sections: []);
    category.id = row["id"];
    category.photo = row["photo"];
    titleController.text = row["name"] ?? "";
    positionController.text = (row["position"] ?? "").toString();
    file = null;

    update();
  }
}
