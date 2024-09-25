import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:wallpaper_app/constants_dashboard.dart';
import 'package:wallpaper_app/core/config.dart';
import 'package:wallpaper_app/pages/client/register/register_controller.dart';

import 'package:get/get.dart';
import 'package:rflutter_alert/rflutter_alert.dart';

class RegisterView extends StatelessWidget {
  final controller = Get.put(RegisterController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Config.primaryColor,
      body: SafeArea(
        child: Directionality(
          textDirection: TextDirection.rtl,
          child: ListView(
            children: <Widget>[
              Column(
                children: <Widget>[
                  Stack(
                    alignment: Alignment.bottomCenter,
                    children: <Widget>[
                      const SizedBox(height: 180),
                      Align(
                        alignment: Alignment.bottomCenter,
                        child: Container(
                          height: 110,
                          width: 110,
                          decoration: const BoxDecoration(
                              image: DecorationImage(
                                  image: AssetImage("assets/logo.png"),
                                  fit: BoxFit.fitWidth,
                                  alignment: Alignment.bottomCenter)),
                        ),
                      ),
                    ],
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          // Text(
                          //   Config().NameApp,
                          //   style: TextStyle(
                          //     fontSize: 24,
                          //     fontWeight: FontWeight.bold,
                          //     color: Config().PrimaryColor,
                          //   ),
                          // ),
                          // Text(
                          //   " مرحبا بكم ",
                          //   style: TextStyle(
                          //     fontSize: 16,
                          //     fontWeight: FontWeight.bold,
                          //     color: Config.SecendColor,
                          //   ),
                          // ),
                        ],
                      ),
                      const SizedBox(height: 30),
                      Text(
                        "إنشاء حساب جديد",
                        style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: Colors.grey.shade100),
                      ),
                      const SizedBox(height: 20),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 30),
                        child: Container(
                          width: 350,
                          child: TextFormField(
                            validator: (value) {
                              if (value!.isEmpty) {
                                return 'Please enter some text';
                              }
                            },
                            style: const TextStyle(
                                fontSize: 16, fontWeight: FontWeight.w600),
                            controller: controller.usernameController,
                            keyboardType: TextInputType.text,
                            decoration: const InputDecoration(
                              filled: true,
                              contentPadding: EdgeInsets.all(12.0),
                              border: OutlineInputBorder(
                                  borderSide: BorderSide(
                                      color: Colors.amber, width: 0.1)),
                              fillColor:
                                  isDashboard ? secondaryColor : Colors.white,
                              prefixIcon: Icon(Icons.person_outline_rounded),
                              hintText: 'إسم المستخدم',
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(height: 16),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 30),
                        child: Container(
                          width: 350,
                          child: TextFormField(
                            validator: (value) {
                              if (value!.isEmpty) {
                                return 'Please enter some text';
                              }
                            },
                            style: TextStyle(
                                fontSize: 16, fontWeight: FontWeight.w600),
                            controller: controller.emailController,
                            keyboardType: TextInputType.text,
                            decoration: InputDecoration(
                              filled: true,
                              contentPadding: const EdgeInsets.all(12.0),
                              border: OutlineInputBorder(
                                  borderSide: BorderSide(
                                      color: Colors.amber, width: 0.1)),
                              fillColor:
                                  isDashboard ? secondaryColor : Colors.white,
                              // prefixIcon: Column(
                              //   mainAxisAlignment: MainAxisAlignment.center,
                              //   children: [
                              //     Text(
                              //       controller.countryCode,
                              //       style: TextStyle(
                              //           fontSize: 16,
                              //           fontWeight: FontWeight.w600),
                              //     ),
                              //   ],
                              // ),
                              prefixIcon: Icon(Icons.email_outlined),
                              hintText: 'البريد الإلكتروني',
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(height: 16),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 30),
                        child: Container(
                          width: 350,
                          child: TextFormField(
                            validator: (value) {
                              if (value!.isEmpty) {
                                return 'Please enter some text';
                              }
                            },
                            style: const TextStyle(
                                fontSize: 16, fontWeight: FontWeight.w600),
                            controller: controller.passController,
                            keyboardType: TextInputType.text,
                            obscureText: true,
                            decoration: InputDecoration(
                              filled: true,
                              contentPadding: const EdgeInsets.all(12.0),
                              border: OutlineInputBorder(
                                  borderSide: BorderSide(
                                      color: Colors.amber, width: 0.1)),
                              fillColor:
                                  isDashboard ? secondaryColor : Colors.white,
                              prefixIcon: Icon(Icons.password_outlined),
                              hintText: 'كلمة المرور',
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(height: 16),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 30),
                        child: SizedBox(
                          width: 350,
                          child: TextFormField(
                            validator: (value) {
                              if (value!.isEmpty) {
                                return 'Please enter some text';
                              }
                            },
                            style: const TextStyle(
                                fontSize: 16, fontWeight: FontWeight.w600),
                            controller: controller.confirmPassController,
                            keyboardType: TextInputType.text,
                            obscureText: true,
                            decoration: const InputDecoration(
                              filled: true,
                              contentPadding: EdgeInsets.all(12.0),
                              border: OutlineInputBorder(
                                  borderSide: BorderSide(
                                      color: Colors.amber, width: 0.1)),
                              fillColor:
                                  isDashboard ? secondaryColor : Colors.white,
                              prefixIcon: Icon(Icons.password_outlined),
                              hintText: ' تأكيد كلمة المرور',
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(height: 40),
                      Padding(
                        padding: const EdgeInsets.only(top: 5),
                        child: SizedBox(
                          width: 350,
                          child: MaterialButton(
                            onPressed: () async {
                              controller.login();
                            },
                            color: Config.secondColor,
                            elevation: 2,
                            minWidth: 350,
                            height: 50,
                            textColor: Colors.white,
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(4)),
                            child: const Text(
                              'موافق ',
                              style: TextStyle(
                                  fontSize: 16,
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold),
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(height: 40),
                      Text(
                        "لديك حساب؟",
                        style: TextStyle(color: Colors.grey.shade300),
                      ),
                      const SizedBox(height: 8),
                      Padding(
                        padding: const EdgeInsets.only(top: 5),
                        child: SizedBox(
                          width: 350,
                          height: 40,
                          child: OutlinedButton(
                            onPressed: () async {
                              Get.back();
                            },
                            style: ButtonStyle(
                              side: WidgetStateProperty.all<BorderSide>(
                                  BorderSide(width: 1, color: Colors.white)),
                            ),
                            child: const Text('تسجيل الدخول',
                                style: TextStyle(
                                    fontSize: 16,
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold)),
                          ),
                        ),
                      ),
                      const SizedBox(height: 10),
                    ],
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }

  showAlert(String task, context) async {
    Alert(
        context: context,
        title: "",
        content: Column(
          children: <Widget>[
            Text(
              task,
              style: TextStyle(fontSize: 16),
            )
          ],
        ),
        buttons: [
          DialogButton(
            color: Colors.amberAccent,
            onPressed: () => Navigator.pop(context),
            child: Text(
              "موافق",
              style: TextStyle(color: Colors.white, fontSize: 20),
            ),
          )
        ]).show();
  }
}
