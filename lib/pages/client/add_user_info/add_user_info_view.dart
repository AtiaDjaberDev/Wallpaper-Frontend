import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:wallpaper_app/constants_dashboard.dart';
import 'package:wallpaper_app/core/config.dart';
import 'package:wallpaper_app/core/helper/helper_function.dart';
import 'package:wallpaper_app/pages/client/add_user_info/add_user_info_controller.dart';

class AddUserInfoView extends StatelessWidget {
  final controller = Get.put(AddUserInfoController());

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Directionality(
        textDirection: TextDirection.rtl,
        child: Scaffold(
          appBar: AppBar(
            elevation: 2,
            title: Text("المعلومات الشخصية"),
          ),
          body: GetBuilder<AddUserInfoController>(builder: (_) {
            return ListView(
              children: [
                const SizedBox(height: 20),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 30),
                  child: SizedBox(
                    width: double.infinity,
                    child: TextFormField(
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'يرجى ادخال اسمك';
                        }
                      },
                      controller: controller.nameController,
                      decoration: InputDecoration(
                        filled: true,
                        border: OutlineInputBorder(
                            borderSide:
                                BorderSide(color: Colors.amber, width: 0.1)),
                        // fillColor: Colors.white,
                        prefixIcon: Icon(Icons.person_outline_rounded),
                        hintText: 'اسم المستخدم',
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 30),
                  child: SizedBox(
                    width: double.infinity,
                    child: TextFormField(
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'يرجى ادخال رقم الهاتف';
                        }
                      },
                      controller: controller.telController,
                      decoration: InputDecoration(
                        filled: true,
                        border: OutlineInputBorder(
                            borderSide:
                                BorderSide(color: Colors.amber, width: 0.1)),
                        // fillColor: Colors.white,
                        prefixIcon: Icon(Icons.call_outlined),
                        hintText: 'رقم الهاتف...',
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 30),
                Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                  Text(
                    "صورة البروفايل",
                    style: TextStyle(
                        fontSize: 18,
                        color: Config.primaryColor,
                        fontWeight: FontWeight.w700),
                  )
                ]),
                const SizedBox(height: 20),
                controller.uploading
                    ? Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          SizedBox(
                              width: 40,
                              height: 40,
                              child: CircularProgressIndicator()),
                        ],
                      )
                    : Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          InkWell(
                            onTap: () {
                              controller.pickFile();
                            },
                            child: Container(
                              width: 125,
                              height: 90,
                              decoration: BoxDecoration(
                                color: Colors.grey.shade200,
                                borderRadius: BorderRadius.circular(8),
                                border: Border.all(
                                    width: 1, color: Colors.grey.shade400),
                              ),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    "إختيار صورة",
                                    style: TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.w600,
                                        color: Colors.grey.shade700),
                                  ),
                                  Icon(
                                    Icons.image_outlined,
                                    color: Colors.grey.shade400,
                                    size: 40,
                                  ),
                                ],
                              ),
                            ),
                          )
                        ],
                      ),
                const SizedBox(height: 30),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      height: 180,
                      width: 220,
                      decoration: BoxDecoration(
                        color: isDashboard ? secondaryColor : Colors.white,
                        borderRadius: BorderRadius.circular(14),
                        image: controller.helperService.userModel!.photo == null
                            ? null
                            : resolveImage(
                                controller.helperService.userModel!.photo),
                      ),
                    ),
                  ],
                ),
                // GetBuilder<AddUserInfoController>(builder: (_) {
                //   return controller.optimizedFile != null
                //       ? Container(
                //           padding: EdgeInsets.symmetric(horizontal: 40),
                //           height: 200,
                //           width: 200,
                //           decoration: BoxDecoration(
                //             borderRadius: BorderRadius.circular(8),
                //             image: DecorationImage(
                //                 image: FileImage(controller.optimizedFile!),
                //                 fit: BoxFit.fill),
                //           ),
                //         )
                //       : const SizedBox();
                // }),
                // Row(
                //   mainAxisAlignment: MainAxisAlignment.center,
                //   children: [
                //     controller.uploading
                //         ? SizedBox(
                //             width: 40,
                //             height: 40,
                //             child: CircularProgressIndicator())
                //         : InkWell(
                //             // onTap: () => Get.dialog(previewImage(
                //             //     controller.items[controller.indexQuestion].photo)),
                //             child: Stack(
                //               clipBehavior: Clip.none,
                //               children: [
                //                 Container(
                //                   height: 200,
                //                   width: 200,
                //                   decoration: BoxDecoration(
                //                     color: isDashboard
                //                         ? secondaryColor
                //                         : Colors.white,
                //                     borderRadius: BorderRadius.circular(8),
                //                     image: controller.helperService.userModel!
                //                                 .photo ==
                //                             null
                //                         ? null
                //                         : DecorationImage(
                //                             image: NetworkImage(
                //                                 Config.storageUrl +
                //                                     controller.helperService
                //                                         .userModel!.photo!),
                //                             fit: BoxFit.fill),
                //                   ),
                //                   child: controller
                //                               .helperService.userModel!.photo !=
                //                           null
                //                       ? const SizedBox()
                //                       : const Center(
                //                           child: Icon(
                //                           Icons.image_outlined,
                //                           color: Colors.grey,
                //                           size: 40,
                //                         )),
                //                 ),
                //                 Positioned(
                //                   top: -25,
                //                   right: -35,
                //                   child: RawMaterialButton(
                //                     hoverElevation: 0,
                //                     highlightElevation: 0,
                //                     hoverColor: Colors.grey.shade100,
                //                     onPressed: () {
                //                       controller.pickFile();
                //                     },
                //                     elevation: 0,
                //                     fillColor: Colors.white,
                //                     padding: const EdgeInsets.all(8.0),
                //                     shape: const CircleBorder(),
                //                     child: const Icon(Icons.edit,
                //                         size: 20.0, color: Colors.black54),
                //                   ),
                //                 ),
                //               ],
                //             ),
                //           ),
                //   ],
                // ),

                // const SizedBox(height: 50),
                // Padding(
                //   padding: const EdgeInsets.symmetric(horizontal: 30),
                //   child: MaterialButton(
                //     onPressed: () async {
                //       Get.off(() => const CameraView());
                //     },
                //     color: Config.secondColor,
                //     elevation: 4,
                //     minWidth: 350,
                //     height: 50,
                //     textColor: Colors.white,
                //     shape: RoundedRectangleBorder(
                //         borderRadius: BorderRadius.circular(10)),
                //     child: const Text(
                //       'التقاط صورة ',
                //       style: TextStyle(
                //           fontSize: 16,
                //           color: Colors.black,
                //           fontWeight: FontWeight.bold),
                //     ),
                //   ),
                // ),

                const SizedBox(height: 50),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 30),
                  child: MaterialButton(
                    onPressed: () async {
                      controller.updateUserInfo();
                    },
                    color: Config.primaryColor,
                    elevation: 3,
                    minWidth: 350,
                    height: 50,
                    textColor: Colors.white,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10)),
                    child: const Text(
                      'حفظ المعلومات ',
                      style:
                          TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
                const SizedBox(height: 10),
              ],
            );
          }),
        ),
      ),
    );
  }
}
