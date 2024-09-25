import 'dart:io';

import 'package:flutter/foundation.dart' as foundation;
import 'package:flutter/material.dart';
import 'package:wallpaper_app/core/widget/chip_widget.dart';
import 'package:wallpaper_app/core/widget/label_form.dart';
import 'package:wallpaper_app/models/section.dart';
import 'package:wallpaper_app/pages/dashboard/section/section_controller.dart';
import 'package:get/get.dart';
import 'package:wallpaper_app/constants_dashboard.dart';
import 'package:wallpaper_app/core/helper/helper_function.dart';
import 'package:wallpaper_app/core/widget/custom_dialog.dart';
import 'package:wallpaper_app/core/widget/dashboard/custom_table.dart';
import 'package:wallpaper_app/core/widget/dashboard/header.dart';
import 'package:wallpaper_app/core/widget/dashboard/side_menu.dart';
import 'package:wallpaper_app/responsive.dart';
import 'package:responsive_table/responsive_table.dart';

class SectionView extends StatelessWidget {
  final controller = Get.put(SectionController());

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        key: controller.helperService.sectionScaffoldKey,
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
                                GetBuilder<SectionController>(builder: (_) {
                                  return CustomTable(
                                    "التصنيفات الفرعية",
                                    controller.headers,
                                    controller.listSections
                                        .map((e) => e.toJson())
                                        .toList(),
                                    leading: [
                                      DatatableHeader(
                                        text: "الصورة",
                                        value: "photo",
                                        show: true,
                                        sortable: false,
                                        sourceBuilder: (value, row) {
                                          return Padding(
                                            padding: const EdgeInsets.all(4),
                                            child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              children: [
                                                Container(
                                                  padding: const EdgeInsets.all(
                                                      defaultPadding),
                                                  height: 50,
                                                  width: 50,
                                                  decoration: BoxDecoration(
                                                    color: bgColor,
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            8),
                                                    image: resolveImage(
                                                        row["photo"]),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          );
                                        },
                                      ),
                                    ],
                                    [
                                      DatatableHeader(
                                        text: "التصنيف الرئيسي",
                                        value: "category",
                                        sourceBuilder: (value, row) {
                                          return Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: [
                                              Directionality(
                                                textDirection:
                                                    TextDirection.ltr,
                                                child: Text(((row["category"]
                                                        ["name"] ??
                                                    ""))),
                                              )
                                            ],
                                          );
                                        },
                                      ),
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
                                                      controller.save();
                                                    }
                                                  },
                                                  icon: const Icon(Icons.edit,
                                                      color: Colors.green),
                                                ),
                                                const SizedBox(width: 20),
                                                IconButton(
                                                  onPressed: () {
                                                    controller.delete(row);
                                                  },
                                                  icon: const Icon(
                                                      Icons.delete_rounded,
                                                      color: Colors.red),
                                                )
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
                                      controller.getCategories();
                                    },
                                    isLoading: controller.loadingPosts,
                                    nextPage: controller.nextPage,
                                    prevPage: controller.prevPage,
                                    addItem: () async {
                                      controller
                                          .initializeForm(Section().toJson());
                                      if (await manageDataDialog()) {
                                        controller.save();
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
        controller.section.id == null
            ? "إضافة تصنيف فرعي"
            : "تعديل معلومات التصنيف الفرعي",
        [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Stack(
                clipBehavior: Clip.none,
                children: [
                  GetBuilder<SectionController>(builder: (_) {
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
                            : (controller.section.photo != null
                                ? DecorationImage(
                                    image: NetworkImage(resolveImageUrl(
                                        controller.section.photo!)),
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
                  controller.section.name = value;
                },
                decoration: InputDecoration(
                    border: InputBorder.none,
                    hintText: "ادخل اسم التصنيف",
                    prefixIcon: const Icon(Icons.title),
                    hintStyle: TextStyle(color: Colors.grey[400])),
              ),
            ),
          ),
          const LabelForm("إختر التصنيف"),
          GetBuilder<SectionController>(builder: (context) {
            return Wrap(
              runSpacing: 4,
              children: [
                for (int i = 0; i < controller.listCategories.length; i++) ...[
                  ChipWidget(
                    text: controller.listCategories[i].name,
                    isSelected: controller.section.categoryId ==
                        controller.listCategories[i].id,
                    onTap: () {
                      controller.section.categoryId =
                          controller.listCategories[i].id;
                      controller.update();
                    },
                  )
                ]
              ],
            );
          }),
        ]);
  }
}
