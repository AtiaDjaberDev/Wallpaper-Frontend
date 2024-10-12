import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:wallpaper_app/constants_dashboard.dart';
import 'package:wallpaper_app/core/helper/helper_function.dart';
import 'package:wallpaper_app/core/widget/custom_dialog.dart';
import 'package:wallpaper_app/core/widget/dashboard/custom_table.dart';
import 'package:wallpaper_app/core/widget/dashboard/header.dart';
import 'package:wallpaper_app/core/widget/dashboard/side_menu.dart';
import 'package:wallpaper_app/models/carousel.dart';
import 'package:wallpaper_app/pages/dashboard/slider/carousel_controller.dart'
    as carouselCont;
import 'package:wallpaper_app/responsive.dart';
import 'package:responsive_table/responsive_table.dart';

class CarouselView extends StatelessWidget {
  final controller = Get.put(carouselCont.CarouselController());
  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        key: controller.helperService.carouselScaffoldKey,
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
                                GetBuilder<carouselCont.CarouselController>(
                                    builder: (_) {
                                  return CustomTable(
                                    "الإعلانات",
                                    controller.headers,
                                    controller.listCarousels
                                        .map((e) => e.toJson())
                                        .toList(),
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
                                                height: 100,
                                                width: 200,
                                                decoration: BoxDecoration(
                                                  color: secondaryColor,
                                                  borderRadius:
                                                      BorderRadius.circular(8),
                                                  image: resolveImage(
                                                      row["photo"]),
                                                ),
                                                child: row["photo"] != null
                                                    ? const SizedBox()
                                                    : const Center(
                                                        child: Icon(
                                                        Icons.image_outlined,
                                                        color: Colors.grey,
                                                        size: 40,
                                                      )),
                                              ),
                                            ],
                                          );
                                        },
                                      )
                                    ],
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
                                    currentPage: controller.filter.page ?? 1,
                                    paginate: (page) {
                                      controller.filter.page = page;
                                      controller.getCarousels();
                                    },
                                    isLoading: controller.loading,
                                    nextPage: controller.nextPage,
                                    prevPage: controller.prevPage,
                                    addItem: () async {
                                      controller
                                          .initializeForm(Carousel().toJson());
                                      if (await manageDataDialog()) {
                                        controller.save();
                                      }
                                    },
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

  Future manageDataDialog() async {
    return await showBasicDialog(
        controller.carousel.id == null
            ? "إضافة إعلان"
            : "تعديل معلومات الإعلان",
        [
          const SizedBox(height: defaultPadding),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              InkWell(
                child: Stack(
                  clipBehavior: Clip.none,
                  children: [
                    GetBuilder<carouselCont.CarouselController>(builder: (_) {
                      return Container(
                        height: 150,
                        width: 250,
                        decoration: BoxDecoration(
                          color: bgColor,
                          borderRadius: BorderRadius.circular(8),
                          border: Border.all(color: Colors.grey),
                          image: controller.file != null
                              ? (kIsWeb
                                  ? DecorationImage(
                                      image:
                                          MemoryImage(controller.file!.bytes!),
                                      fit: BoxFit.fill)
                                  : DecorationImage(
                                      image: FileImage(
                                          File(controller.file!.path!)),
                                      fit: BoxFit.fill))
                              : (controller.carousel.photo != null
                                  ? DecorationImage(
                                      image: NetworkImage(resolveImageUrl(
                                          controller.carousel.photo!)),
                                      fit: BoxFit.fill)
                                  : null),
                        ),
                      );
                    }),
                    Positioned(
                      top: -25,
                      right: -35,
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
                            size: 20.0, color: Colors.black54),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: defaultPadding),
          Container(
            decoration: BoxDecoration(
                border: Border(bottom: BorderSide(color: Colors.grey[100]!))),
            child: TextField(
              controller: controller.targetController,
              keyboardType: TextInputType.text,
              onChanged: (value) {
                controller.carousel.target = value;
              },
              decoration: InputDecoration(
                  border: InputBorder.none,
                  hintText: "رابط الاحالة",
                  prefixIcon: Icon(Icons.link_rounded),
                  hintStyle: TextStyle(color: Colors.grey[400])),
            ),
          ),
        ]);
  }
}
