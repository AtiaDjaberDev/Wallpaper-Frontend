import 'dart:io';

import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/foundation.dart' as foundation;
import 'package:flutter/material.dart';
import 'package:wallpaper_app/core/config.dart';
import 'package:wallpaper_app/core/widget/dashboard/my_files.dart';
import 'package:wallpaper_app/pages/dashboard/chart/chart_controller.dart';
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

class ChartView extends StatelessWidget {
  final controller = Get.put(ChartController());
  List<Color> gradientColors = [
    Color(0xFF50E4FF),
    Color(0xFF2196F3),
  ];
  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        key: controller.helperService.chartScaffoldKey,
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
                      MyFiles(),
                      // Row(
                      //   crossAxisAlignment: CrossAxisAlignment.start,
                      //   children: [
                      //     Expanded(
                      //       flex: 5,
                      //       child: Column(
                      //         children: [
                      //           const SizedBox(height: defaultPadding),
                      //           GetBuilder<ChartController>(builder: (_) {
                      //             return CustomTable(
                      //               "الفئات",
                      //               controller.headers,
                      //               controller.listCategories
                      //                   .map((e) => e.toJson())
                      //                   .toList(),
                      //               [
                      //                 DatatableHeader(
                      //                     text: "الإجراءات",
                      //                     value: "الإجراءات",
                      //                     show: true,
                      //                     sortable: false,
                      //                     sourceBuilder: (value, row) {
                      //                       return Row(
                      //                         mainAxisAlignment:
                      //                             MainAxisAlignment.center,
                      //                         children: [
                      //                           IconButton(
                      //                             onPressed: () async {
                      //                               controller
                      //                                   .initializeForm(row);
                      //                               if (await manageDataDialog()) {
                      //                                 controller.saveCategory();
                      //                               }
                      //                             },
                      //                             icon: Icon(
                      //                               Icons.edit,
                      //                               color: Colors.green,
                      //                             ),
                      //                           ),
                      //                           const SizedBox(width: 20),
                      //                           IconButton(
                      //                             onPressed: () {
                      //                               controller
                      //                                   .deleteCategory(row);
                      //                             },
                      //                             icon: Icon(
                      //                               Icons.delete_rounded,
                      //                               color: Colors.red,
                      //                             ),
                      //                           )
                      //                         ],
                      //                       );
                      //                     },
                      //                     textAlign: TextAlign.center)
                      //               ],
                      //               leading: [
                      //                 DatatableHeader(
                      //                   text: "الصورة",
                      //                   value: "الصورة",
                      //                   show: true,
                      //                   sortable: false,
                      //                   sourceBuilder: (value, row) {
                      //                     return Row(
                      //                       mainAxisAlignment:
                      //                           MainAxisAlignment.center,
                      //                       children: [
                      //                         Container(
                      //                           height: 60,
                      //                           width: 60,
                      //                           decoration: BoxDecoration(
                      //                             color: secondaryColor,
                      //                             borderRadius:
                      //                                 BorderRadius.circular(8),
                      //                             image: resolveImage(
                      //                                 row["photo"]),
                      //                           ),
                      //                         ),
                      //                       ],
                      //                     );
                      //                   },
                      //                 ),
                      //               ],
                      //               total: controller.itemCount,
                      //               currentPage:
                      //                   controller.postFilter.page ?? 1,
                      //               paginate: (page) {
                      //                 controller.postFilter.page = page;
                      //                 controller.getCategories();
                      //               },
                      //               isLoading: controller.loadingPosts,
                      //               nextPage: controller.nextPage,
                      //               prevPage: controller.prevPage,
                      //               addItem: () async {
                      //                 controller
                      //                     .initializeForm(Category().toJson());
                      //                 if (await manageDataDialog()) {
                      //                   controller.saveCategory();
                      //                 }
                      //               },
                      //             );
                      //           }),
                      //           // if (Responsive.isMobile(context))
                      //           //   SizedBox(height: defaultPadding),
                      //           // if (Responsive.isMobile(context)) StorageDetails(),
                      //         ],
                      //       ),
                      //     ),
                      //   ],
                      // )
                      SizedBox(height: 20),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "معدل الزوار",
                            style: Theme.of(context)
                                .textTheme
                                .titleMedium
                                ?.copyWith(color: Config.secondColor),
                          ),
                          const SizedBox(width: 8),
                          const Expanded(
                              child: Divider(
                                  color: Config.secondColor, thickness: 1.5))
                        ],
                      ),
                      GetBuilder<ChartController>(builder: (_) {
                        return Responsive(
                          mobile: responsiveChart(1.2),
                          tablet: responsiveChart(2),
                          desktop: responsiveChart(2.7),
                        );
                      }),
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

  AspectRatio responsiveChart(double aspectRatio) {
    return AspectRatio(
      aspectRatio: aspectRatio,
      child: Padding(
        padding: const EdgeInsets.only(right: 8, top: 24, bottom: 12),
        child: LineChart(
          avgData(),
        ),
      ),
    );
  }

  Widget bottomTitleWidgets(double value, TitleMeta meta) {
    const style = TextStyle(fontSize: 14, color: Colors.grey);

    int index = value.toInt();
    if (index >= 0 && index < controller.labels.length) {
      return Text(controller.labels[index], style: style);
    } else {
      return const Text('', style: style);
    }
  }

  LineChartData avgData() {
    return LineChartData(
      lineTouchData: const LineTouchData(enabled: true),
      gridData: FlGridData(
        show: true,
        drawHorizontalLine: true,
        verticalInterval: 1,
        horizontalInterval: 1,
        getDrawingVerticalLine: (value) {
          return const FlLine(color: Color(0xff37434d), strokeWidth: 1);
        },
        getDrawingHorizontalLine: (value) {
          return const FlLine(color: Color(0xff37434d), strokeWidth: 1);
        },
      ),
      titlesData: FlTitlesData(
        show: true,
        bottomTitles: AxisTitles(
          sideTitles: SideTitles(
              showTitles: true,
              getTitlesWidget: bottomTitleWidgets,
              interval: 1),
        ),
        leftTitles: const AxisTitles(
          sideTitles:
              SideTitles(showTitles: true, reservedSize: 42, interval: 1),
        ),
        topTitles: const AxisTitles(sideTitles: SideTitles(showTitles: false)),
        rightTitles:
            const AxisTitles(sideTitles: SideTitles(showTitles: false)),
      ),
      borderData: FlBorderData(
          show: true, border: Border.all(color: const Color(0xff37434d))),
      minX: 0,
      minY: 0,
      lineBarsData: [
        LineChartBarData(
          spots: List.generate(
            controller.values.length,
            (index) => FlSpot(index.toDouble(), controller.values[index]),
          ),
          isCurved: true,
          gradient: LinearGradient(
            colors: [
              ColorTween(begin: gradientColors[0], end: gradientColors[1])
                  .lerp(0.2)!,
              ColorTween(begin: gradientColors[0], end: gradientColors[1])
                  .lerp(0.2)!,
            ],
          ),
          barWidth: 3,
          isStrokeCapRound: true,
          dotData: const FlDotData(show: true),
          belowBarData: BarAreaData(
            show: true,
            gradient: LinearGradient(
              colors: [
                ColorTween(begin: gradientColors[0], end: gradientColors[1])
                    .lerp(0.2)!
                    .withOpacity(0.1),
                ColorTween(begin: gradientColors[0], end: gradientColors[1])
                    .lerp(0.2)!
                    .withOpacity(0.1),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
