import 'dart:async';

import 'package:audioplayers/audioplayers.dart';
import 'package:wallpaper_app/core/helper/helper_function.dart';
import 'package:wallpaper_app/models/post.dart';
import 'package:wallpaper_app/models/section.dart';
import 'package:get/get.dart';
import 'package:wallpaper_app/core/repository.dart';
import 'package:wallpaper_app/models/filter.dart';
import 'package:wallpaper_app/models/order.dart';
import 'package:wallpaper_app/service/helper_service.dart';
import 'package:wallpaper_app/models/category.dart';

class AudioController extends GetxController {
  final helperService = Get.find<HelperService>();
  DateTime now = DateTime.now();

  List<Post> listProducts = [];
  bool loadingMorePost = false;
  int itemCount = 0;
  int lastPage = 1;
  bool loadingPosts = false;
  bool loading = false;
  Filter postFilter = Filter(page: 1, status: 1);
  Category? category;

  @override
  void onInit() {
    super.onInit();
    category = Get.arguments["category"];
    if (category != null) {
      postFilter.categoryId = category?.id;
    }
    postFilter.title = Get.arguments["query"];

    getPosts();
  }

  Future getPosts([bool loading = true]) async {
    try {
      if (loading) {
        loadingPosts = true;

        update();
      }

      final response = await getData('posts', filter: postFilter);
      if (loading) {
        listProducts.clear();
      }
      if (response.statusCode == 200) {
        final data = response.data["data"];
        print(data["data"]);
        listProducts.addAll(
            (data["data"] as List).map((x) => Post.fromJson(x)).toList());
        loadingPosts = false;
        postFilter.page = data["current_page"];
        lastPage = data["last_page"];
        itemCount = data["total"];
        update();
      }
    } catch (error, stacktrace) {
      throw Exception("Exception occured: $error stackTrace: $stacktrace");
    }
  }

  Future<void> loadMore() async {
    if (postFilter.page! < lastPage) {
      postFilter.page = postFilter.page! + 1;
      loadingMorePost = true;
      update();
      await getPosts(false);
      loadingMorePost = false;
      update();
    }
  }

  Future<void> filterData() async {
    postFilter.page = 1;

    await getPosts();
  }

  void selectSection(int? sectionId) {
    // postFilter.sectionId = categoryId;
    postFilter.sectionId = sectionId;
    postFilter.page = 1;
    postFilter.title = "";
    getPosts(true);
    stop();
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

  Future<void> pause() async {
    await player.pause();
    playerState = PlayerState.paused;
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

  @override
  void onClose() {
    stop();
    _durationSubscription?.cancel();
    _positionSubscription?.cancel();
    _playerCompleteSubscription?.cancel();
    _playerStateChangeSubscription?.cancel();
    super.onClose();
  }

  double calculateProgress(int index) {
    if (selectedAudioIndex != index) {
      return 0.0;
    }

    if (playerPosition == null || playerDuration == null) {
      return 0.0;
    }

    final positionMs = playerPosition!.inMilliseconds;
    final durationMs = playerDuration!.inMilliseconds;

    if (positionMs <= 0 || positionMs >= durationMs) {
      return 0.0;
    }

    return positionMs / durationMs;
  }

  void share(Post post, int index) {
    selectedAudioIndex = index;
    shareFile(post);
  }

  progress(param0, int? id) {
    if (selectedAudioIndex != null) {
      listProducts.firstWhere((element) => element.id == id).downloadProgress =
          param0 / 100;
      update();
    }
  }
}
