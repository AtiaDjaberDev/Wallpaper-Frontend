import 'package:custom_sliding_segmented_control/custom_sliding_segmented_control.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:wallpaper_app/constants_dashboard.dart';
import 'package:wallpaper_app/core/helper/helper_function.dart';
import 'package:wallpaper_app/core/widget/client/custom_elevated_button.dart';
import 'package:wallpaper_app/core/widget/custom_dialog.dart';
import 'package:wallpaper_app/core/widget/dashboard/custom_table.dart';
import 'package:wallpaper_app/core/widget/dashboard/header.dart';
import 'package:wallpaper_app/core/widget/dashboard/side_menu.dart';
import 'package:wallpaper_app/models/user.dart';
import 'package:wallpaper_app/models/user.dart';
import 'package:wallpaper_app/pages/dashboard/user/user_controller.dart';
import 'package:wallpaper_app/pages/dashboard/user/user_controller.dart';
import 'package:wallpaper_app/responsive.dart';
import 'package:responsive_table/responsive_table.dart';

class UserView extends StatelessWidget {
  var controller = Get.put(UserController());

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        key: controller.helperService.userScaffoldKey,
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
                                GetBuilder<UserController>(builder: (_) {
                                  return CustomTable(
                                    "المستخدمين",
                                    controller.headers,
                                    controller.listUsers
                                        .map((e) => e.toJson())
                                        .toList(),
                                    onSearch: (query) {
                                      controller.filter.title = query;
                                      controller.filter.page = 1;

                                      controller.getUsers();
                                    },
                                    searchController:
                                        controller.searchController,
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
                                                height: 50,
                                                width: 50,
                                                decoration: BoxDecoration(
                                                  color: secondaryColor,
                                                  borderRadius:
                                                      BorderRadius.circular(8),
                                                  image: row["photo"] == null
                                                      ? null
                                                      : resolveImage(
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
                                        text: "الدور",
                                        value: "type",
                                        show: true,
                                        sortable: false,
                                        sourceBuilder: (value, row) {
                                          return Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: [
                                              Container(
                                                // height: 40,
                                                padding: EdgeInsets.symmetric(
                                                    horizontal: 8),
                                                decoration: BoxDecoration(
                                                  borderRadius:
                                                      BorderRadius.circular(20),
                                                ),
                                                child: Padding(
                                                  padding:
                                                      const EdgeInsets.only(
                                                          top: 3),
                                                  child: Text(
                                                      row["type"] ?? "عميل"),
                                                ),
                                              ),
                                            ],
                                          );
                                        },
                                      ),
                                      DatatableHeader(
                                        text: "الحالة",
                                        value: "status",
                                        show: true,
                                        sortable: false,
                                        sourceBuilder: (value, row) {
                                          return Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: [
                                              Container(
                                                // height: 40,
                                                padding: EdgeInsets.symmetric(
                                                    horizontal: 8),
                                                decoration: BoxDecoration(
                                                  borderRadius:
                                                      BorderRadius.circular(20),
                                                  color: (row["status"] ??
                                                              "active") ==
                                                          "active"
                                                      ? Colors.green
                                                      : Colors.red,
                                                ),
                                                child: Padding(
                                                  padding:
                                                      const EdgeInsets.only(
                                                          top: 3),
                                                  child: Text((row["status"] ??
                                                              "active") ==
                                                          "active"
                                                      ? "نشط"
                                                      : "محظور"),
                                                ),
                                              ),
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
                                            var isAdmin =
                                                (row["type"] ?? "عميل") ==
                                                    "أدمن";
                                            return Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              children: [
                                                // IconButton(
                                                //   onPressed: () async {
                                                //     controller
                                                //         .initializeForm(row);
                                                //     if (await manageUserDialog(
                                                //         controller)) {
                                                //       controller.saveUser();
                                                //     }
                                                //   },
                                                //   icon: Icon(
                                                //     Icons.edit,
                                                //     color: Colors.green,
                                                //   ),
                                                // ),
                                                // const SizedBox(width: 20),

                                                isAdmin
                                                    ? SizedBox()
                                                    : IconButton(
                                                        onPressed: () {
                                                          editUser(row);
                                                        },
                                                        icon: const Icon(
                                                          Icons.edit,
                                                          color: Colors.green,
                                                        ),
                                                      ),
                                                const SizedBox(width: 14),

                                                isAdmin
                                                    ? SizedBox()
                                                    : IconButton(
                                                        onPressed: () {
                                                          controller
                                                              .deleteUser(row);
                                                        },
                                                        icon: const Icon(
                                                          Icons.delete_rounded,
                                                          color: Colors.red,
                                                        ),
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
                                      controller.getUsers();
                                    },
                                    isLoading: controller.loading,
                                    nextPage: controller.nextPage,
                                    prevPage: controller.prevPage,
                                    // addItem: () async {
                                    //   controller
                                    //       .initializeForm(User().toJson());
                                    //   if (await manageUserDialog(controller)) {
                                    //     controller.saveUser();
                                    //   }
                                    // },
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

  editUser(Map<String?, dynamic> row) {
    controller.user = User.fromJson(row as Map<String, dynamic>);

    Get.dialog(
      Directionality(
        textDirection: TextDirection.rtl,
        child: AlertDialog(
          title: const Text("تعديل معلومات المستخدم"),
          backgroundColor: isDashboard ? bgColor : Colors.white,
          content: SizedBox(
            width: 400,
            child: Column(
              children: [
                GetBuilder<UserController>(builder: (_) {
                  return SwitchListTile(
                    title: Text(
                      "حالة الحساب",
                      style: TextStyle(color: Colors.white),
                    ),
                    activeColor: primaryColor,
                    value: (controller.user.status ?? "active") == "active"
                        ? true
                        : false,
                    onChanged: (value) {
                      controller.user.status = value ? "active" : "inactive";
                      controller.update();
                    },
                  );
                }),
                const SizedBox(height: 14),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 14),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text("نوع الحساب",
                          style: TextStyle(color: Colors.white)),
                      CustomSlidingSegmentedControl<int>(
                        initialValue:
                            (controller.user.type ?? "عميل") == "عميل" ? 2 : 1,
                        children: const {
                          // 1: Text('أدمن'),
                          1: Text('أدمن'),
                          2: Text('عميل'),
                        },
                        decoration: BoxDecoration(
                          color: secondaryColor,
                          borderRadius: BorderRadius.circular(8),
                        ),
                        thumbDecoration: BoxDecoration(
                          color: primaryColor,
                          borderRadius: BorderRadius.circular(6),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withOpacity(.3),
                              blurRadius: 4.0,
                              spreadRadius: 1.0,
                              offset: const Offset(0.0, 2.0),
                            ),
                          ],
                        ),
                        duration: Duration(milliseconds: 300),
                        curve: Curves.easeInToLinear,
                        onValueChanged: (int v) {
                          controller.user.type = v == 1 ? "أدمن" : "عميل";
                        },
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          actions: [
            CustomElevatedButton(
              title: "موافق",
              onPressed: () {
                controller.updateUser(controller.user);
              },
            ),
            CustomElevatedButton(
              title: "إلغاء",
              backgroundColor: Colors.grey.shade300,
              foregroundColor: Colors.grey.shade800,
              onPressed: () => Get.back(result: false),
            )
          ],
        ),
      ),
    );
  }

  Future manageUserDialog(UserController controller) async {
    return await showBasicDialog(
        controller.user.id == null ? "إضافة مستخدم" : "تعديل معلومات المستخدم",
        [
          const SizedBox(height: 20),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              InkWell(
                child: Stack(
                  clipBehavior: Clip.none,
                  children: [
                    GetBuilder<UserController>(builder: (_) {
                      return Container(
                        height: 150,
                        width: 150,
                        decoration: BoxDecoration(
                          color: bgColor,
                          borderRadius: BorderRadius.circular(8),
                          border: Border.all(color: Colors.grey),
                          image: controller.file != null
                              ? DecorationImage(
                                  image: MemoryImage(controller.file!.bytes!),
                                  fit: BoxFit.fill)
                              : (controller.user.photo != null
                                  ? resolveImage(controller.user.photo)
                                  : null),
                        ),
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
                            size: 20.0, color: Colors.black54),
                      ),
                    ),
                  ],
                ),
              ),
              Expanded(
                child: Padding(
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
                            controller.user.username = value;
                          },
                          decoration: InputDecoration(
                              border: InputBorder.none,
                              hintText: "ادخل اسم المنشور",
                              prefixIcon: Icon(Icons.title),
                              hintStyle: TextStyle(color: Colors.grey[400])),
                        ),
                      ),
                      const SizedBox(height: 8),
                    ],
                  ),
                ),
              )
            ],
          ),
          const SizedBox(height: 14),
        ]);
  }
}
