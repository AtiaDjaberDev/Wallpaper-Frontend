import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:wallpaper_app/constants_dashboard.dart';
import 'package:wallpaper_app/core/config.dart';
import 'package:wallpaper_app/core/widget/dashboard/header.dart';
import 'package:wallpaper_app/core/widget/dashboard/side_menu.dart';
import 'package:wallpaper_app/pages/dashboard/notification/notification_admin_controller.dart';
import 'package:wallpaper_app/responsive.dart';

class NotificationAdminView extends StatelessWidget {
  var controller = Get.put(NotificationAdminController());
  build(context) => Directionality(
        textDirection: TextDirection.rtl,
        child: Scaffold(
          key: controller.helperService.notifScaffoldKey,
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
                        Container(
                          decoration: const BoxDecoration(
                            color: secondaryColor,
                            borderRadius: BorderRadius.all(Radius.circular(10)),
                          ),
                          child: Padding(
                            padding: EdgeInsets.all(defaultPadding),
                            child: Column(
                              children: [
                                const SizedBox(height: 40),
                                InkWell(
                                  child: Stack(
                                    clipBehavior: Clip.none,
                                    children: [
                                      GetBuilder<NotificationAdminController>(
                                          builder: (_) {
                                        return Container(
                                          height: 150,
                                          width: 150,
                                          decoration: BoxDecoration(
                                              color: bgColor,
                                              borderRadius:
                                                  BorderRadius.circular(8),
                                              border: Border.all(
                                                  color: Colors.grey),
                                              image: controller.file != null
                                                  ? (kIsWeb
                                                      ? DecorationImage(
                                                          image: MemoryImage(
                                                              controller.file!
                                                                  .bytes!),
                                                          fit: BoxFit.fill)
                                                      : DecorationImage(
                                                          image: FileImage(File(
                                                              controller.file!
                                                                  .path!)),
                                                          fit: BoxFit.fill))
                                                  : null),

                                          // child: controller.helperService.userModel!.photo != null
                                          //     ? Container(
                                          //         height: 150,
                                          //         width: 150,
                                          //         decoration: BoxDecoration(
                                          //           color: bgColor,
                                          //           borderRadius: BorderRadius.circular(8),
                                          //           border: Border.all(color: Colors.grey),
                                          //           image: controller.file == null
                                          //               ? null
                                          //               : DecorationImage(
                                          //                   image: NetworkImage(Config.storageUrl +
                                          //                       controller
                                          //                           .helperService.userModel!.photo!),
                                          //                   fit: BoxFit.fill),
                                          //         ))
                                          //     : const Center(
                                          //         child: Icon(Icons.image_outlined,
                                          //             color: Colors.white, size: 40)),
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
                                              size: 20.0,
                                              color: Colors.black54),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(20),
                                  child: Container(
                                    decoration: BoxDecoration(
                                        border: Border(
                                      bottom:
                                          BorderSide(color: Colors.grey[100]!),
                                    )),
                                    child: TextField(
                                      controller: controller.titleContr,
                                      keyboardType: TextInputType.text,
                                      decoration: InputDecoration(
                                          border: InputBorder.none,
                                          hintText: "ادخل عنوان الاشعار",
                                          prefixIcon: Icon(Icons.title),
                                          hintStyle: TextStyle(
                                              color: Colors.grey[400])),
                                    ),
                                  ),
                                ),
                                const SizedBox(height: 20),
                                Padding(
                                  padding: const EdgeInsets.all(20),
                                  child: Container(
                                    decoration: BoxDecoration(
                                        border: Border(
                                      bottom:
                                          BorderSide(color: Colors.grey[100]!),
                                    )),
                                    child: TextField(
                                      controller: controller.descriptionContr,
                                      keyboardType: TextInputType.text,
                                      decoration: InputDecoration(
                                          border: InputBorder.none,
                                          hintText: "ادخل وصف الاشعار",
                                          prefixIcon:
                                              Icon(Icons.note_alt_outlined),
                                          hintStyle: TextStyle(
                                              color: Colors.grey[400])),
                                    ),
                                  ),
                                ),
                                const SizedBox(height: 30),
                                ElevatedButton.icon(
                                  onPressed: () {
                                    controller.send();
                                  },
                                  icon: Icon(
                                    Icons.send,
                                    size: 30,
                                    color: Colors.white,
                                  ),
                                  label: Container(
                                    padding: EdgeInsets.all(8),
                                    child: Text(
                                      "إرسال",
                                      style: TextStyle(
                                          fontSize: 18,
                                          fontWeight: FontWeight.w600),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      );
} //__