import 'package:flutter/material.dart';
import 'package:wallpaper_app/constants_dashboard.dart';
import 'package:get/get.dart';
import 'package:wallpaper_app/core/config.dart';
import 'package:wallpaper_app/core/helper/helper_function.dart';
import 'package:wallpaper_app/pages/client/home/home_controller.dart';
import 'package:wallpaper_app/routes/app_routes.dart';
import 'package:share_plus/share_plus.dart';

class CustomDrawer extends StatelessWidget {
  final controller = Get.find<HomeController>();

  var route = [
    {
      "name": "الرئيسية",
      "icon": Icons.home_outlined,
      "route": AppRoutes.home,
    },

    // {
    //   "name": "الإشعارات",
    //   "icon": Icons.notifications_active_outlined,
    //   "route": AppRoutes.notificationDashboard,
    // },

    {
      "name": "مشاركة التطبيق",
      "icon": Icons.share,
      "route": "share",
    },
    // {
    //   "name": "اتصل بنا",
    //   "icon": Icons.contact_support_outlined,
    //   "route": AppRoutes.contact,
    // },
  ];

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        children: [
          controller.helperService.userModel != null
              ? Padding(
                  padding: const EdgeInsets.symmetric(vertical: 14),
                  child: ListTile(
                    leading: Stack(
                      clipBehavior: Clip.none,
                      children: [
                        SizedBox(
                          height: 60,
                          width: 60,
                          child: controller.helperService.userModel?.photo !=
                                  null
                              ? CircleAvatar(
                                  backgroundColor: Colors.transparent,
                                  backgroundImage: NetworkImage(resolveImageUrl(
                                      controller
                                          .helperService.userModel!.photo!)))
                              : CircleAvatar(
                                  backgroundColor: Colors.transparent,
                                  backgroundImage: AssetImage(Config.logoAsset),
                                ),
                        ),
                        Positioned(
                          bottom: -10,
                          left: -10,
                          child: SizedBox(
                            height: 30,
                            width: 30,
                            child: RawMaterialButton(
                              hoverElevation: 0,
                              highlightElevation: 0,
                              hoverColor: Colors.grey.shade100,
                              onPressed: () {
                                Get.toNamed(AppRoutes.addUserInfo);
                              },
                              elevation: 0,
                              fillColor: Colors.grey.shade200,
                              padding: const EdgeInsets.all(0),
                              shape: const CircleBorder(),
                              child: const Icon(Icons.edit,
                                  size: 18, color: Colors.black54),
                            ),
                          ),
                        )
                      ],
                    ),
                    title: Text(
                      controller.helperService.userModel?.username ?? "",
                      style: const TextStyle(
                          fontSize: 16, fontWeight: FontWeight.bold),
                    ),
                    subtitle: Text(
                        controller.helperService.userModel?.tel ?? "",
                        style: const TextStyle(fontSize: 14)),
                  ),
                )
              : const SizedBox(),
          const Divider(),
          ...route.map((e) => InkWell(
                onTap: () {
                  if (AppRoutes.home == e["route"]) {
                    Get.back();
                  } else if ("share" == e["route"]) {
                    Share.share(
                        'مرحباً! جرّب تطبيقنا الآن عبر هذا الرابط: ${Config.googlePlayUrl}',
                        subject: 'تطبيق ${Config.nameApp} ');
                  } else {
                    Get.toNamed(e["route"] as String);
                  }
                },
                child: Padding(
                  padding: const EdgeInsets.all(14),
                  child: Row(
                    children: [
                      Icon(e["icon"] as IconData,
                          color: Colors.grey.shade500, size: 26),
                      const SizedBox(width: 8),
                      Text(
                        e["name"] as String,
                        style: TextStyle(
                            fontSize: 18,
                            color: Colors.grey.shade800,
                            fontWeight: FontWeight.w600),
                      )
                    ],
                  ),
                ),
              )),
          controller.helperService.userModel == null
              ? InkWell(
                  onTap: () {
                    Get.toNamed(AppRoutes.login);
                  },
                  child: Padding(
                    padding: const EdgeInsets.all(14),
                    child: Row(
                      children: [
                        Icon(Icons.login, color: Colors.grey.shade500),
                        const SizedBox(width: 8),
                        Text(
                          "تسجيل الدخول",
                          style: TextStyle(
                              fontSize: 18,
                              color: Colors.grey.shade800,
                              fontWeight: FontWeight.w600),
                        )
                      ],
                    ),
                  ),
                )
              : InkWell(
                  onTap: () {
                    controller.helperService.signOut();
                  },
                  child: Padding(
                    padding: const EdgeInsets.all(14),
                    child: Row(
                      children: [
                        Icon(Icons.exit_to_app, color: Colors.grey.shade500),
                        const SizedBox(width: 8),
                        Text(
                          "تسجيل الخروج",
                          style: TextStyle(
                              fontSize: 18,
                              color: Colors.grey.shade800,
                              fontWeight: FontWeight.w600),
                        )
                      ],
                    ),
                  ),
                )
        ],
      ),
    );
  }
}
