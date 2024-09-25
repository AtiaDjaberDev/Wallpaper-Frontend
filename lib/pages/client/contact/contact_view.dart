import 'package:flutter/material.dart';
import 'package:wallpaper_app/core/config.dart';
import 'package:wallpaper_app/pages/client/contact/contact_controller.dart';
import 'package:get/get.dart';
import 'package:url_launcher/url_launcher.dart';

class ContactView extends StatelessWidget {
  ContactView({super.key});
  final controller = Get.put(ContactController());

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Directionality(
        textDirection: TextDirection.rtl,
        child: Scaffold(
            backgroundColor: Config.primaryColor,
            appBar: AppBar(elevation: 0, title: const Text("اتصل بنا")),
            body: SingleChildScrollView(
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        height: 250,
                        width: 300,
                        decoration: const BoxDecoration(
                            image: DecorationImage(
                                image: AssetImage("assets/contact2.png"))),
                      ),
                    ],
                  ),
                  const Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Expanded(
                        child: Padding(
                          padding: EdgeInsets.symmetric(horizontal: 20),
                          child: Text("يمكنك الاتصال بنا في اي وقت",
                              maxLines: 2,
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 18,
                                  fontWeight: FontWeight.w600)),
                        ),
                      )
                    ],
                  ),
                  const SizedBox(height: 8),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Expanded(
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 20),
                          child: Text("لديك مشكل في التطبيق أو بلاغ",
                              maxLines: 2,
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                color: Colors.grey.shade300,
                                fontSize: 14,
                              )),
                        ),
                      )
                    ],
                  ),
                  const SizedBox(height: 20),
                  GetBuilder<ContactController>(builder: (context) {
                    return !controller.loading
                        ? Column(
                            children: [
                              ...controller.listContact.map(
                                (e) {
                                  return Padding(
                                    padding:
                                        const EdgeInsets.symmetric(vertical: 8),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceEvenly,
                                      children: [
                                        ElevatedButton(
                                            onPressed: () async {
                                              if (!(e['scheme'] as String)
                                                  .startsWith("https")) {
                                                launchUrl(Uri(
                                                    scheme:
                                                        e['scheme'] as String,
                                                    path:
                                                        e['path'] as String?));
                                              } else {
                                                if (await canLaunchUrl(
                                                    Uri.parse(e['scheme']
                                                        as String))) {
                                                  launchUrl(
                                                      Uri.parse(e['scheme']
                                                          as String),
                                                      mode: LaunchMode
                                                          .externalApplication);
                                                }
                                              }
                                            },
                                            style: ButtonStyle(
                                              shape: WidgetStateProperty.all(
                                                  RoundedRectangleBorder(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              20))),
                                            ),
                                            child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              children: [
                                                Directionality(
                                                  textDirection:
                                                      TextDirection.ltr,
                                                  child: Text(
                                                    e['name'] as String,
                                                    style: const TextStyle(
                                                        fontWeight:
                                                            FontWeight.bold,
                                                        fontSize: 18),
                                                  ),
                                                ),
                                                const SizedBox(width: 8),
                                                e['icon'] as Icon,
                                              ],
                                            ))
                                      ],
                                    ),
                                  );
                                },
                              ),
                            ],
                          )
                        : const SizedBox(
                            width: 40,
                            height: 40,
                            child: CircularProgressIndicator(
                              color: Config.secondColor,
                            ));
                  })
                ],
              ),
            )),
      ),
    );
  }
}
