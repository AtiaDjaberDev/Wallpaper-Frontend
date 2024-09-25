import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CustomElevatedButton extends StatelessWidget {
  CustomElevatedButton(
      {this.onPressed,
      required this.title,
      this.backgroundColor,
      this.foregroundColor,
      this.icon,
      this.iconData,
      super.key});
  Color? backgroundColor;
  Color? foregroundColor;
  void Function()? onPressed;
  Icon? icon;
  IconData? iconData;
  String title;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ButtonStyle(
          backgroundColor: MaterialStateProperty.all(backgroundColor)),
      child: Row(mainAxisSize: MainAxisSize.min, children: [
        Text(
          title,
          style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w600,
              color: foregroundColor ?? Colors.white),
        ),
        SizedBox.square(dimension: iconData == null ? 0 : 4),
        iconData != null
            ? Icon(
                iconData,
                color: foregroundColor ?? Colors.white,
                size: 20,
              )
            : const SizedBox(),
      ]),
    );
  }
}
