import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:wallpaper_app/models/section.dart';
import 'package:wallpaper_app/pages/base_controller.dart';
import 'package:wallpaper_app/core/repository.dart';
import 'package:wallpaper_app/core/widget/custom_notification.dart';
import 'package:wallpaper_app/core/widget/confirm_dialog.dart';
import 'package:wallpaper_app/models/filter.dart';

class SectionController extends BaseController {
  int itemCount = 0;
  var loadingPosts = false;
  Filter postFilter = Filter(page: 1);
  Section section = Section();
  String? nextPage;
  String? prevPage;

  List<Map<String, dynamic>> headers = [
    {"text": "الاسم", "value": "name"},
  ];
  TextEditingController titleController = TextEditingController(text: "");

  List<Section> listSections = [];

  @override
  void onInit() {
    super.onInit();
    getItems();
  }

  save() async {
    section.name = titleController.text;

    var res = await saveDataWithFile("sections", section.toJson(), file);
    if (res.statusCode == 200) {
      Section categoryNew = Section.fromJson(res.data["data"]);
      if (section.id == null) {
        listSections.insert(0, categoryNew);
      } else {
        listSections[listSections.indexWhere((e) => e.id == section.id)] =
            categoryNew;
      }
      update();
      showNotification();
    } else {
      showNotification(title: 'فشلت العملية', isSuccess: false);
    }
  }

  Future getItems() async {
    try {
      loadingPosts = true;
      update();

      final response = await getData('sections', filter: postFilter);
      if (response.statusCode == 200) {
        final data = response.data["data"];
        listSections =
            (data["data"] as List).map((x) => Section.fromJson(x)).toList();
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

  Future<void> delete(Map<String?, dynamic> row) async {
    int id = row["id"];
    if (await showConfirmDialog()) {
      var res = await deleteData("sections", id);
      if (res.statusCode == 200) {
        listSections.removeWhere((element) => element.id == id);
        showNotification();
        itemCount--;
        update();
      } else {
        showNotification(isSuccess: false, title: "فشلت العملية");
      }
    }
  }

  void initializeForm(Map<String?, dynamic> row) {
    section = Section.fromJson(row as Map<String, dynamic>);

    titleController.text = section.name ?? "";
    file = null;

    update();
  }
}
