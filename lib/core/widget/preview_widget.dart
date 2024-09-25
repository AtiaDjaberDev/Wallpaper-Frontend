import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';

Widget previewImage(String? image) {
  final controller = PageController(initialPage: 0);

  return Material(
    color: Colors.black.withOpacity(0.8),
    child: Stack(
      alignment: Alignment.center,
      children: [
        PageView.builder(
          itemCount: 1,
          controller: controller,
          itemBuilder: (context, index) {
            return GestureDetector(
              onDoubleTap: Get.back,
              child: InteractiveViewer(
                  child: Container(
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: Colors.grey.shade100,
                  image: DecorationImage(
                    image: FileImage(File(image!)),
                  ),
                ),
              )),
            );
          },
        ),
        Positioned(
          top: 32,
          left: 32,
          child: InkWell(
            onTap: () {
              Get.back();
            },
            child: Container(
              padding: const EdgeInsets.all(8),
              decoration: const BoxDecoration(
                  color: Color.fromARGB(115, 0, 0, 0), shape: BoxShape.circle),
              child: const Icon(Icons.close, color: Colors.white),
            ),
          ),
        ),
        Positioned(
          top: 32,
          right: 32,
          child: InkWell(
              onTap: () {
                Get.back();
              },
              child: const Text(
                "Zoom Image",
                style: TextStyle(color: Colors.white),
              )),
        ),
      ],
    ),
  );
}
