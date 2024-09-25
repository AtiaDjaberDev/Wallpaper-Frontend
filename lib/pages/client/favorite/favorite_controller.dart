import 'package:dio/dio.dart';
import 'package:get/get.dart';
import 'package:wallpaper_app/models/post.dart';
import 'package:wallpaper_app/models/filter.dart';

import '../../../core/config.dart';

class FavoriteController extends GetxController {
  List<Post> lisPosts = [];

  var loading_posts = true;
  Filter postFilter = Filter();

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    getPosts();
  }

  getPosts() async {
    try {
      loading_posts = false;
      var dioRequest = Dio();
      dioRequest.options.headers['content-Type'] = 'application/json';
      // dioRequest.options.headers["authorization"] = helperService.token;
      final response =
          await dioRequest.get(Config.baseServerUrl + '/favorites');
      if (response.statusCode == 200) {
        lisPosts =
            (response.data as List).map((x) => Post.fromJson(x)).toList();
        loading_posts = true;
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
