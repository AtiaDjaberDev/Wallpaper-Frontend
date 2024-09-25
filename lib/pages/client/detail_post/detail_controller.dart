import 'package:dio/dio.dart' as dio;
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:wallpaper_app/models/post.dart';
import 'package:wallpaper_app/models/filter.dart';
import 'package:wallpaper_app/service/helper_service.dart';

import '../../../core/config.dart';

class DetailController extends GetxController {
  var loadingComments = true;
  List<Post> listPostsByUser = [];
  List<Post> listPostsBySection = [];
  bool addCommentLoading = false;
  String countComments = "";

  bool isFav = false;
  bool isLoadingFav = true;

  final helperService = Get.find<HelperService>();
  TextEditingController textCommentController = TextEditingController(text: "");
  @override
  void onInit() {
    super.onInit();
    postFilter.userId = helperService.post!.userId;
    postFilter.sectionId = helperService.post!.sectionId;

    getPostsUser().then((value) {
      getPostsSection();
    });
  }

  Filter postFilter = Filter();
  Future getPostsUser() async {
    try {
      // loadingComments = false;
      var dioRequest = dio.Dio();
      dioRequest.options.headers['content-Type'] = 'application/json';
      // dioRequest.options.headers["authorization"] = helperService.token;
      final response = await dioRequest.post(
        Config.baseServerUrl + 'posts',
        data: {"user_id": postFilter.userId},
      );
      if (response.statusCode == 200) {
        listPostsByUser = (response.data["data"] as List)
            .map((x) => Post.fromJson(x))
            .toList();

        // loadingComments = true;
        update();
      }
    } catch (error, stacktrace) {
      throw Exception("Exception occured: $error stackTrace: $stacktrace");
    }
  }

  getPostsSection() async {
    try {
      // loadingComments = false;
      var dioRequest = dio.Dio();
      dioRequest.options.headers['content-Type'] = 'application/json';
      // dioRequest.options.headers["authorization"] = helperService.token;
      final response = await dioRequest.post(
        Config.baseServerUrl + 'posts',
        data: {"section_id": postFilter.sectionId},
      );
      if (response.statusCode == 200) {
        listPostsBySection = (response.data["data"] as List)
            .map((x) => Post.fromJson(x))
            .toList();

        // loadingComments = true;
        update();
      }
    } catch (error, stacktrace) {
      throw Exception("Exception occured: $error stackTrace: $stacktrace");
    }
  }

  @override
  void onClose() {
    // TODO: implement onClose
    super.onClose();
    Get.delete<DetailController>();
  }
}
