import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:wallpaper_app/constants_dashboard.dart';
import 'package:wallpaper_app/core/helper/helper_function.dart';

class PhotoCard extends StatelessWidget {
  const PhotoCard({super.key, this.onPickFile, this.file, this.photo});

  final Function? onPickFile;
  final PlatformFile? file;
  final String? photo;
  @override
  Widget build(BuildContext context) {
    return Stack(
      clipBehavior: Clip.none,
      children: [
        Container(
          padding: const EdgeInsets.all(4),
          decoration: BoxDecoration(
              border: Border.all(color: bgColor),
              borderRadius: BorderRadius.circular(12)),
          child: Container(
            height: 140,
            width: 160,
            decoration: BoxDecoration(
              color: secondaryColor,
              borderRadius: BorderRadius.circular(8),
              border: Border.all(color: bgColor),
              image: universelImage(file, photo),
            ),
          ),
        ),
        Positioned(
          top: 4,
          right: -14,
          child: RawMaterialButton(
            hoverElevation: 0,
            highlightElevation: 0,
            hoverColor: Colors.grey,
            onPressed: () {
              onPickFile?.call();
            },
            elevation: 0,
            fillColor: bgColor,
            padding: const EdgeInsets.all(8.0),
            shape: const CircleBorder(),
            child: SvgPicture.asset(
              "assets/icons/upload.svg",
              colorFilter:
                  const ColorFilter.mode(Colors.green, BlendMode.srcIn),
              height: 24,
            ),
          ),
        ),
      ],
    );
  }
}
