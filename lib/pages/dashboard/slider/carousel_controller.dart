import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:wallpaper_app/core/repository.dart';
import 'package:wallpaper_app/core/widget/custom_notification.dart';
import 'package:wallpaper_app/core/widget/confirm_dialog.dart';
import 'package:wallpaper_app/models/carousel.dart';
import 'package:wallpaper_app/models/category.dart';
import 'package:wallpaper_app/models/filter.dart';
import 'package:wallpaper_app/service/helper_service.dart';

class CarouselController extends GetxController {
  int itemCount = 0;
  var loading = false;
  Filter filter = Filter(page: 1);
  Carousel carousel = Carousel();
  final helperService = Get.find<HelperService>();
  String? nextPage;
  String? prevPage;
  ScrollController scrollController = ScrollController();
  List<Category> listCategories = [];

  List<Map<String, dynamic>> headers = [
    {"text": "الرابط", "value": "target"},
  ];
  TextEditingController titleController = TextEditingController(text: "");
  TextEditingController targetController = TextEditingController(text: "");

  var loadingCategories = false;
  List<Carousel> listCarousels = [];
  PlatformFile? file;

  @override
  void onInit() {
    super.onInit();
    getCarousels();
  }

  save() async {
    carousel.name = titleController.text;

    var res = await saveDataWithFile("carousels", carousel.toJson(), file);
    if (res.statusCode == 200) {
      if (carousel.id == null) {
        Carousel slider = Carousel.fromJson(res.data["data"]);

        listCarousels.add(slider);
      } else {
        listCarousels[listCarousels.indexWhere((e) => e.id == carousel.id)] =
            carousel;
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

      update();
    } else {
      print('No image selected.');
    }
  }

  Future getCarousels() async {
    try {
      loading = true;
      update();

      final response = await getData('carousels');
      if (response.statusCode == 200) {
        final data = response.data["data"];

        listCarousels =
            (data["data"] as List).map((x) => Carousel.fromJson(x)).toList();
        loading = false;
        filter.page = data["current_page"];
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

  Future<void> delete(Map<String?, dynamic> row) async {
    int id = row["id"];
    if (await showConfirmDialog()) {
      var res = await deleteData("carousels", id);
      if (res.statusCode == 200) {
        listCarousels.removeWhere((element) => element.id == id);
        showNotification();
        itemCount--;
        update();
      } else {
        showNotification(isSuccess: false, title: "فشلت العملية");
      }
    }
  }

  void initializeForm(Map<String?, dynamic> row) {
    carousel.id = row["id"];
    carousel.photo = row["photo"];
    targetController.text = row["target"] ?? "";
    update();
  }
}
