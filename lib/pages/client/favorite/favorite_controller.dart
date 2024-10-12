import 'dart:async';
import 'package:wallpaper_app/core/helper/helper_function.dart';
import 'package:wallpaper_app/models/post.dart';
import 'package:get/get.dart';
import 'package:wallpaper_app/core/repository.dart';
import 'package:wallpaper_app/models/filter.dart';
import 'package:wallpaper_app/service/helper_service.dart';
import 'package:wallpaper_app/models/category.dart';

class FavoriteController extends GetxController {
  final helperService = Get.find<HelperService>();
  DateTime now = DateTime.now();

  List<Post> listProducts = [];
  bool loadingMorePost = false;

  bool loadingPosts = false;
  bool loading = false;
  Filter postFilter = Filter(page: 1, status: 1);

  @override
  void onInit() {
    super.onInit();

    getFavorites();
  }

  Future getFavorites() async {
    try {
      loadingPosts = true;

      update();

      postFilter.ids = helperService.favoriteList;
      final response = await getData('favorites-posts', filter: postFilter);

      if (response.statusCode == 200) {
        final data = response.data;
        listProducts =
            (data["data"] as List).map((x) => Post.fromJson(x)).toList();
        loadingPosts = false;

        update();
      }
    } catch (error, stacktrace) {
      throw Exception("Exception occured: $error stackTrace: $stacktrace");
    }
  }

  void selectSection(int? sectionId) {
    // postFilter.sectionId = categoryId;
    postFilter.sectionId = sectionId;
    postFilter.page = 1;
    postFilter.title = "";
    getFavorites();
  }
}
