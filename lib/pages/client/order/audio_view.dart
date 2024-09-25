import 'package:audioplayers/audioplayers.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:wallpaper_app/models/post.dart';
import 'package:wallpaper_app/models/section.dart';
import 'package:wallpaper_app/pages/client/home/home_view.dart';
import 'package:get/get.dart';
import 'package:wallpaper_app/core/config.dart';
import 'package:wallpaper_app/core/helper/helper_function.dart';
import 'package:wallpaper_app/core/widget/shimmer_widget.dart';
import 'package:wallpaper_app/pages/client/order/audio_controller.dart';
import 'package:shimmer/shimmer.dart';
import 'package:timeago/timeago.dart' as timeago;

class AudioView extends StatelessWidget {
  final controller = Get.put(AudioController());

  AudioView({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Directionality(
        textDirection: TextDirection.rtl,
        child: Scaffold(
          backgroundColor: Config.backgroundColor,
          appBar: AppBar(
            elevation: 2,
            title: Text(controller.category?.name ??
                ("بحث عن : " + controller.postFilter.title!) ??
                "ملصقات صوتية"),
          ),
          body: NestedScrollView(
            headerSliverBuilder: (context, val) => [
              if (controller.category != null &&
                  controller.category!.sections.isNotEmpty)
                SliverPersistentHeader(
                  pinned: true,
                  floating: true,
                  delegate: MySliverPersistentHeaderDelegate(
                    minHeight: 55,
                    maxHeight: 55,
                    child: GetBuilder<AudioController>(
                        builder: (_) => Container(
                              padding: const EdgeInsets.only(right: 8),
                              color: Config.backgroundColor,
                              child: Row(
                                children: [
                                  buildSection(
                                      -1,
                                      Section(
                                          name: "الكل", id: null, photo: null),
                                      context),
                                  Expanded(
                                    child: ListView.builder(
                                      physics: const BouncingScrollPhysics(),
                                      scrollDirection: Axis.horizontal,
                                      itemCount: _.category?.sections.length,
                                      itemBuilder: (context, index) {
                                        return buildSection(
                                            index,
                                            _.category!.sections[index],
                                            context);
                                      },
                                    ),
                                  ),
                                ],
                              ),
                            )),
                  ),
                ),
            ],
            body: Stack(
              children: [
                GetBuilder<AudioController>(builder: (_) {
                  return controller.loadingPosts
                      ? const ShimmerWidget()
                      : controller.listProducts.isNotEmpty
                          ? NotificationListener<ScrollNotification>(
                              onNotification: (ScrollNotification scrollInfo) {
                                if (!controller.loadingMorePost &&
                                    scrollInfo.metrics.pixels >
                                        scrollInfo.metrics.maxScrollExtent *
                                            0.7) {
                                  controller.loadMore();
                                }
                                return true;
                              },
                              child: ListView(
                                padding: const EdgeInsets.all(8),
                                children: [
                                  if (!controller.loadingPosts) ...[
                                    if (controller.listProducts.isNotEmpty) ...[
                                      for (var i = 0;
                                          i < _.listProducts.length;
                                          i++) ...[
                                        buildPosts(
                                            i, _.listProducts[i], context),
                                      ]
                                    ] else ...[
                                      Center(
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.center,
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            const SizedBox(height: 50),
                                            Container(
                                              height: 180,
                                              width: 180,
                                              padding: EdgeInsets.all(8),
                                              child: SvgPicture.asset(
                                                  "assets/icons/mobile_search.svg"),
                                            ),
                                            const SizedBox(height: 14),
                                            const Text(
                                              "حاليا لا توجد منشورات في هذا التصنيف",
                                              style: TextStyle(
                                                  fontWeight: FontWeight.w600,
                                                  fontSize: 18,
                                                  color: Config.primaryColor),
                                            ),
                                          ],
                                        ),
                                      )
                                    ]
                                  ] else ...[
                                    const ShimmerWidget(),
                                  ],
                                  controller.loadingMorePost
                                      ? const ShimmerWidget()
                                      : const SizedBox(),
                                ],
                              ),
                            )
                          : const Center(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  SizedBox(height: 48),
                                  Icon(Icons.queue_music_sharp,
                                      color: Config.primaryColor, size: 68),
                                  SizedBox(height: 14),
                                  Text(
                                    "لا توجد ملصقات صوتية حاليا",
                                    style: TextStyle(
                                        fontWeight: FontWeight.w600,
                                        fontSize: 18,
                                        color: Config.primaryColor),
                                  ),
                                ],
                              ),
                            );
                }),
                Align(
                  alignment: Alignment.bottomCenter,
                  child: GetBuilder<AudioController>(builder: (context) {
                    return controller.loadingMorePost
                        ? Padding(
                            padding: const EdgeInsets.all(20),
                            child: CircularProgressIndicator(
                              color: Config.primaryColor,
                            ),
                          )
                        : const SizedBox();
                  }),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget buildPosts(int index, Post post, context) {
    final difference = controller.now.difference(post.createdAt!);
    final ago = timeago
        .format(controller.now.subtract(difference), locale: "en_short")
        .replaceAll("m", " دقيقة ")
        .replaceAll("h", " ساعة ")
        .replaceAll("d", " يوم ")
        .replaceAll("mo", " شهر ");

    return Padding(
      padding: const EdgeInsets.all(4),
      child: Container(
        decoration: BoxDecoration(
            color: Colors.white, borderRadius: BorderRadius.circular(4)),
        child: Padding(
          padding: const EdgeInsets.all(4),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ListTile(
                dense: true,
                contentPadding: EdgeInsets.all(4),
                title: Column(
                  children: [
                    Row(
                      children: [
                        Flexible(
                          child: Text(
                            post.user?.username ?? "",
                            maxLines: 2,
                            overflow: TextOverflow.fade,
                            style: const TextStyle(
                                fontSize: 16, fontWeight: FontWeight.w600),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
                subtitle: Text(ago, style: const TextStyle(fontSize: 14)),
                leading: CircleAvatar(
                  backgroundColor: Colors.grey.shade100,
                  child: post.user?.photo != null
                      ? CachedNetworkImage(
                          imageUrl: resolveImageUrl(post.user!.photo!),
                          imageBuilder: (context, imageProvider) => Container(
                            width: 100,
                            height: 100,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(50),
                              image: DecorationImage(
                                  image: imageProvider, fit: BoxFit.cover),
                            ),
                          ),
                          placeholder: (context, url) => SizedBox(
                            height: 100,
                            width: 100,
                            child: Shimmer.fromColors(
                                enabled: true,
                                baseColor: Colors.grey.shade300,
                                highlightColor: Colors.grey.shade50,
                                child: Container(
                                  height: 90,
                                  width: 90,
                                  decoration: BoxDecoration(
                                      color: Colors.grey[300],
                                      borderRadius: BorderRadius.circular(50)),
                                )),
                          ),
                          errorWidget: (context, url, error) => Container(
                              height: 90,
                              width: 90,
                              decoration: BoxDecoration(
                                  color: Colors.grey[300],
                                  borderRadius: BorderRadius.circular(50)),
                              child: const Center(
                                child: Icon(Icons.error_outline,
                                    color: Colors.white, size: 35),
                              )),
                        )
                      : Container(
                          width: 100,
                          height: 100,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(50),
                            image: const DecorationImage(
                                image: AssetImage("assets/avatar/1.jpg"),
                                fit: BoxFit.cover),
                          ),
                        ),
                ),
                trailing: post.downloadProgress == null ||
                        post.downloadProgress == 0 ||
                        post.downloadProgress == 1
                    ? IconButton(
                        onPressed: () {
                          controller.share(post, index);
                        },
                        icon: Icon(Icons.share))
                    : SizedBox(
                        height: 20,
                        width: 20,
                        child: CircularProgressIndicator(
                            value: post.downloadProgress),
                      ),
              ),

              Row(
                children: [
                  const Icon(Icons.music_note_outlined,
                      color: Config.primaryColor),
                  const SizedBox(width: 4),
                  Expanded(
                    child: Text(
                      post.title ?? "",
                      maxLines: 4,
                      overflow: TextOverflow.fade,
                      style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w700,
                          color: Config.primaryColor),
                    ),
                  ),
                ],
              ),
              const Divider(height: 16),
              controller.playerState == PlayerState.playing &&
                      index == controller.selectedAudioIndex
                  ? Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            controller.playerPosition != null
                                ? '${controller.positionText}'
                                : '',
                            style: const TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w600,
                                color: Colors.grey),
                          ),
                          Text(
                            controller.playerDuration != null
                                ? controller.durationText
                                : '',
                            style: const TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w600,
                                color: Colors.grey),
                          ),
                        ],
                      ),
                    )
                  : const SizedBox(),
              Slider(
                onChanged: (value) {
                  final duration = controller.playerDuration;
                  if (duration == null) {
                    return;
                  }
                  final position = value * duration.inMilliseconds;
                  controller.player
                      .seek(Duration(milliseconds: position.round()));
                  controller.update();
                },
                value: controller.calculateProgress(index),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  // InkWell(
                  //   onTap: () {
                  //     controller.isPlaying ? controller.pause : null;
                  //   },
                  //   child: SvgPicture.asset(
                  //     "assets/icons/pause.svg",
                  //     colorFilter:
                  //         const ColorFilter.mode(Colors.grey, BlendMode.srcIn),
                  //     height: 38,
                  //   ),
                  // ),
                  InkWell(
                    onTap: () {
                      controller.isPlaying &&
                              index == controller.selectedAudioIndex
                          ? controller.pause()
                          : controller.playAudio(post, index);
                    },
                    child: controller.loading &&
                            index == controller.selectedAudioIndex
                        ? const SizedBox(
                            height: 30,
                            width: 30,
                            child: CircularProgressIndicator(strokeWidth: 2),
                          )
                        : SvgPicture.asset(
                            index == controller.selectedAudioIndex &&
                                    controller.isPlaying
                                ? "assets/icons/pause.svg"
                                : "assets/icons/play_circle.svg",
                            colorFilter: const ColorFilter.mode(
                                Config.primaryColor, BlendMode.srcIn),
                            height: 38,
                          ),
                  ),
                  InkWell(
                    onTap: () {
                      controller.isPlaying || controller.isPaused
                          ? controller.stop()
                          : null;
                    },
                    child: SvgPicture.asset(
                      "assets/icons/stop.svg",
                      colorFilter:
                          const ColorFilter.mode(Colors.grey, BlendMode.srcIn),
                      height: 38,
                    ),
                  ),
                ],
              ),

              // IntrinsicHeight(
              //   child: Row(
              //     mainAxisAlignment: MainAxisAlignment.spaceAround,
              //     children: [
              //       InkWell(
              //         onTap: () {
              //           controller.getPostComments(post.id!);
              //           manageComments(post);
              //         },
              //         child: Row(
              //           children: [
              //             const Icon(Icons.comment_outlined, size: 16),
              //             const SizedBox(width: 4),
              //             Text("التعليقات"),
              //             post.comments_count! > 0
              //                 ? Text(
              //                     " (${post.comments_count})",
              //                     style: const TextStyle(
              //                         fontWeight: FontWeight.w600),
              //                   )
              //                 : const SizedBox()
              //           ],
              //         ),
              //       ),
              //       const VerticalDivider(),
              //       InkWell(
              //         onTap: () {
              //           displayProfile(post.user!);
              //         },
              //         child: const Row(
              //           children: [
              //             Icon(Icons.call_outlined, size: 16),
              //             SizedBox(width: 4),
              //             Text("تواصل"),
              //           ],
              //         ),
              //       ),
              //       // const VerticalDivider(),
              //       // InkWell(
              //       //   onTap: () {},
              //       //   child: const Row(
              //       //     children: [
              //       //       Icon(Icons.do_disturb_alt_outlined, size: 16),
              //       //       SizedBox(width: 4),
              //       //       Text("تبليغ"),
              //       //     ],
              //       //   ),
              //       // ),
              //     ],
              //   ),
              // ),
              // const SizedBox(height: 4)
            ],
          ),
        ),
      ),
    );
  }

  Widget buildSection(int index, Section section, context) {
    return InkWell(
      onTap: () {
        controller.selectSection(section.id);
      },
      child: Padding(
        padding: const EdgeInsets.all(4.0),
        child: Column(
          children: [
            Container(
              padding: const EdgeInsets.fromLTRB(4, 0, 4, 0),
              height: 40,
              // width: 100,
              decoration: BoxDecoration(
                color: controller.postFilter.sectionId == section.id
                    ? Config.primaryColor
                    : Colors.white,
                borderRadius: BorderRadius.circular(8),
                // border: Border.all(
                //     width: 1, color: Config.primaryColor.withOpacity(0.4)),
              ),
              child: Center(
                  child: Row(
                children: [
                  if (section.photo != null)
                    Container(
                      height: 32,
                      width: 32,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8),
                        image: section.id == null
                            ? DecorationImage(image: AssetImage(section.photo!))
                            : resolveImage(section.photo),
                      ),
                    ),
                  const SizedBox(width: 4),
                  Text(
                    section.name ?? "",
                    style: TextStyle(
                        color: controller.postFilter.sectionId == section.id
                            ? Colors.white
                            : Colors.grey.shade700,
                        fontSize: 16,
                        fontWeight:
                            controller.postFilter.sectionId == section.id
                                ? FontWeight.w600
                                : FontWeight.w500),
                  ),
                ],
              )),
            ),
          ],
        ),
      ),
    );
  }
}
