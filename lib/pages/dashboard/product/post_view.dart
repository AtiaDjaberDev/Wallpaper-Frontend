import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:wallpaper_app/core/config.dart';
import 'package:wallpaper_app/core/helper/helper_function.dart';
import 'package:wallpaper_app/core/widget/chip_widget.dart';
import 'package:wallpaper_app/core/widget/label_form.dart';
import 'package:wallpaper_app/core/widget/upload_file_widget.dart';
import 'package:get/get.dart';
import 'package:wallpaper_app/constants_dashboard.dart';
import 'package:wallpaper_app/core/widget/custom_dialog.dart';
import 'package:wallpaper_app/core/widget/dashboard/custom_table.dart';
import 'package:wallpaper_app/core/widget/dashboard/header.dart';
import 'package:wallpaper_app/core/widget/dashboard/side_menu.dart';
import 'package:wallpaper_app/models/category.dart' as category;
import 'package:timeago/timeago.dart' as timeago;

import 'package:wallpaper_app/models/comment.dart';
import 'package:wallpaper_app/models/post.dart';
import 'package:wallpaper_app/pages/dashboard/product/post_controller.dart';
import 'package:wallpaper_app/responsive.dart';
import 'package:responsive_table/responsive_table.dart';

class PostView extends StatelessWidget {
  var controller = Get.put(PostController());

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        key: controller.helperService.productScaffoldKey,
        drawer: SideMenu(),
        body: SafeArea(
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // We want this side menu only for large screen
              if (Responsive.isDesktop(context))
                Expanded(
                  // default flex = 1
                  // and it takes 1/6 part of the screen
                  child: SideMenu(),
                ),
              Expanded(
                // It takes 5/6 part of the screen
                flex: 5,
                child: SingleChildScrollView(
                  primary: false,
                  padding: const EdgeInsets.all(defaultPadding),
                  child: Column(
                    children: [
                      const Header(),
                      const SizedBox(height: defaultPadding),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Expanded(
                            flex: 5,
                            child: Column(
                              children: [
                                const SizedBox(height: defaultPadding),
                                GetBuilder<PostController>(builder: (_) {
                                  return CustomTable(
                                    "المنشورات",
                                    controller.headers,
                                    leading: [
                                      // DatatableHeader(
                                      //   text: "الصورة",
                                      //   value: "الصورة",
                                      //   show: true,
                                      //   sortable: false,
                                      //   sourceBuilder: (value, row) {
                                      //     return Row(
                                      //       mainAxisAlignment:
                                      //           MainAxisAlignment.center,
                                      //       children: [
                                      //         Container(
                                      //           height: 60,
                                      //           width: 60,
                                      //           decoration: BoxDecoration(
                                      //             color: secondaryColor,
                                      //             borderRadius:
                                      //                 BorderRadius.circular(8),
                                      //             image: resolveImage(
                                      //                 row["photo"]),
                                      //           ),
                                      //         ),
                                      //       ],
                                      //     );
                                      //   },
                                      // ),
                                      DatatableHeader(
                                        text: "المستخدم",
                                        value: "user_id",
                                        sourceBuilder: (value, row) {
                                          return Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.start,
                                            children: [
                                              row["user"]["photo"] == null
                                                  ? const SizedBox()
                                                  : Container(
                                                      height: 35,
                                                      width: 35,
                                                      decoration: BoxDecoration(
                                                        color: bgColor,
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(4),
                                                        image: resolveImage(
                                                            row["user"]
                                                                ["photo"]),
                                                      ),
                                                    ),
                                              const SizedBox(width: 4),
                                              Directionality(
                                                textDirection:
                                                    TextDirection.ltr,
                                                child: Text(
                                                  ((row["user"]["username"] ??
                                                      "")),
                                                  style: TextStyle(
                                                      fontWeight:
                                                          FontWeight.w600),
                                                ),
                                              )
                                            ],
                                          );
                                        },
                                      ),
                                      DatatableHeader(
                                        text: "العنوان",
                                        value: "title",
                                        sourceBuilder: (value, row) {
                                          return Wrap(
                                            children: [
                                              SizedBox(
                                                width:
                                                    Responsive.isMobile(context)
                                                        ? 190
                                                        : null,
                                                child: Text(
                                                  row["title"],
                                                  maxLines: 3,
                                                  textAlign:
                                                      Responsive.isMobile(
                                                              context)
                                                          ? TextAlign.end
                                                          : TextAlign.start,
                                                  overflow:
                                                      TextOverflow.ellipsis,
                                                ),
                                              )
                                            ],
                                          );
                                        },
                                      ),
                                    ],
                                    controller.listPosts
                                        .map((e) => e.toJson())
                                        .toList(),
                                    [
                                      DatatableHeader(
                                        text: "التصنيف",
                                        value: "category",
                                        sourceBuilder: (value, row) {
                                          return Wrap(
                                            spacing: 2,
                                            runSpacing: 2,
                                            children: [
                                              ...(row["categories"] as List<
                                                      Map<String, dynamic>>)
                                                  .map((e) => Chip(
                                                        visualDensity:
                                                            VisualDensity(
                                                                vertical: -4),
                                                        label: Text(
                                                          e["name"] ?? "",
                                                          style: TextStyle(
                                                              color:
                                                                  Colors.white),
                                                        ),
                                                        backgroundColor:
                                                            Config.primaryColor,
                                                      ))
                                                  .toList()
                                            ],
                                          );
                                        },
                                      ),
                                      DatatableHeader(
                                        text: "الحالة",
                                        value: "الحالة",
                                        sourceBuilder: (value, row) {
                                          var visible = row["visible"];
                                          return Container(
                                            padding: EdgeInsets.symmetric(
                                                vertical: 0, horizontal: 8),
                                            decoration: BoxDecoration(),
                                            child: Directionality(
                                              textDirection: TextDirection.ltr,
                                              child: Padding(
                                                padding: const EdgeInsets.only(
                                                    top: 4),
                                                child: Chip(
                                                  label: Text(
                                                    (visible ?? 0) == 0
                                                        ? "غير نشط"
                                                        : "نشط",
                                                    style: TextStyle(
                                                        color:
                                                            (visible ?? 0) == 0
                                                                ? Colors.red
                                                                : Colors.green),
                                                  ),
                                                  backgroundColor:
                                                      (visible ?? 0) == 0
                                                          ? Colors.red
                                                              .withAlpha(50)
                                                          : Colors.green
                                                              .withAlpha(50),
                                                ),
                                              ),
                                            ),
                                          );
                                        },
                                      ),
                                      DatatableHeader(
                                          text: "الإجراءات",
                                          value: "الإجراءات",
                                          show: true,
                                          sortable: false,
                                          sourceBuilder: (value, row) {
                                            final index = controller.listPosts
                                                .indexWhere((element) =>
                                                    element.id == row["id"]);
                                            return Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              children: [
                                                IconButton(
                                                  icon: Icon(index ==
                                                              controller
                                                                  .selectedAudioIndex &&
                                                          controller.isPlaying
                                                      ? Icons.pause
                                                      : Icons
                                                          .play_circle_filled_rounded),
                                                  color: Colors.blue,
                                                  onPressed: () async {
                                                    controller.isPlaying &&
                                                            index ==
                                                                controller
                                                                    .selectedAudioIndex
                                                        ? controller.pause()
                                                        : controller.playAudio(
                                                            Post.fromJson(row
                                                                as Map<String,
                                                                    dynamic>),
                                                            index);
                                                  },
                                                ),
                                                const SizedBox(width: 20),
                                                IconButton(
                                                  onPressed: () async {
                                                    controller
                                                        .initializeForm(row);
                                                    if (await manageProductDialog(
                                                        controller)) {
                                                      controller.saveProduct();
                                                    }
                                                  },
                                                  icon: const Icon(Icons.edit,
                                                      color: Colors.green),
                                                ),
                                                const SizedBox(width: 20),
                                                IconButton(
                                                  onPressed: () {
                                                    controller
                                                        .deleteProduct(row);
                                                  },
                                                  icon: const Icon(
                                                      Icons.delete_rounded,
                                                      color: Colors.red),
                                                ),
                                              ],
                                            );
                                          },
                                          textAlign: TextAlign.center)
                                    ],
                                    total: controller.itemCount,
                                    currentPage:
                                        controller.postFilter.page ?? 1,
                                    paginate: (page) {
                                      controller.postFilter.page = page;
                                      controller.getPosts();
                                    },
                                    isLoading: controller.loadingPosts,
                                    nextPage: controller.nextPage,
                                    prevPage: controller.prevPage,
                                    addItem: () async {
                                      controller.initializeForm(
                                          Post(categories: [], visible: 1)
                                              .toJson());
                                      if (await manageProductDialog(
                                          controller)) {
                                        controller.saveProduct();
                                      }
                                    },
                                    onSearch: (query) {
                                      controller.postFilter.title = query;
                                      controller.postFilter.page = 1;

                                      controller.getPosts();
                                    },
                                    searchController:
                                        controller.searchController,
                                  );
                                }),

                                // if (Responsive.isMobile(context))
                                //   SizedBox(height: defaultPadding),
                                // if (Responsive.isMobile(context)) StorageDetails(),
                              ],
                            ),
                          ),
                        ],
                      )
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future manageProductDialog(PostController controller) async {
    return await showBasicDialog(
        controller.post.id == null ? "إضافة منشور" : "تعديل معلومات المنشور", [
      const SizedBox(height: 20),
      Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            const SizedBox(height: 8),
            Container(
              decoration: BoxDecoration(
                  border: Border(
                bottom: BorderSide(color: Colors.grey[100]!),
              )),
              child: TextField(
                controller: controller.titleController,
                keyboardType: TextInputType.text,
                onChanged: (value) {
                  controller.post.title = value;
                },
                decoration: InputDecoration(
                    border: InputBorder.none,
                    hintText: "عنوان المقطع الصوتي",
                    prefixIcon: Icon(Icons.music_note_outlined),
                    hintStyle: TextStyle(color: Colors.grey[400])),
              ),
            ),
            const SizedBox(height: 8),
          ],
        ),
      ),
      const SizedBox(height: 14),
      // GetBuilder<PostController>(
      //   builder: (_) => _.loadingCategories
      //       ? Wrap(
      //           runSpacing: 8,
      //           spacing: 4,
      //           children: [
      //             for (int i = 0;
      //                 i < controller.listCategories.length;
      //                 i++) ...[
      //               ChipWidget(
      //                   text: controller.listCategories[i].name,
      //                   isSelected: controller.post.categoryId ==
      //                       controller.listCategories[i].id,
      //                   onTap: () {
      //                     controller.post.categoryId =
      //                         controller.listCategories[i].id;
      //                     controller.update();
      //                   })
      //             ]
      //           ],
      //         )
      //       : const Column(
      //           mainAxisAlignment: MainAxisAlignment.center,
      //           children: [
      //             Padding(
      //               padding: EdgeInsets.all(8.0),
      //               child: Center(
      //                 child: CircularProgressIndicator(),
      //               ),
      //             )
      //           ],
      //         ),
      // ),
      const LabelForm("إختر التصنيفات"),
      GetBuilder<PostController>(builder: (context) {
        return Wrap(
          runSpacing: 4,
          alignment: WrapAlignment.start,
          children: [
            for (int i = 0; i < controller.listCategories.length; i++) ...[
              ChipWidget(
                  text: controller.listCategories[i].name,
                  isSelected: controller.post.categories.any((element) =>
                      element.id == controller.listCategories[i].id),
                  onTap: () {
                    int index = controller.post.categories.indexWhere(
                        (element) =>
                            element.id == controller.listCategories[i].id);
                    if (index >= 0) {
                      controller.post.categories.removeAt(index);
                      controller.post.sections.removeWhere((element) =>
                          element.categoryId ==
                          controller.listCategories[i].id);
                      controller.sections.removeWhere((element) =>
                          element.categoryId ==
                          controller.listCategories[i].id);
                    } else {
                      controller.post.categories
                          .add(controller.listCategories[i]);
                      controller.sections
                          .addAll(controller.listCategories[i].sections);
                    }

                    controller.update();
                  })
            ]
          ],
        );
      }),
      const SizedBox(height: 20),

      GetBuilder<PostController>(builder: (context) {
        return controller.sections.isNotEmpty
            ? const LabelForm("إختر التصنيفات الفرعية", isRequired: false)
            : const SizedBox();
      }),
      GetBuilder<PostController>(builder: (context) {
        return Wrap(
          runSpacing: 4,
          alignment: WrapAlignment.start,
          runAlignment: WrapAlignment.start,
          crossAxisAlignment: WrapCrossAlignment.start,
          children: [
            for (int i = 0; i < controller.sections.length; i++) ...[
              ChipWidget(
                  text: controller.sections[i].name,
                  backgroundColor: Colors.orange,
                  isSelected: controller.post.sections.any(
                      (element) => element.id == controller.sections[i].id),
                  onTap: () {
                    int index = controller.post.sections.indexWhere(
                        (element) => element.id == controller.sections[i].id);
                    if (index < 0) {
                      controller.post.sections.add(controller.sections[i]);
                    } else {
                      controller.post.sections.removeWhere(
                          (element) => element.id == controller.sections[i].id);
                    }

                    controller.update();
                  })
            ]
          ],
        );
      }),
      const SizedBox(height: 8),
      GetBuilder<PostController>(builder: (_) {
        return SwitchListTile(
          title: const Text("نشط", style: TextStyle(color: Colors.white)),
          activeColor: primaryColor,
          value: controller.post.visible == 1 ? true : false,
          onChanged: (value) {
            controller.post.visible = value == true ? 1 : 0;
            controller.update();
          },
        );
      }),
      const SizedBox(height: defaultPadding),
      Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          GetBuilder<PostController>(builder: (_) {
            return UploadFile(
              upload: () {
                controller.pickFile();
              },
              isCompressing: controller.isCompressing,
              file: controller.file,
            );
          }),
        ],
      ),
    ]);
  }
}
