import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:wallpaper_app/core/repository.dart';
import 'package:wallpaper_app/core/widget/custom_notification.dart';
import 'package:wallpaper_app/core/widget/confirm_dialog.dart';
import 'package:wallpaper_app/models/filter.dart';
import 'package:wallpaper_app/models/user.dart';
import 'package:wallpaper_app/service/helper_service.dart';

class UserController extends GetxController {
  List<User> listUsers = [];
  int itemCount = 0;
  var loading = false;
  Filter filter = Filter(page: 1);
  User user = User();
  final helperService = Get.find<HelperService>();
  String? nextPage;
  String? prevPage;
  ScrollController scrollController = ScrollController();
  TextEditingController searchController = TextEditingController();
  TextEditingController storeNameController = TextEditingController();
  TextEditingController storeTypeController = TextEditingController();

  List<Map<String, dynamic>> headers = [
    {"text": "المستخدم", "value": "username"},
    {"text": "الإيميل", "value": "email"},
    // {"text": "الهاتف", "value": "tel"},
  ];
  TextEditingController titleController = TextEditingController(text: "");
  TextEditingController descriptionController = TextEditingController(text: "");
  TextEditingController telController = TextEditingController(text: "");

  @override
  void onInit() {
    super.onInit();
    getUsers();
  }

  Future getUsers() async {
    try {
      loading = true;
      update();

      final response = await getData('users', filter: filter);
      if (response.statusCode == 200) {
        final data = response.data["data"];
        listUsers =
            (data["data"] as List).map((x) => User.fromJson(x)).toList();
        loading = false;
        filter.page = data["current_page"];
        nextPage = data["next_page_url"];
        prevPage = data["prev_page_url"];
        itemCount = data["total"];
        update();
      }
    } catch (error, stacktrace) {
      throw Exception("Exception occured: $error stackTrace: $stacktrace");
    }
  }

  PlatformFile? file;

  saveUser() async {
    user.username = titleController.text;
    user.tel = telController.text;

    var res = await saveDataWithFile(
        user.id == null ? "users/add" : "users/put/${user.id}",
        user.toJson(),
        file);
    if (res.statusCode == 200) {
      if (user.id == null) {
        User user = User.fromJson(res.data["data"]);

        listUsers.insert(0, user);
      } else {
        listUsers[listUsers.indexWhere((e) => e.id == user.id)] = user;
      }
      update();
      showNotification();
    } else {
      showNotification(title: 'فشلت العملية', isSuccess: false);
    }
  }

  Future pickFile() async {
    FilePickerResult? result = await FilePicker.platform
        .pickFiles(type: FileType.image, allowMultiple: false);

    if (result != null) {
      file = result.files.first;

      // var formData = dio.FormData.fromMap({
      //   'photo': await dio.MultipartFile.fromFile(
      //     result.files.first.bytes,
      //     filename: result.files.first.path?.split("/").last,
      //   )
      // });

      update();
    } else {
      print('No image selected.');
    }
  }

  @override
  void onClose() {
    super.onClose();
  }

  Future<void> deleteUser(Map<String?, dynamic> row) async {
    int id = row["id"];
    if (await showConfirmDialog()) {
      var res = await deleteData("users", id);
      if (res.statusCode == 200) {
        listUsers.removeWhere((element) => element.id == id);
        showNotification();
        itemCount--;
        update();
      }
    } else {
      print("cancelled");
    }
  }

  void initializeForm(Map<String?, dynamic> row) {
    user.id = row["id"];
    user.photo = row["photo"];
    titleController.text = row["name"] ?? "";
    storeNameController.text = row["store_name"] ?? "";
    storeTypeController.text = row["store_type"] ?? "";
    telController.text = row["tel"] ?? "";

    file = null;
    update();
  }

  Future<void> updateUser(User user) async {
    var res = await updateData("users", user.toJson());
    if (res.statusCode == 200) {
      listUsers[listUsers.indexWhere((e) => e.id == user.id)] = user;
      Get.back();
      update();
      showNotification();
    } else {
      showNotification(title: 'فشلت العملية', isSuccess: false);
    }
  }
}
