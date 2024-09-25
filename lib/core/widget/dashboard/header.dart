// import 'package:admin/controllers/MenuAppController.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:wallpaper_app/constants_dashboard.dart';
import 'package:wallpaper_app/core/helper/helper_function.dart';
import 'package:wallpaper_app/responsive.dart';
import 'package:wallpaper_app/routes/app_routes.dart';
import 'package:wallpaper_app/service/helper_service.dart';

class Header extends StatelessWidget {
  const Header({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var helperService = Get.find<HelperService>();
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        if (!Responsive.isDesktop(context))
          IconButton(
              icon: Icon(
                Icons.menu,
                color: secondaryColor,
              ),
              onPressed: () {
                var route = Get.currentRoute;
                if (route == AppRoutes.posts) {
                  helperService.productScaffoldKey.currentState?.openDrawer();
                }
                if (route == AppRoutes.categories) {
                  helperService.categoryScaffoldKey.currentState?.openDrawer();
                }
                if (route == AppRoutes.users) {
                  helperService.userScaffoldKey.currentState?.openDrawer();
                }
                if (route == AppRoutes.sections) {
                  helperService.sectionScaffoldKey.currentState?.openDrawer();
                }
                if (route == AppRoutes.carousels) {
                  helperService.carouselScaffoldKey.currentState?.openDrawer();
                }
                if (route == AppRoutes.notificationDashboard) {
                  helperService.notifScaffoldKey.currentState?.openDrawer();
                }
                if (route == AppRoutes.chart) {
                  helperService.chartScaffoldKey.currentState?.openDrawer();
                }
                if (route == AppRoutes.support) {
                  helperService.settingScaffoldKey.currentState?.openDrawer();
                }
              }),
        if (!Responsive.isMobile(context))
          Text(
            "لوحة التحكم",
            style: Theme.of(context).textTheme.titleLarge,
          ),
        if (!Responsive.isMobile(context))
          Spacer(flex: Responsive.isDesktop(context) ? 2 : 1),
        // Expanded(child: SearchField()),
        const ProfileCard()
      ],
    );
  }
}

class ProfileCard extends StatelessWidget {
  const ProfileCard({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var user = Get.find<HelperService>().userModel;
    return user == null
        ? const SizedBox()
        : Container(
            margin: EdgeInsets.only(left: defaultPadding),
            padding: EdgeInsets.symmetric(
              horizontal: defaultPadding,
              vertical: defaultPadding / 2,
            ),
            decoration: BoxDecoration(
              color: secondaryColor,
              borderRadius: const BorderRadius.all(Radius.circular(10)),
              border: Border.all(color: Colors.white10),
            ),
            child: Row(
              children: [
                if (user.photo != null)
                  Image.network(resolveImageUrl(user.photo!), height: 28),
                // if (!Responsive.isMobile(context))
                Padding(
                  padding: const EdgeInsets.symmetric(
                      horizontal: defaultPadding / 2),
                  child: Text(user.username ?? ""),
                ),
                // Icon(Icons.keyboard_arrow_down),
              ],
            ),
          );
  }
}

class SearchField extends StatelessWidget {
  const SearchField({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextField(
      decoration: InputDecoration(
        hintText: "Search",
        fillColor: secondaryColor,
        filled: true,
        border: OutlineInputBorder(
          borderSide: BorderSide.none,
          borderRadius: const BorderRadius.all(Radius.circular(10)),
        ),
        suffixIcon: InkWell(
          onTap: () {},
          child: Container(
            padding: EdgeInsets.all(defaultPadding * 0.75),
            margin: EdgeInsets.symmetric(horizontal: defaultPadding / 2),
            decoration: BoxDecoration(
              color: primaryColor,
              borderRadius: const BorderRadius.all(Radius.circular(10)),
            ),
            child: SvgPicture.asset("assets/icons/Search.svg"),
          ),
        ),
      ),
    );
  }
}
