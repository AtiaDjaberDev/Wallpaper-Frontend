import 'package:flutter/material.dart';
import 'package:wallpaper_app/constants_dashboard.dart';

class ChartModel {
  final String? svgSrc, title, totalStorage;
  final int? value, percentage;
  final Color? color;

  ChartModel({
    this.svgSrc,
    this.title,
    this.totalStorage,
    this.value,
    this.percentage,
    this.color,
  });
}

List demoMyFiles = [
  // ChartModel(
  //   title: "Google Drive",
  //   value: 1328,
  //   svgSrc: "assets/icons/google_drive.svg",
  //   totalStorage: "2.9GB",
  //   color: Color(0xFFFFA113),
  //   percentage: 35,
  // ),
  // ChartModel(
  //   title: "One Drive",
  //   value: 1328,
  //   svgSrc: "assets/icons/one_drive.svg",
  //   totalStorage: "1GB",
  //   color: Color(0xFFA4CDFF),
  //   percentage: 10,
  // ),
  // ChartModel(
  //   title: "Documents",
  //   value: 5328,
  //   svgSrc: "assets/icons/drop_box.svg",
  //   totalStorage: "7.3GB",
  //   color: Color(0xFF007EE5),
  //   percentage: 78,
  // ),
];
