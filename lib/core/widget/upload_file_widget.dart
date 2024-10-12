import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:wallpaper_app/constants_dashboard.dart';
import 'package:wallpaper_app/core/config.dart';

class UploadFile extends StatelessWidget {
  UploadFile(
      {super.key,
      required this.upload,
      required this.file,
      this.isCompressing});

  late Function upload;
  PlatformFile? file;
  bool? isCompressing;
  @override
  Widget build(BuildContext context) {
    const Color themeColor = isDashboard ? primaryColor : Config.primaryColor;
    return Column(
      children: [
        (isCompressing ?? false)
            ? const Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(
                      height: 20,
                      width: 20,
                      child: CircularProgressIndicator(color: themeColor)),
                  SizedBox(width: defaultPadding / 2),
                  Text(
                    "جاري ضغط الملف... ",
                    style: TextStyle(color: themeColor),
                  ),
                ],
              )
            : const SizedBox(),
        const SizedBox(height: defaultPadding),
        SizedBox(
          width: 200,
          child: Stack(
            clipBehavior: Clip.none,
            children: [
              const SizedBox(height: defaultPadding),
              Container(
                height: 150,
                width: 200,
                decoration: BoxDecoration(
                  color: isDashboard ? bgColor : Colors.grey.shade200,
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(color: Colors.grey),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(4),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      const SizedBox(height: 16),
                      SvgPicture.asset(
                        "assets/icons/upload.svg",
                        colorFilter: const ColorFilter.mode(
                            Color.fromARGB(255, 135, 126, 152),
                            BlendMode.srcIn),
                        height: 36,
                      ),
                      const SizedBox(height: 8),
                      Text(
                        file == null ? "إختر صورة" : file!.name,
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            color: file == null
                                ? const Color.fromARGB(255, 135, 126, 152)
                                : primaryColor),
                      ),
                    ],
                  ),
                ),
              ),
              Positioned(
                bottom: 8,
                left: 20,
                right: 20,
                child: OutlinedButton.icon(
                  style: OutlinedButton.styleFrom(
                    overlayColor: Colors.amber,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30.0),
                    ),
                    side: const BorderSide(color: themeColor),
                  ),
                  onPressed: () {
                    upload.call();
                  },
                  icon:
                      const Icon(Icons.file_upload_outlined, color: themeColor),
                  label: const Text('رفع',
                      style: TextStyle(fontSize: 16, color: themeColor)),
                ),
              )
            ],
          ),
        ),
      ],
    );
  }
}
