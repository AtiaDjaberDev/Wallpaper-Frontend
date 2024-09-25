import 'package:flutter/material.dart';
import 'package:wallpaper_app/constants_dashboard.dart';
import 'package:wallpaper_app/core/helper/responsive_padding.dart';
import 'package:wallpaper_app/core/widget/dashboard/header.dart';
import 'package:wallpaper_app/pages/dashboard/support/support_controller.dart';
import 'package:wallpaper_app/responsive.dart';
import 'package:get/get.dart';
import 'package:wallpaper_app/core/widget/dashboard/side_menu.dart';
import 'package:responsive_table/responsive_table.dart';

class SupportView extends StatelessWidget {
  final controller = Get.put(SupportController());

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        key: controller.helperService.settingScaffoldKey,
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
                            child:
                                LayoutBuilder(builder: (context, constraints) {
                              return Padding(
                                padding: EdgeInsets.symmetric(
                                    horizontal: ResponsivePadding.get(
                                        constraints.maxWidth)),
                                child: Column(
                                  children: [
                                    const SizedBox(height: defaultPadding),
                                    Padding(
                                      padding: const EdgeInsets.all(20),
                                      child: Container(
                                        decoration: BoxDecoration(
                                            border: Border(
                                          bottom: BorderSide(
                                              color: Colors.grey[100]!),
                                        )),
                                        child: TextField(
                                          controller: controller.telController,
                                          keyboardType: TextInputType.text,
                                          onChanged: (value) {
                                            controller.setting.tel = value;
                                          },
                                          decoration: InputDecoration(
                                              border: InputBorder.none,
                                              hintText: "ادخل رقم الهاتف",
                                              prefixIcon: Icon(Icons.call),
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
                                          bottom: BorderSide(
                                              color: Colors.grey[100]!),
                                        )),
                                        child: TextField(
                                          controller:
                                              controller.emailController,
                                          keyboardType: TextInputType.text,
                                          onChanged: (value) {
                                            controller.setting.email = value;
                                          },
                                          decoration: InputDecoration(
                                              border: InputBorder.none,
                                              hintText: "ادخل عنوان الإيميل",
                                              prefixIcon:
                                                  Icon(Icons.email_outlined),
                                              hintStyle: TextStyle(
                                                  color: Colors.grey[400])),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              );
                            }),
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
        floatingActionButton: FloatingActionButton.extended(
          onPressed: () {
            controller.save();
          },
          icon: const Icon(Icons.save),
          backgroundColor: primaryColor.withOpacity(0.8),
          label: const Text(
            "حفظ",
            style: TextStyle(fontWeight: FontWeight.w700),
          ),
        ),
      ),
    );
  }
}
