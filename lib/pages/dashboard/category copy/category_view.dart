import 'dart:io';

import 'package:flutter/foundation.dart' as foundation;
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:wallpaper_app/constants_dashboard.dart';
import 'package:wallpaper_app/core/helper/helper_function.dart';
import 'package:wallpaper_app/core/widget/custom_dialog.dart';
import 'package:wallpaper_app/core/widget/dashboard/custom_table.dart';
import 'package:wallpaper_app/core/widget/dashboard/header.dart';
import 'package:wallpaper_app/core/widget/dashboard/side_menu.dart';
import 'package:wallpaper_app/models/category.dart';
import 'package:wallpaper_app/pages/dashboard/category/category_controller.dart';
import 'package:wallpaper_app/responsive.dart';
import 'package:responsive_table/responsive_table.dart';

class CategoryView extends StatelessWidget {
  final controller = Get.put(CategoryController());

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        key: controller.helperService.categoryScaffoldKey,
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
                  padding: EdgeInsets.all(defaultPadding),
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
                                GetBuilder<CategoryController>(builder: (_) {
                                  return CustomTable(
                                    "الفئات",
                                    controller.headers,
                                    controller.listCategories
                                        .map((e) => e.toJson())
                                        .toList(),
                                    [
                                      DatatableHeader(
                                          text: "الإجراءات",
                                          value: "الإجراءات",
                                          show: true,
                                          sortable: false,
                                          sourceBuilder: (value, row) {
                                            return Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              children: [
                                                IconButton(
                                                  onPressed: () async {
                                                    controller
                                                        .initializeForm(row);
                                                    if (await manageDataDialog()) {
                                                      controller.saveCategory();
                                                    }
                                                  },
                                                  icon: Icon(
                                                    Icons.edit,
                                                    color: Colors.green,
                                                  ),
                                                ),
                                                const SizedBox(width: 20),
                                                IconButton(
                                                  onPressed: () {
                                                    controller
                                                        .deleteCategory(row);
                                                  },
                                                  icon: Icon(
                                                    Icons.delete_rounded,
                                                    color: Colors.red,
                                                  ),
                                                )
                                              ],
                                            );
                                          },
                                          textAlign: TextAlign.center)
                                    ],
                                    leading: [
                                      DatatableHeader(
                                        text: "الصورة",
                                        value: "الصورة",
                                        show: true,
                                        sortable: false,
                                        sourceBuilder: (value, row) {
                                          return Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: [
                                              Container(
                                                height: 60,
                                                width: 60,
                                                decoration: BoxDecoration(
                                                  color: secondaryColor,
                                                  borderRadius:
                                                      BorderRadius.circular(8),
                                                  image: resolveImage(
                                                      row["photo"]),
                                                ),
                                              ),
                                            ],
                                          );
                                        },
                                      ),
                                    ],
                                    total: controller.itemCount,
                                    currentPage:
                                        controller.postFilter.page ?? 1,
                                    paginate: (page) {
                                      controller.postFilter.page = page;
                                      controller.getCategories();
                                    },
                                    isLoading: controller.loadingPosts,
                                    nextPage: controller.nextPage,
                                    prevPage: controller.prevPage,
                                    addItem: () async {
                                      controller.initializeForm(
                                          Category(sections: []).toJson());
                                      if (await manageDataDialog()) {
                                        controller.saveCategory();
                                      }
                                    },
                                  );
                                }),
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

  Future manageDataDialog() async {
    return await showBasicDialog(
        controller.category.id == null
            ? "إضافة التصنيف"
            : "تعديل معلومات التصنيف",
        [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Stack(
                clipBehavior: Clip.none,
                children: [
                  GetBuilder<CategoryController>(builder: (_) {
                    return Container(
                      height: 120,
                      width: 120,
                      decoration: BoxDecoration(
                        color: bgColor,
                        borderRadius: BorderRadius.circular(8),
                        border: Border.all(color: Colors.grey),
                        image: controller.file != null
                            ? (foundation.kIsWeb
                                ? DecorationImage(
                                    image: MemoryImage(controller.file!.bytes!),
                                    fit: BoxFit.fill)
                                : DecorationImage(
                                    image:
                                        FileImage(File(controller.file!.path!)),
                                    fit: BoxFit.fill))
                            : (controller.category.photo != null
                                ? DecorationImage(
                                    image: NetworkImage(resolveImageUrl(
                                        controller.category.photo!)),
                                    fit: BoxFit.fill)
                                : null),
                      ),
                    );
                  }),
                  Positioned(
                    top: 4,
                    right: -14,
                    child: RawMaterialButton(
                      hoverElevation: 0,
                      highlightElevation: 0,
                      hoverColor: Colors.white,
                      onPressed: () {
                        controller.pickFile();
                      },
                      elevation: 0,
                      fillColor: Colors.grey,
                      padding: const EdgeInsets.all(8.0),
                      shape: const CircleBorder(),
                      child: const Icon(Icons.edit,
                          size: 18, color: Colors.black54),
                    ),
                  ),
                ],
              ),
            ],
          ),
          const SizedBox(height: 20),
          Padding(
            padding: const EdgeInsets.all(20),
            child: Container(
              decoration: BoxDecoration(
                  border: Border(
                bottom: BorderSide(color: Colors.grey[100]!),
              )),
              child: TextField(
                controller: controller.titleController,
                keyboardType: TextInputType.text,
                onChanged: (value) {
                  controller.category.name = value;
                },
                decoration: InputDecoration(
                    border: InputBorder.none,
                    hintText: "ادخل اسم التصنيف",
                    prefixIcon: Icon(Icons.title),
                    hintStyle: TextStyle(color: Colors.grey[400])),
              ),
            ),
          ),
        ]);
  }
}
