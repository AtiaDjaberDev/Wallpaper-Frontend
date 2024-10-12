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
import 'package:wallpaper_app/pages/client/favorite/favorite_controller.dart';
import 'package:wallpaper_app/routes/app_routes.dart';

class FavoriteView extends StatelessWidget {
  final controller = Get.put(FavoriteController());

  FavoriteView({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Directionality(
        textDirection: TextDirection.rtl,
        child: Scaffold(
          backgroundColor: Config.backgroundColor,
          appBar: AppBar(
            elevation: 1,
            backgroundColor: Config.backgroundColor,
            title:
                Text("المفضلة", style: Theme.of(context).textTheme.titleLarge),
          ),
          body: NestedScrollView(
            headerSliverBuilder: (context, val) => [],
            body: Stack(
              children: [
                GetBuilder<FavoriteController>(builder: (_) {
                  return controller.loadingPosts
                      ? const ShimmerWidget()
                      : controller.listProducts.isNotEmpty
                          ? GridView(
                              gridDelegate:
                                  SliverGridDelegateWithFixedCrossAxisCount(
                                      childAspectRatio: 1, crossAxisCount: 2),
                              padding: const EdgeInsets.all(8),
                              children: [
                                if (!controller.loadingPosts) ...[
                                  if (controller.listProducts.isNotEmpty) ...[
                                    for (var i = 0;
                                        i < _.listProducts.length;
                                        i++) ...[
                                      buildPosts(i, _.listProducts[i], context),
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
                            )
                          : const Center(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  SizedBox(height: 48),
                                  Icon(Icons.favorite,
                                      color: Config.primaryColor, size: 68),
                                  SizedBox(height: 14),
                                  Text(
                                    "لا توجد صور مفضلة حاليا",
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
                  child: GetBuilder<FavoriteController>(builder: (context) {
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
    return Padding(
      padding: const EdgeInsets.all(4),
      child: InkWell(
        onTap: () {
          Get.toNamed(AppRoutes.post, arguments: post);
        },
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12),
            border: Border.all(
                width: 0.5, color: const Color.fromARGB(255, 100, 100, 100)),
            image: DecorationImage(
                image: NetworkImage(
                  resolveImageUrl(post.photo!),
                ),
                fit: BoxFit.fill),
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
