import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:glass_kit/glass_kit.dart';
import 'package:wallpaper_app/constants_dashboard.dart';
import 'package:wallpaper_app/core/helper/helper_function.dart';
import 'package:wallpaper_app/pages/client/detail_post/detail_controller.dart';

class DetailView extends StatelessWidget {
  final controller = Get.put(DetailController());

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Directionality(
        textDirection: TextDirection.rtl,
        child: Scaffold(
            body: Stack(
          children: [
            ClipRRect(
              child: ImageFiltered(
                imageFilter: ImageFilter.blur(sigmaX: 12, sigmaY: 12),
                child: Container(
                  decoration: BoxDecoration(
                      image: DecorationImage(
                          image: NetworkImage(
                            resolveImageUrl(controller.post.photo!),
                          ),
                          fit: BoxFit.cover)),
                ),
              ),
            ),
            Center(
              child: AspectRatio(
                aspectRatio: 1,
                child: Container(
                  decoration: BoxDecoration(
                      image: DecorationImage(
                          image: NetworkImage(
                            resolveImageUrl(controller.post.photo!),
                          ),
                          fit: BoxFit.contain)),
                ),
              ),
            ),
            Positioned(
              top: defaultPadding,
              child: MaterialButton(
                onPressed: () {
                  Get.back();
                },
                elevation: 1,
                height: 47,
                color: Colors.white,
                shape: const CircleBorder(),
                child: Icon(Icons.arrow_back_sharp),
              ),
            ),
            // Positioned(
            //   top: defaultPadding,
            //   left: 0,
            //   child: MaterialButton(
            //     onPressed: () {
            //       Get.back();
            //     },
            //     elevation: 1,
            //     height: 47,
            //     color: Colors.white,
            //     shape: const CircleBorder(),
            //     child: Icon(
            //       Icons.favorite,
            //       color: Colors.red,
            //     ),
            //   ),
            // ),
            Positioned(
                bottom: 20,
                right: 15,
                left: 15,
                child: GlassContainer(
                  height: 65,
                  width: 310,
                  gradient: LinearGradient(
                    colors: [
                      Colors.white.withOpacity(0.10),
                      Colors.white.withOpacity(0.10)
                    ],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                  borderGradient: LinearGradient(
                    colors: [
                      Colors.white.withOpacity(0.60),
                      Colors.white.withOpacity(0.10),
                      Colors.white.withOpacity(0.05),
                      Colors.white.withOpacity(0.6)
                    ],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    stops: [0.0, 0.39, 0.40, 1.0],
                  ),
                  blur: 2.0,
                  borderWidth: 1.5,
                  elevation: 3.0,
                  borderRadius: BorderRadius.circular(12),
                  isFrostedGlass: true,
                  shadowColor: Colors.black.withOpacity(0.20),
                  alignment: Alignment.center,
                  frostedOpacity: 0.12,
                  margin: EdgeInsets.all(8.0),
                  padding: EdgeInsets.all(8.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      MaterialButton(
                        onPressed: () {
                          final favoriteList =
                              controller.helperService.favoriteList;

                          if (controller.helperService.favoriteList
                              .contains(controller.post.id)) {
                            controller.helperService.favoriteList
                                .remove(controller.post.id!);
                          } else {
                            controller.helperService.favoriteList.addIf(
                                !(favoriteList.any((element) =>
                                    element == controller.post.id)),
                                controller.post.id!);
                          }

                          controller.helperService
                              .writeIntList('FavoriteList', favoriteList);
                          controller.update();
                        },
                        elevation: 1,
                        height: 47,
                        color: Colors.white,
                        shape: const CircleBorder(),
                        child: GetBuilder<DetailController>(builder: (_) {
                          return Icon(
                              controller.helperService.favoriteList
                                      .contains(controller.post.id)
                                  ? Icons.favorite
                                  : Icons.favorite_border,
                              color: controller.helperService.favoriteList
                                      .contains(controller.post.id)
                                  ? Colors.red
                                  : Colors.black);
                        }),
                      ),
                      GetBuilder<DetailController>(builder: (context) {
                        return MaterialButton(
                          onPressed: () {
                            controller.download(controller.post);
                          },
                          elevation: 1,
                          height: 47,
                          color: Colors.white,
                          shape: const CircleBorder(),
                          child: controller.post.downloadProgress == null ||
                                  controller.post.downloadProgress == 0 ||
                                  controller.post.downloadProgress == 1
                              ? const Icon(Icons.file_download_outlined)
                              : SizedBox(
                                  height: 30,
                                  width: 30,
                                  child: CircularProgressIndicator(
                                      value: controller.post.downloadProgress),
                                ),
                        );
                      }),

                      // ElevatedButton.icon(
                      //   style: ButtonStyle(
                      //       //  backgroundColor:
                      //       //     WidgetStatePropertyAll(Colors.white),
                      //       fixedSize:
                      //           WidgetStatePropertyAll(Size.fromHeight(47)),
                      //       shape:
                      //           WidgetStateProperty.all<RoundedRectangleBorder>(
                      //               RoundedRectangleBorder(
                      //         borderRadius: BorderRadius.circular(20),
                      //       ))),
                      //   onPressed: () {},
                      //   label: Text("تعيين كخلفية",
                      //       style: TextStyle(fontWeight: FontWeight.w700)),
                      // ),

                      GetBuilder<DetailController>(builder: (_) {
                        return MaterialButton(
                          onPressed: () {
                            controller.share(controller.post);
                          },
                          elevation: 1,
                          height: 47,
                          color: Colors.white,
                          shape: const CircleBorder(),
                          child: controller.post.shareProgress == null ||
                                  controller.post.shareProgress == 0 ||
                                  controller.post.shareProgress == 1
                              ? const Icon(Icons.share)
                              : SizedBox(
                                  height: 30,
                                  width: 30,
                                  child: CircularProgressIndicator(
                                      value: controller.post.shareProgress),
                                ),
                        );
                      }),
                      // Container(
                      //   height: 30,
                      //   width: 30,
                      //   decoration: BoxDecoration(
                      //       color: Colors.white, shape: BoxShape.circle),
                      // )
                    ],
                  ),
                ))
          ],
        )),
      ),
    );
  }
}
