import 'dart:async';

import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart' as foundation;
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:wallpaper_app/core/repository.dart';
import 'package:wallpaper_app/core/widget/confirm_dialog.dart';
import 'package:wallpaper_app/models/carousel.dart';
import 'package:wallpaper_app/models/category.dart';
import 'package:wallpaper_app/models/comment.dart';
import 'package:wallpaper_app/models/post.dart';
import 'package:wallpaper_app/models/filter.dart';
import 'package:wallpaper_app/models/user.dart';
import 'package:wallpaper_app/service/helper_service.dart';

class HomeController extends GetxController
    with GetSingleTickerProviderStateMixin {
  List<Post> listProducts = [];
  List<Category> listCategories = [];
  List<Comment> listComments = [];
  List<Carousel> listCarousels = [];

  var loadingRelatedData = true;

  var loading = true;
  var loadingPosts = false;
  Filter postFilter = Filter(page: 1, status: 1);
  Comment comment = Comment();
  bool loadingMorePost = false;
  int itemCount = 0;
  int lastPage = 1;
  TextEditingController titleEditingController =
      TextEditingController(text: "");
  TextEditingController commentEditingController =
      TextEditingController(text: "");
  final helperService = Get.find<HelperService>();
  late AnimationController animateController;
  DateTime now = DateTime.now();

  getRelatedData() async {
    try {
      loadingRelatedData = true;
      update();

      final response = await getData('home');
      if (response.statusCode == 200) {
        //
        listCategories = (response.data["data"]["categories"] as List)
            .map((x) => Category.fromJson(x))
            .toList();

        //

        listCarousels = (response.data["data"]["carousels"] as List)
            .map((x) => Carousel.fromJson(x))
            .toList();
      }
      loadingRelatedData = false;

      update();
    } catch (error, stacktrace) {
      throw Exception("Exception occured: $error stackTrace: $stacktrace");
    }
  }

  String durationToString(Duration duration) {
    String twoDigits(int n) {
      if (n >= 10) return '$n';
      return '0$n';
    }

    final twoDigitMinutes =
        twoDigits(duration.inMinutes.remainder(Duration.minutesPerHour));
    final twoDigitSeconds =
        twoDigits(duration.inSeconds.remainder(Duration.secondsPerMinute));
    return '$twoDigitMinutes:$twoDigitSeconds';
  }

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    // animateController = AnimationController(
    //   duration: const Duration(milliseconds: 7000),
    //   vsync: this,
    // )..repeat();

    getRelatedData();
  }

  @override
  Future<void> onReady() async {
    //TODO Enable

    // notificationClickHandle();
    super.onReady();
  }

  notificationClickHandle() async {
    if (foundation.kIsWeb ||
        TargetPlatform.android == foundation.defaultTargetPlatform ||
        TargetPlatform.iOS == foundation.defaultTargetPlatform) {
      RemoteMessage? initialMessage =
          await FirebaseMessaging.instance.getInitialMessage();

      if (initialMessage != null) {
        firebaseMessagingBackgroundHandler(initialMessage);
      }
    }
  }

  getPostComments(int postId) async {
    try {
      loading = true;
      postFilter.postId = postId;
      update();
      listComments = [];
      final response = await getData('comments', filter: postFilter);
      if (response.statusCode == 200) {
        //
        listComments = (response.data["data"] as List)
            .map((x) => Comment.fromJson(x))
            .toList();

        //
      }
      loading = false;

      update();
    } catch (error, stacktrace) {
      throw Exception("Exception occured: $error stackTrace: $stacktrace");
    }
  }

  void selectCategory(int? categoryId) {
    postFilter.categoryId = categoryId;
    postFilter.sectionId = null;
    listProducts.clear();
    postFilter.page = 1;
    postFilter.title = "";
  }

  Future<void> addComment(Post post) async {
    try {
      loading = true;
      comment.postId = post.id;
      update();
      final response = await saveData('comments', comment);
      if (response.statusCode == 200) {
        comment = Comment();
        commentEditingController.clear();
        final selectedPost =
            listProducts.firstWhere((element) => element.id == post.id);
        selectedPost.comments_count = selectedPost.comments_count! + 1;

        listComments.insert(0, Comment.fromJson(response.data["data"]));
        //
        // listComments = (response.data["data"] as List)
        //     .map((x) => Comment.fromJson(x))
        //     .toList();

        //
      }
      loading = false;

      update();
    } catch (error, stacktrace) {
      throw Exception("Exception occured: $error stackTrace: $stacktrace");
    }
  }

  //
}
