import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:wallpaper_app/core/repository.dart';
import 'package:get/get.dart';
import 'package:wallpaper_app/constants_dashboard.dart';
import 'package:wallpaper_app/routes/app_routes.dart';
import 'package:wallpaper_app/service/helper_service.dart';

class SideMenu extends StatelessWidget {
  SideMenu({Key? key}) : super(key: key);

  List items = [
    // {
    //   "title": "الطلبيات",
    //   "svgSrc": "assets/icons/menu_dashboard.svg",
    //   "route": AppRoutes.orderDashboard
    // },
    {
      "title": "الرئيسية",
      "svgSrc": "assets/icons/menu_dashboard.svg",
      "route": AppRoutes.chart
    },
    {
      "title": "المنشورات",
      "svgSrc": "assets/icons/menu_tran.svg",
      "route": AppRoutes.posts
    },
    {
      "title": "التصنيفات",
      "svgSrc": "assets/icons/menu_task.svg",
      "route": AppRoutes.categories
    },
    {
      "title": "التصنيفات الفرعية",
      "svgSrc": "assets/icons/menu_task.svg",
      "route": AppRoutes.sections
    },
    // {
    //   "title": "المواقع",
    //   "svgSrc": "assets/icons/map.svg",
    //   "route": AppRoutes.locations
    // },
    {
      "title": "الإعلانات",
      "svgSrc": "assets/icons/slider-svgrepo-com.svg",
      "route": AppRoutes.carousels
    },
    {
      "title": "المستخدمين",
      "svgSrc": "assets/icons/menu_profile.svg",
      "route": AppRoutes.users
    },
    {
      "title": "الإشعارات",
      "svgSrc": "assets/icons/menu_notification.svg",
      "route": AppRoutes.notificationDashboard
    },
    {
      "title": "إتصل بنا",
      "svgSrc": "assets/icons/contacts.svg",
      "route": AppRoutes.support
    },
    // {
    //   "title": "الإعدادات",
    //   "svgSrc": "assets/icons/menu_setting.svg",
    //   "route": AppRoutes.setting
    // }
  ];

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        children: [
          DrawerHeader(
            padding: const EdgeInsets.all(30),
            child: Image.asset("assets/logo.png", width: 8, height: 8),
          ),
          // DrawerListTile(
          //   title: "الرئيسية",
          //   svgSrc: "assets/icons/menu_dashboard.svg",
          //   press: () {},
          // ),

          ...items.map(
            (e) => Container(
              decoration: BoxDecoration(
                color: Get.currentRoute == e["route"] ? bgColor : null,
                border: Get.currentRoute == e["route"]
                    ? Border(
                        right: BorderSide(
                        color: primaryColor,
                        width: 4,
                      ))
                    : null,
              ),
              child: DrawerListTile(
                title: e["title"],
                svgSrc: e["svgSrc"],
                press: () {
                  if (Get.currentRoute != e["route"]) {
                    Get.offAllNamed(e["route"]);
                  }
                },
              ),
            ),
          ),

          helperService.userModel == null
              ? Container(
                  child: DrawerListTile(
                  title: "تسجيل الدخول",
                  svgSrc: "assets/icons/login.svg",
                  press: () {
                    Get.find<HelperService>().signOut();
                  },
                ))
              : Container(
                  child: DrawerListTile(
                  title: "تسجيل الخروج",
                  svgSrc: "assets/icons/exit-svgrepo-com.svg",
                  press: () {
                    Get.find<HelperService>().signOut();
                  },
                ))
        ],
      ),
    );
  }
}

class DrawerListTile extends StatelessWidget {
  const DrawerListTile({
    Key? key,
    // For selecting those three line once press "Command+D"
    required this.title,
    required this.svgSrc,
    required this.press,
  }) : super(key: key);

  final String title, svgSrc;
  final VoidCallback press;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: press,
      horizontalTitleGap: 0,
      leading: SvgPicture.asset(
        svgSrc,
        colorFilter: const ColorFilter.mode(Colors.white54, BlendMode.srcIn),
        height: 16,
      ),
      title: Text(
        title,
        style: const TextStyle(color: Colors.white54),
      ),
    );
  }
}
