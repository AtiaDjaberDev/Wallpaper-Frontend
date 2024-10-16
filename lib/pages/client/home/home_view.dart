import 'dart:io';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:wallpaper_app/constants_dashboard.dart';
import 'package:wallpaper_app/core/widget/shimmer_widget.dart';
import 'package:wallpaper_app/models/comment.dart';
import 'package:timeago/timeago.dart' as timeago;
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:wallpaper_app/core/config.dart';
import 'package:wallpaper_app/core/helper/helper_function.dart';
import 'package:wallpaper_app/core/widget/client/custom_drawer.dart';
import 'package:wallpaper_app/core/widget/confirm_dialog.dart';
import 'package:wallpaper_app/models/post.dart';
import 'package:wallpaper_app/pages/client/home/home_controller.dart';
import 'package:wallpaper_app/models/category.dart';
import 'package:wallpaper_app/routes/app_routes.dart';
import 'package:shimmer/shimmer.dart';
import 'dart:math' as math;

import 'package:url_launcher/url_launcher.dart';
import 'package:url_launcher/url_launcher_string.dart';

class HomeView extends StatelessWidget {
  final controller = Get.put(HomeController());

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(
      SystemUiOverlayStyle.light.copyWith(
          statusBarColor: Config.backgroundColor,
          systemNavigationBarColor: Colors.white,
          systemNavigationBarIconBrightness: Brightness.dark),
    );
    return SafeArea(
        child: Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        drawer: CustomDrawer(),
        appBar: AppBar(
          elevation: 0,
          backgroundColor: Config.backgroundColor,
          title: Text(Config.nameApp,
              style: Theme.of(context).textTheme.titleLarge),
          // actions: [
          //   InkWell(
          //       onTap: () {},
          //       child: Icon(Icons.search, color: Colors.white, size: 24)),
          //   const SizedBox(width: defaultPadding)
          // ],
        ),
        body: WillPopScope(
          onWillPop: () async {
            Get.back();
            var res = await showConfirmDialog("هل تريد الخروج من التطبيق ؟");
            if (res) {
              exit(0);
            }
            return res;
          },
          child: LayoutBuilder(builder: (context, constraints) {
            return NestedScrollView(
              headerSliverBuilder: (_, val) => [
                GetBuilder<HomeController>(builder: (_) {
                  return SliverAppBar(
                    expandedHeight:
                        controller.listCarousels.isNotEmpty ? 140 : 0,
                    titleSpacing: 0,
                    toolbarHeight: 0,
                    backgroundColor: Config.backgroundColor,
                    leading: null,
                    automaticallyImplyLeading: false,
                    flexibleSpace: FlexibleSpaceBar(
                      background: controller.listCarousels.isNotEmpty
                          ? Padding(
                              padding: const EdgeInsets.symmetric(vertical: 8),
                              child: carouselWidget(),
                            )
                          : const SizedBox(),
                    ),
                  );
                }),
                // SliverPersistentHeader(
                //   pinned: true,
                //   floating: true,
                //   delegate: MySliverPersistentHeaderDelegate(
                //     minHeight: 65,
                //     maxHeight: 65,
                //     child: Row(
                //       children: [
                //         Expanded(
                //           child: Padding(
                //             padding: const EdgeInsets.all(8.0),
                //             child: TextFormField(
                //               controller: controller.titleEditingController,
                //               decoration: InputDecoration(
                //                   border: OutlineInputBorder(
                //                     borderRadius: BorderRadius.circular(14),
                //                     borderSide: BorderSide(
                //                         color:
                //                             const Color.fromARGB(255, 2, 2, 2),
                //                         width: 2),
                //                   ),
                //                   focusedBorder: OutlineInputBorder(
                //                     borderRadius: BorderRadius.circular(14),
                //                     borderSide: BorderSide(
                //                         color: Color.fromARGB(255, 99, 99, 99),
                //                         width: 2),
                //                   ),
                //                   enabledBorder: OutlineInputBorder(
                //                     borderRadius: BorderRadius.circular(14),
                //                     borderSide: BorderSide(
                //                         color:
                //                             const Color.fromARGB(255, 0, 0, 0),
                //                         width: 1.5),
                //                   ),
                //                   filled: true,
                //                   hintStyle: TextStyle(
                //                       color: const Color.fromARGB(
                //                           255, 181, 181, 181)),
                //                   hintText: "بحث  ...",
                //                   fillColor: Color.fromARGB(255, 45, 45, 45),
                //                   prefixIcon: const Icon(
                //                     Icons.search,
                //                     color: Colors.white,
                //                   )),
                //             ),
                //           ),
                //         ),
                //         const SizedBox(width: defaultPadding / 2),
                //         ElevatedButton(
                //             style: ButtonStyle(
                //                 fixedSize: WidgetStatePropertyAll(Size(40, 47)),
                //                 backgroundColor:
                //                     WidgetStatePropertyAll(Config.primaryColor),
                //                 shape: WidgetStateProperty.all<
                //                         RoundedRectangleBorder>(
                //                     RoundedRectangleBorder(
                //                   borderRadius: BorderRadius.circular(14),
                //                 ))),
                //             onPressed: () {
                //               if (controller
                //                   .titleEditingController.text.isNotEmpty) {
                //                 Get.toNamed(AppRoutes.audios, arguments: {
                //                   "query":
                //                       controller.titleEditingController.text
                //                 });
                //                 controller.titleEditingController.clear();
                //               }
                //             },
                //             child: Icon(Icons.search)),
                //         const SizedBox(width: defaultPadding / 2),
                //       ],
                //     ),
                //   ),
                // ),
              ],
              body: Stack(
                children: [
                  Container(
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        colors: [
                          Config.backgroundColor,
                          Config.backgroundColor,
                          Config.backgroundColor,
                          Color.fromARGB(50, 47, 41, 50),
                          Color.fromARGB(49, 47, 47, 47).withOpacity(0.4),
                          Color.fromARGB(255, 38, 38, 38),
                          Color.fromARGB(255, 86, 67, 26).withOpacity(0.1),
                        ],
                        begin: Alignment.topCenter,
                        end: Alignment.bottomRight,
                      ),
                    ),
                  ),
                  GetBuilder<HomeController>(
                    builder: (_) => Padding(
                      padding: EdgeInsets.symmetric(
                          horizontal: 8,
                          vertical:
                              constraints.maxWidth > 500 ? 50 : defaultPadding),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Text(
                                  "التصنيفات",
                                  style: Theme.of(context)
                                      .textTheme
                                      .titleMedium
                                      ?.copyWith(color: Colors.white),
                                ),
                                const Row(
                                  children: [
                                    Text(
                                      "مشاهدة الكل",
                                    ),
                                    SizedBox(width: 4),
                                    Icon(
                                      Icons.arrow_forward_ios_outlined,
                                      color: Config.textColor,
                                      size: 14,
                                    ),
                                  ],
                                )
                              ],
                            ),
                          ),
                          Expanded(
                            child: GetBuilder<HomeController>(builder: (_) {
                              return controller.loadingRelatedData
                                  ? const ShimmerWidget()
                                  : ListView.builder(
                                      scrollDirection: Axis.vertical,
                                      itemCount:
                                          controller.listCategories.length,
                                      itemBuilder: (context, index) {
                                        Category category =
                                            controller.listCategories[index];
                                        return Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            const SizedBox(
                                                height: defaultPadding),
                                            Padding(
                                              padding: const EdgeInsets.all(4),
                                              child: Container(
                                                padding: EdgeInsets.symmetric(
                                                    horizontal: 8, vertical: 2),
                                                // decoration: BoxDecoration(
                                                //     borderRadius:
                                                //         BorderRadius.circular(20),
                                                //     border: Border.all(
                                                //         color: Config.primaryColor)),
                                                child: Text(
                                                  category.name ?? "",
                                                  textAlign: TextAlign.center,
                                                  style: const TextStyle(
                                                      color:
                                                          Config.primaryColor),
                                                ),
                                              ),
                                            ),
                                            SizedBox(
                                              height: 120,
                                              child: ListView.builder(
                                                shrinkWrap: true,
                                                scrollDirection:
                                                    Axis.horizontal,
                                                itemCount:
                                                    category.posts.length,
                                                itemBuilder: (context, index) {
                                                  Post post =
                                                      category.posts[index];
                                                  return Padding(
                                                    padding:
                                                        const EdgeInsets.all(4),
                                                    child: InkWell(
                                                      onTap: () {
                                                        Get.toNamed(
                                                            AppRoutes.post,
                                                            arguments: post);
                                                      },
                                                      child: Container(
                                                        width: 120,
                                                        decoration:
                                                            BoxDecoration(
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(12),
                                                          border: Border.all(
                                                              width: 0.5,
                                                              color: const Color
                                                                  .fromARGB(
                                                                  255,
                                                                  100,
                                                                  100,
                                                                  100)),
                                                          image: DecorationImage(
                                                              image: NetworkImage(
                                                                resolveImageUrl(
                                                                    post.photo!),
                                                              ),
                                                              fit: BoxFit.fill),
                                                        ),
                                                      ),
                                                    ),
                                                  );
                                                },
                                              ),
                                            )
                                          ],
                                        );
                                      },
                                    );
                            }),
                          ),
                          // SizedBox(
                          //   child: Container(
                          //       child: GridView.builder(
                          //     shrinkWrap: true,
                          //     itemCount: controller.listCategories.length,
                          //     gridDelegate:
                          //         const SliverGridDelegateWithFixedCrossAxisCount(
                          //             mainAxisSpacing: 12,
                          //             crossAxisSpacing: 12,
                          //             childAspectRatio: 0.8,
                          //             crossAxisCount: 3),
                          //     itemBuilder: (context, index) {
                          //       Category category =
                          //           controller.listCategories[index];
                          //       return InkWell(
                          //         onTap: () {
                          //           Get.toNamed(AppRoutes.audios,
                          //               arguments: {"category": category});
                          //         },
                          //         child: Stack(
                          //           children: [
                          //             Container(
                          //               decoration: BoxDecoration(
                          //                 borderRadius:
                          //                     BorderRadius.circular(defaultPadding),
                          //                 border: Border.all(
                          //                     width: 2,
                          //                     color: Config.primaryColor
                          //                         .withAlpha(50)),
                          //                 image: DecorationImage(
                          //                     image: NetworkImage(
                          //                       resolveImageUrl(category.photo!),
                          //                     ),
                          //                     fit: BoxFit.fill),
                          //               ),
                          //             ),
                          //             Container(
                          //               decoration: BoxDecoration(
                          //                   borderRadius: BorderRadius.circular(6),
                          //                   color: Colors.black.withOpacity(0.3)),
                          //             ),
                          //             Align(
                          //               child: Padding(
                          //                 padding: const EdgeInsets.all(4),
                          //                 child: Text(
                          //                   category.name ?? "",
                          //                   textAlign: TextAlign.center,
                          //                   style: const TextStyle(
                          //                       color: Colors.white,
                          //                       fontSize: 16,
                          //                       fontWeight: FontWeight.bold),
                          //                 ),
                          //               ),
                          //             )
                          //           ],
                          //         ),
                          //       );
                          //     },
                          //   )),
                          // ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            );
          }),
        ),
        // floatingActionButton: FloatingActionButton.extended(
        //   onPressed: () {
        //     Get.toNamed(AppRoutes.addPost);
        //   },
        //   icon: const Icon(Icons.music_note_outlined),
        //   backgroundColor: Config.primaryColor.withOpacity(0.9),
        //   label: const Text(
        //     "إضافة مقطع",
        //     style: TextStyle(fontWeight: FontWeight.w700),
        //   ),
        // ),
      ),
    ));
  }

  Widget carouselWidget() {
    return !controller.loadingRelatedData && controller.listCarousels.isNotEmpty
        ? CarouselSlider(
            items: [
                ...controller.listCarousels.map(
                  (carousel) => InkWell(
                    onTap: () {
                      if (carousel.target != null) {
                        launchUrl(Uri.parse(carousel.target!),
                            mode: LaunchMode.externalApplication);
                      }
                    },
                    child: CachedNetworkImage(
                      imageUrl: resolveImageUrl(carousel.photo!),
                      imageBuilder: (context, imageProvider) => Container(
                        // width: 400.0,
                        // height: 150.0,
                        decoration: BoxDecoration(
                          // boxShadow: [
                          //   BoxShadow(
                          //       color: Config.primaryColor.withOpacity(0.3),
                          //       offset: const Offset(0.2, 0.2),
                          //       blurRadius: 8)
                          // ],
                          borderRadius: BorderRadius.circular(8.0),
                          image: DecorationImage(
                              image: imageProvider, fit: BoxFit.cover),
                        ),
                      ),
                      placeholder: (context, url) => SizedBox(
                        height: 90,
                        width: 90,
                        child: Shimmer.fromColors(
                            enabled: true,
                            baseColor: Colors.grey.shade300,
                            highlightColor: Colors.grey.shade50,
                            child: const SizedBox(height: 90, width: 90)),
                      ),
                      errorWidget: (context, url, error) => Container(
                          height: 90,
                          width: 90,
                          decoration: BoxDecoration(
                              color: Colors.grey[300],
                              borderRadius: BorderRadius.circular(8)),
                          child: const Center(
                            child: Icon(Icons.error_outline,
                                color: Colors.white, size: 35),
                          )),
                    ),
                  ),
                )
              ],
            options: CarouselOptions(
              height: 140,
              aspectRatio: 16 / 9,
              viewportFraction: 0.8,
              initialPage: 0,
              enableInfiniteScroll: true,
              reverse: false,
              autoPlay: true,
              autoPlayInterval: const Duration(seconds: 3),
              autoPlayAnimationDuration: const Duration(milliseconds: 800),
              autoPlayCurve: Curves.fastOutSlowIn,
              enlargeCenterPage: true,
              enlargeFactor: 0.3,
              scrollDirection: Axis.horizontal,
            ))
        : const SizedBox();
  }

  Widget buildCategories(int index, Category category, context) {
    return InkWell(
      onTap: () {
        controller.selectCategory(category.id);
        // Get.to(() => AddPostView());
      },
      child: Padding(
        padding: const EdgeInsets.all(4.0),
        child: Column(
          children: [
            Container(
              padding: const EdgeInsets.fromLTRB(10, 2, 10, 2),
              height: 40,
              // width: 100,
              decoration: BoxDecoration(
                color: controller.postFilter.categoryId == category.id
                    ? Config.primaryColor
                    : Colors.white,
                borderRadius: BorderRadius.circular(8),
                border: Border.all(
                    width: 1, color: Config.primaryColor.withOpacity(0.4)),
              ),
              child: Center(
                  child: Row(
                children: [
                  Container(
                    height: 25,
                    width: 25,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8),
                      image: category.id == null
                          ? DecorationImage(image: AssetImage(category.photo!))
                          : resolveImage(category.photo),
                    ),
                  ),
                  const SizedBox(width: 4),
                  Text(
                    category.name ?? "",
                    style: TextStyle(
                        color: controller.postFilter.categoryId == category.id
                            ? Colors.white
                            : Colors.grey.shade700,
                        fontSize: 16,
                        fontWeight:
                            controller.postFilter.categoryId == category.id
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

class CommentHeader extends StatelessWidget {
  const CommentHeader({
    super.key,
    required this.commentNumber,
  });

  final int commentNumber;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        const Icon(Icons.comment_outlined,
            size: 16, color: Config.primaryColor),
        const SizedBox(width: 4),
        Text(
          "التعليقات" + " (${commentNumber})",
          style: const TextStyle(
              color: Config.primaryColor,
              fontSize: 16,
              fontWeight: FontWeight.w600),
        ),
      ],
    );
  }
}

class CommentCard extends StatelessWidget {
  const CommentCard(
      {super.key, required this.comment, required this.ago, this.onDelete});

  final Comment comment;
  final String ago;
  final Function? onDelete;
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        ListTile(
          dense: true,
          contentPadding: EdgeInsets.all(0),
          title: Row(
            children: [
              Flexible(
                child: Text(
                  comment.user?.username ?? "",
                  maxLines: 2,
                  overflow: TextOverflow.fade,
                  style: const TextStyle(
                      fontSize: 15, fontWeight: FontWeight.bold),
                ),
              ),
            ],
          ),
          subtitle: Row(
            children: [
              Text(
                ago,
                style: const TextStyle(
                    fontWeight: FontWeight.w600,
                    color: isDashboard ? Colors.grey : bgColor),
              ),
            ],
          ),
          leading: CircleAvatar(
            child: comment.user?.photo != null
                ? CachedNetworkImage(
                    imageUrl: resolveImageUrl(comment.user!.photo!),
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
                        child: Center(
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
          trailing: isDashboard
              ? InkWell(
                  child: IconButton(
                      onPressed: () {
                        onDelete?.call();
                      },
                      icon: const Icon(Icons.delete, color: Colors.red)),
                )
              : const SizedBox(),
        ),
        Text(
          comment.text ?? "",
          overflow: TextOverflow.fade,
          style: const TextStyle(
            fontSize: 14,
          ),
        ),
        const Divider()
      ],
    );
  }
}

class MySliverPersistentHeaderDelegate extends SliverPersistentHeaderDelegate {
  MySliverPersistentHeaderDelegate(
      {required this.minHeight, required this.maxHeight, required this.child});
  final double minHeight;
  final double maxHeight;
  final Widget child;

  @override
  double get minExtent => minHeight;

  @override
  double get maxExtent => math.max(maxHeight, minHeight);

  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
    return Container(
      color: Config.backgroundColor,
      child: SizedBox.expand(child: child),
    );
  }

  @override
  bool shouldRebuild(MySliverPersistentHeaderDelegate oldDelegate) {
    return maxHeight != oldDelegate.maxHeight ||
        minHeight != oldDelegate.minHeight ||
        child != oldDelegate.child;
  }
}
