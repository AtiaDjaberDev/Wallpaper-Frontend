import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:wallpaper_app/models/section.dart';
import 'package:wallpaper_app/pages/base_controller.dart';
import 'package:get/get.dart';
import 'package:wallpaper_app/core/repository.dart';
import 'package:wallpaper_app/core/widget/custom_notification.dart';
import 'package:wallpaper_app/models/post.dart';
import 'package:wallpaper_app/routes/app_routes.dart';

class AddPostController extends BaseController {
  TextEditingController titleController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();
  TextEditingController locationController = TextEditingController();

  var loading = true;
  bool uploading = false;
  Post post = Post(categories: []);
  ScrollController scrollController = ScrollController();

  List<Section> sections = [];

  Future refreshUserInfo() async {
    if (helperService.userModel == null) {
      Get.offAndToNamed(AppRoutes.login);
    }
  }

  @override
  void onReady() {
    refreshUserInfo();
    super.onReady();
  }

  bool savingPost = false;
  saveProduct() async {
    post.userId = helperService.userModel?.id;
    post.title = titleController.text;

    savingPost = true;
    update();
    try {
      if (post.categories.isNotEmpty &&
          titleController.text.length > 2 &&
          file != null) {
        var res;
        if (!kIsWeb && Platform.isAndroid && compressedFile != null) {
          res = await saveDataWithXFile("posts", post.toJson(), compressedFile);
        } else {
          res = await saveDataWithAudio("posts", post.toJson(), file);
        }

        if (res.statusCode == 200) {
          titleController.clear();
          post = Post(categories: []);
          sections = [];

          file = null;
          Get.toNamed(AppRoutes.home);
          showNotification();
        } else {
          showNotification(title: 'فشلت العملية', isSuccess: false);
        }
      } else {
        showNotification(title: 'يرجى ملء جميع المعلومات', isSuccess: false);
      }
      savingPost = false;
      update();
    } catch (e) {
      print(e);
    }
  }
}
