import 'package:flutter/material.dart';
import 'package:wallpaper_app/constants_dashboard.dart';
import 'package:wallpaper_app/core/config.dart';

class ChipWidget extends StatelessWidget {
  ChipWidget({
    super.key,
    required this.onTap,
    this.isSelected,
    this.text,
    this.backgroundColor = Config.primaryColor,
  });

  String? text;
  late Function onTap;
  bool? isSelected;
  Color? backgroundColor;
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        onTap.call();
      },
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 2),
        child: Chip(
          backgroundColor:
              isSelected ?? false ? backgroundColor : Colors.grey.shade300,
          label: Text(
            text ?? "",
            style: TextStyle(
                fontSize: 14,
                fontWeight:
                    isSelected ?? false ? FontWeight.w700 : FontWeight.w500),
          ),
        ),
      ),
    );
  }
}
