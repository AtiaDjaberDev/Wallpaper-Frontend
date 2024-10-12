import 'package:dio/dio.dart' as dio;
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:path_provider/path_provider.dart';
import 'package:wallpaper_app/core/helper/helper_function.dart';
import 'package:wallpaper_app/core/widget/custom_notification.dart';
import 'package:wallpaper_app/models/post.dart';
import 'package:wallpaper_app/models/filter.dart';
import 'package:wallpaper_app/service/helper_service.dart';

class DetailController extends GetxController {
  var loadingComments = true;
  List<Post> listPostsByUser = [];
  List<Post> listPostsBySection = [];
  bool addCommentLoading = false;
  String countComments = "";

  bool isFav = false;
  bool isDownloading = false;

  final helperService = Get.find<HelperService>();
  TextEditingController textCommentController = TextEditingController(text: "");

  late Post post;
  @override
  void onInit() {
    super.onInit();
    post = Get.arguments;
  }

  Filter postFilter = Filter();

  @override
  void onClose() {
    super.onClose();
  }

  void share(Post post) {
    shareFile(post);
  }

  Future<void> download(Post post) async {
    isDownloading = true;
    update();
    await downloadAttachment(post, false);
    showNotification(title: "تم تحميل الصورة");
    isDownloading = false;
    update();
  }

  progress(param0, int? id) {
    post.downloadProgress = param0 / 100;
    update();
  }

  progressShare(param0, int? id) {
    post.shareProgress = param0 / 100;
    update();
  }
}
