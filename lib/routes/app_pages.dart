import 'package:wallpaper_app/pages/client/order/audio_view.dart';
import 'package:wallpaper_app/pages/client/register/register_controller.dart';
import 'package:wallpaper_app/pages/client/register/register_view.dart';
import 'package:wallpaper_app/pages/dashboard/chart/chart_view.dart';
import 'package:wallpaper_app/pages/dashboard/section/section_view.dart';
import 'package:wallpaper_app/pages/dashboard/slider/carousel_view.dart';
import 'package:wallpaper_app/pages/dashboard/support/support_view.dart';
import 'package:get/get.dart';
import 'package:wallpaper_app/pages/client/about/about_view.dart';
import 'package:wallpaper_app/pages/client/add_post/add_post_view.dart';
import 'package:wallpaper_app/pages/client/contact/contact_view.dart';
import 'package:wallpaper_app/pages/client/introduction/introduction_view.dart';
import 'package:wallpaper_app/pages/dashboard/category/category_view.dart';
import 'package:wallpaper_app/pages/dashboard/notification/notification_admin_view.dart';
import 'package:wallpaper_app/pages/client/add_user_info/add_user_info_controller.dart';
import 'package:wallpaper_app/pages/client/add_user_info/add_user_info_view.dart';
import 'package:wallpaper_app/pages/client/home/home_view.dart';
import 'package:wallpaper_app/pages/client/login/login_view.dart';
import 'package:wallpaper_app/pages/client/login/login_controller.dart';

import 'package:wallpaper_app/pages/dashboard/product/post_view.dart';
import 'package:wallpaper_app/pages/dashboard/user/user_view.dart';

import 'app_routes.dart';

class AppPages {
  static const INITIAL = AppRoutes.home;

  static final pages = [
    GetPage(
      name: AppRoutes.home,
      page: () => HomeView(),
      // binding: BindingsBuilder(() {
      //   Get.lazyPut(() => HomeController());
      // }),
    ),
    GetPage(
      name: AppRoutes.introduction,
      page: () => IntroductionView(),
      // binding: BindingsBuilder(() {
      //   Get.lazyPut(() => HomeController());
      // }),
    ),
    GetPage(
      name: AppRoutes.login,
      page: () => LoginView(),
      binding: BindingsBuilder(() {
        Get.lazyPut(() => LoginController());
      }),
    ),
    GetPage(
      name: AppRoutes.register,
      page: () => RegisterView(),
      binding: BindingsBuilder(() {
        Get.lazyPut(() => RegisterController());
      }),
    ),
    GetPage(
      name: AppRoutes.addUserInfo,
      page: () => AddUserInfoView(),
      binding: BindingsBuilder(() {
        Get.lazyPut(() => AddUserInfoController());
      }),
    ),
    GetPage(
      name: AppRoutes.notificationDashboard,
      page: () => NotificationAdminView(),
      // binding: BindingsBuilder(() {
      //   Get.lazyPut(() => AddUserInfoController());
      // }),
    ),
    GetPage(
      name: AppRoutes.posts,
      page: () => PostView(),
      // binding: BindingsBuilder(() {
      //   Get.lazyPut(() => ProductController());
      // }),
    ),
    GetPage(
      name: AppRoutes.carousels,
      page: () => CarouselView(),
    ),
    GetPage(
      name: AppRoutes.categories,
      page: () => CategoryView(),
    ),
    GetPage(
      name: AppRoutes.users,
      page: () => UserView(),
    ),
    GetPage(
      name: AppRoutes.about,
      page: () => AboutView(),
    ),
    GetPage(
      name: AppRoutes.contact,
      page: () => ContactView(),
    ),
    GetPage(
      name: AppRoutes.addPost,
      page: () => AddPostView(),
    ),
    GetPage(
      name: AppRoutes.audios,
      page: () => AudioView(),
    ),
    GetPage(
      name: AppRoutes.chart,
      page: () => ChartView(),
    ),
    GetPage(
      name: AppRoutes.sections,
      page: () => SectionView(),
    ),
    GetPage(
      name: AppRoutes.support,
      page: () => SupportView(),
    ),
  ];
}
