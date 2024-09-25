import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:wallpaper_app/constants_dashboard.dart';
import 'package:wallpaper_app/models/chart__model.dart';
import 'package:get/get.dart';
import 'package:wallpaper_app/core/repository.dart';
import 'package:wallpaper_app/core/widget/custom_notification.dart';
import 'package:wallpaper_app/core/widget/confirm_dialog.dart';
import 'package:wallpaper_app/models/category.dart';
import 'package:wallpaper_app/models/category.dart';
import 'package:wallpaper_app/models/filter.dart';
import 'package:wallpaper_app/service/helper_service.dart';

extension MyDateExtension on DateTime {
  DateTime getDate() {
    return DateTime(this.year, this.month, this.day);
  }
}

class ChartController extends GetxController {
  int itemCount = 0;
  var loadingPosts = false;
  Filter postFilter = Filter(
      page: 1,
      from: DateTime.now()
          .subtract(Duration(days: 30))
          .toString()
          .substring(0, 10),
      to: DateTime.now().toString().substring(0, 10));
  final helperService = Get.find<HelperService>();
  String? nextPage;
  String? prevPage;
  ScrollController scrollController = ScrollController();

  List<Map<String, dynamic>> headers = [
    {"text": "الاسم", "value": "name"},
  ];
  TextEditingController titleController = TextEditingController(text: "");
  TextEditingController positionController = TextEditingController(text: "");

  var loading = false;
  List listCharts = [];

  @override
  void onInit() {
    super.onInit();
    getCharts();
    getAnalytics();
  }

  List<String> labels = [];
  List<double> values = [];
  Future getCharts() async {
    try {
      loading = true;
      update();

      final response = await getData('getDaysChart', filter: postFilter);
      if (response.statusCode == 200) {
        final data = response.data["data"];
        labels = (data["labels"] as List).map((e) => e.toString()).toList();
        values =
            (data["values"] as List).map((e) => (e as int).toDouble()).toList();
        print(labels);
        loading = false;

        update();
      }
    } catch (error, stacktrace) {
      throw Exception("Exception occured: $error stackTrace: $stacktrace");
    }
  }

  Future getAnalytics() async {
    try {
      loading = true;
      update();

      final response = await getData('analytics');
      if (response.statusCode == 200) {
        final data = response.data["data"];
        demoMyFiles.clear();
        demoMyFiles.add(ChartModel(
          title: "المنشورات",
          value: data["postsCount"],
          svgSrc: "assets/icons/menu_tran.svg",
          color: primaryColor,
        ));
        demoMyFiles.add(ChartModel(
          title: "التصنيفات",
          value: data["categoriesCount"],
          svgSrc: "assets/icons/menu_task.svg",
          color: Color(0xFFFFA113),
        ));
        demoMyFiles.add(ChartModel(
          title: "الإعلانات",
          value: data["adsCount"],
          svgSrc: "assets/icons/slider-svgrepo-com.svg",
          color: Color.fromARGB(255, 238, 116, 89),
        ));
        demoMyFiles.add(ChartModel(
          title: "المستخدمين",
          value: data["usersCount"],
          svgSrc: "assets/icons/menu_profile.svg",
          color: Color.fromARGB(255, 185, 255, 164),
        ));

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
