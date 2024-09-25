import 'dart:async';
import 'dart:io';

import 'package:audioplayers/audioplayers.dart';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:wallpaper_app/core/helper/helper_function.dart';
import 'package:wallpaper_app/models/section.dart';
import 'package:wallpaper_app/pages/base_controller.dart';
import 'package:wallpaper_app/core/repository.dart';
import 'package:wallpaper_app/core/widget/custom_notification.dart';
import 'package:wallpaper_app/core/widget/confirm_dialog.dart';
import 'package:wallpaper_app/models/comment.dart';
import 'package:wallpaper_app/models/post.dart';
import 'package:wallpaper_app/models/filter.dart';

class PostController extends BaseController {
  List<Post> listPosts = [];
  int itemCount = 0;
  var loadingPosts = false;
  Filter postFilter = Filter(page: 1);
  Post post = Post(visible: 0, categories: []);
  String? nextPage;
  String? prevPage;
  ScrollController scrollController = ScrollController();
  TextEditingController searchController = TextEditingController();

  List<Map<String, dynamic>> headers = [
    // {"text": "الاسم", "value": "title"},
    // {"text": "الوصف", "value": "description"},
    // {"text": "سعر الكرتونة", "value": "packaging_price"},
  ];
  TextEditingController titleController = TextEditingController(text: "");
  TextEditingController descriptionController = TextEditingController(text: "");

  // Price
  TextEditingController packagePriceController =
      TextEditingController(text: "");
  TextEditingController packagePriceTitleController =
      TextEditingController(text: "");

  // Quantity
  TextEditingController packageSizeController = TextEditingController(text: "");
  TextEditingController packageSizeTitleController =
      TextEditingController(text: "");

  List<Section> sections = [];

  @override
  void onInit() {
    super.onInit();
    // if (helperService.userModel != null &&
    //     helperService.userModel!.accessToken != null) {
    addTokenToHeader(helperService.userModel!.accessToken!);
    getPosts().then((value) => getCategories());
    // } else {
    //   WidgetsBinding.instance.addPostFrameCallback((_) {
    //     Get.offAndToNamed(AppRoutes.login);
    //   });
    // }
  }

  Future getPosts() async {
    try {
      loadingPosts = true;
      update();

      final response = await getData('posts-admin', filter: postFilter);
      if (response.statusCode == 200) {
        final data = response.data["data"];
        listPosts =
            (data["data"] as List).map((x) => Post.fromJson(x)).toList();
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

  PlatformFile? file;

  saveProduct() async {
    post.userId = helperService.userModel?.id;
    post.title = titleController.text;
    post.description = descriptionController.text;

    try {
      var res;
      if (!kIsWeb && Platform.isAndroid && compressedFile != null) {
        res = await saveDataWithXFile(
            "store-posts", post.toJson(), compressedFile);
      } else {
        res = await saveDataWithAudio("store-posts", post.toJson(), file);
      }

      if (res.statusCode == 200) {
        Post product = Post.fromJson(res.data["data"]);
        if (post.id == null) {
          listPosts.insert(0, product);
        } else {
          listPosts[listPosts.indexWhere((e) => e.id == product.id)] = product;
        }
        titleController.clear();
        post = Post(categories: []);

        file = null;
        // Get.back();
        update();
        showNotification();
      } else {
        showNotification(title: 'فشلت العملية', isSuccess: false);
      }
    } catch (e) {
      print(e);
    }
  }

  @override
  void onClose() {
    super.onClose();
  }

  Future<void> deleteProduct(Map<String?, dynamic> row) async {
    int id = row["id"];
    if (await showConfirmDialog()) {
      var res = await deleteData("posts", id);
      if (res.statusCode == 200) {
        listPosts.removeWhere((element) => element.id == id);
        showNotification();
        itemCount--;
        update();
      }
    }
  }

  var loading = true;
  List<Comment> listComments = [];
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

  void initializeForm(Map<String?, dynamic> row) {
    post = Post.fromJson(row as Map<String, dynamic>);

    titleController.text = row["title"] ?? "";

    post.visible = row["visible"] == 1 ? 1 : 0;

    sections = post.categories.expand((value) => value.sections).toList();
    compressedFile = null;

    print(sections);
    file = null;
    update();
  }

  Future<void> deleteComment(Comment comment) async {
    if (await showConfirmDialog()) {
      var res = await deleteData("comments", comment.id!);
      if (res.statusCode == 200) {
        listComments.removeWhere((element) => element.id == comment.id);
        showNotification();
        update();
      }
    }
  }

  final player = AudioPlayer();
  int positionPlayer = 0;
  Duration? playerPosition;
  Duration? playerDuration;
  PlayerState? playerState;

  StreamSubscription? _durationSubscription;
  StreamSubscription? _positionSubscription;
  StreamSubscription? _playerCompleteSubscription;
  StreamSubscription? _playerStateChangeSubscription;
  String get durationText => playerDuration?.toString().split('.').first ?? '';

  String get positionText => playerPosition?.toString().split('.').first ?? '';

  bool get isPlaying => playerState == PlayerState.playing;

  bool get isPaused => playerState == PlayerState.paused;

  int? selectedAudioIndex;
  Future<void> playAudio(Post post, int index) async {
    if (selectedAudioIndex != index) {
      selectedAudioIndex = index;
      await stop();
      loading = true;
      update();
    }
    await player.play(UrlSource(resolveImageUrl(post.attachment!)));
    print("Starting..........");
    player.setReleaseMode(ReleaseMode.stop);

    _initStreams();

    playerPosition = (await player.getCurrentPosition())!;
    playerDuration = (await player.getDuration())!;
    await player.resume();
    loading = false;

    playerState = PlayerState.playing;
    update();
  }

  Future<void> stop() async {
    await player.stop();
    playerState = PlayerState.stopped;
    playerPosition = Duration.zero;
    playerDuration = Duration.zero;
    update();
  }

  void _initStreams() {
    _durationSubscription = player.onDurationChanged.listen((duration) {
      playerDuration = duration;
      update();
    });

    _positionSubscription = player.onPositionChanged.listen((p) {
      playerPosition = p;
      update();
    });

    _playerCompleteSubscription = player.onPlayerComplete.listen((event) {
      playerState = PlayerState.stopped;
      playerPosition = Duration.zero;
      update();
    });

    _playerStateChangeSubscription =
        player.onPlayerStateChanged.listen((state) {
      playerState = state;
      update();
    });
  }

  Future<void> pause() async {
    await player.pause();
    playerState = PlayerState.paused;
    update();
  }
}
