import 'package:flutter/material.dart';
import 'package:wallpaper_app/core/widget/chip_widget.dart';
import 'package:wallpaper_app/core/widget/label_form.dart';
import 'package:wallpaper_app/core/widget/upload_file_widget.dart';
import 'package:get/get.dart';
import 'package:wallpaper_app/core/config.dart';
import 'package:wallpaper_app/models/category.dart' as category;
import 'package:wallpaper_app/pages/client/add_post/add_post_controller.dart';

class AddPostView extends StatelessWidget {
  final controller = Get.put(AddPostController());

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Directionality(
        textDirection: TextDirection.rtl,
        child: Scaffold(
          appBar: AppBar(elevation: 2, title: const Text("منشور جديد")),
          body: GetBuilder<AddPostController>(builder: (_) {
            return SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Column(
                  children: [
                    const SizedBox(height: 20),
                    SizedBox(
                      width: double.infinity,
                      child: TextFormField(
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'يرجى ادخال عنوان الصورة';
                          }
                        },
                        controller: controller.titleController,
                        decoration: const InputDecoration(
                          filled: true,
                          border: OutlineInputBorder(
                              borderSide:
                                  BorderSide(color: Colors.amber, width: 0.1)),
                          prefixIcon: Icon(Icons.music_note_outlined),
                          hintText: 'عنوان الصورة',
                        ),
                      ),
                    ),
                    const SizedBox(height: 20),
                    const LabelForm("إختر التصنيفات"),
                    Wrap(
                      alignment: WrapAlignment.start,
                      children: [
                        for (int i = 0;
                            i < controller.listCategories.length;
                            i++) ...[
                          ChipWidget(
                              text: controller.listCategories[i].name,
                              isSelected: controller.post.categories.any(
                                  (element) =>
                                      element.id ==
                                      controller.listCategories[i].id),
                              onTap: () {
                                int index = controller.post.categories
                                    .indexWhere((element) =>
                                        element.id ==
                                        controller.listCategories[i].id);
                                if (index >= 0) {
                                  controller.post.categories.removeAt(index);
                                  controller.post.sections.removeWhere(
                                      (element) =>
                                          element.categoryId ==
                                          controller.listCategories[i].id);
                                  controller.sections.removeWhere((element) =>
                                      element.categoryId ==
                                      controller.listCategories[i].id);
                                } else {
                                  controller.post.categories
                                      .add(controller.listCategories[i]);
                                  controller.sections.addAll(
                                      controller.listCategories[i].sections);
                                }

                                controller.update();
                              })
                        ]
                      ],
                    ),
                    const SizedBox(height: 20),
                    if (controller.sections.isNotEmpty)
                      const LabelForm("إختر التصنيفات الفرعية"),
                    Wrap(
                      alignment: WrapAlignment.start,
                      runAlignment: WrapAlignment.start,
                      crossAxisAlignment: WrapCrossAlignment.start,
                      children: [
                        for (int i = 0;
                            i < controller.sections.length;
                            i++) ...[
                          ChipWidget(
                              text: controller.sections[i].name,
                              backgroundColor: Colors.orange,
                              isSelected: controller.post.sections.any(
                                  (element) =>
                                      element.id == controller.sections[i].id),
                              onTap: () {
                                int index = controller.post.sections.indexWhere(
                                    (element) =>
                                        element.id ==
                                        controller.sections[i].id);
                                if (index < 0) {
                                  controller.post.sections
                                      .add(controller.sections[i]);
                                } else {
                                  controller.post.sections.removeWhere(
                                      (element) =>
                                          element.id ==
                                          controller.sections[i].id);
                                }

                                controller.update();
                              })
                        ]
                      ],
                    ),
                    const SizedBox(height: 30),
                    GetBuilder<AddPostController>(builder: (_) {
                      return UploadFile(
                        upload: () {
                          controller.pickFile();
                        },
                        isCompressing: controller.isCompressing,
                        file: controller.file,
                      );
                    }),
                    const SizedBox(height: 40),
                    controller.savingPost
                        ? const SizedBox(
                            height: 40,
                            width: 40,
                            child: CircularProgressIndicator())
                        : MaterialButton(
                            onPressed: () async {
                              controller.saveProduct();
                            },
                            color: Config.primaryColor,
                            elevation: 3,
                            minWidth: 350,
                            height: 50,
                            textColor: Colors.white,
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(8)),
                            child: const Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Icon(Icons.post_add_rounded),
                                SizedBox(width: 8),
                                Text(
                                  'إضافة المنشور',
                                  style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold),
                                ),
                              ],
                            ),
                          ),
                    const SizedBox(height: 20),
                  ],
                ),
              ),
            );
          }),
        ),
      ),
    );
  }
}
