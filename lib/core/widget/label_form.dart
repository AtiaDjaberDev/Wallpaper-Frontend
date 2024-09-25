import 'package:flutter/material.dart';
import 'package:wallpaper_app/constants_dashboard.dart';
import 'package:wallpaper_app/core/config.dart';

class LabelForm extends StatelessWidget {
  const LabelForm(this.text, {super.key, this.isRequired = true});

  final String text;
  final bool isRequired;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        children: [
          Text(
            text,
            style: const TextStyle(
                color: isDashboard ? primaryColor : Config.primaryColor,
                fontWeight: FontWeight.w600),
          ),
          SizedBox(width: 4),
          if (isRequired)
            Text(
              "(إجباري)",
              style: TextStyle(color: Colors.grey, fontWeight: FontWeight.w600),
            ),
        ],
      ),
    );
  }
}
