import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_image_compress/flutter_image_compress.dart';
import 'package:flutter_phone_direct_caller/flutter_phone_direct_caller.dart';
import 'package:wallpaper_app/core/config.dart';
import 'package:wallpaper_app/core/repository.dart';
import 'package:wallpaper_app/models/post.dart';
import 'package:path_provider/path_provider.dart';
import 'package:share_plus/share_plus.dart';
import 'dart:typed_data' as typed_data;

DecorationImage resolveImage(String? photo) {
  if (photo == null) {
    return const DecorationImage(
        image: AssetImage("assets/no-image.png"), fit: BoxFit.fill);
  }
  return DecorationImage(
      image: NetworkImage(
          photo.startsWith("http") ? photo : Config.storageUrl + photo),
      fit: BoxFit.fill);
}

String resolveImageUrl(String photo) {
  return photo.startsWith("http") ? photo : Config.storageUrl + photo;
}

Future<typed_data.Uint8List?> compressImageWeb(PlatformFile file) async {
  try {
    if (file.size < 1000000) {
      return null;
    }
    final result = await FlutterImageCompress.compressWithList(file.bytes!,
        minWidth: 1000,
        minHeight: 1000,
        quality: 97,
        format:
            file.extension == "png" ? CompressFormat.png : CompressFormat.jpeg);
    return result;
  } catch (e) {
    print(e);
    return null;
  }
}

Future<File> compressImage(PlatformFile file) async {
  File? compressedFile;
  var result = await FlutterImageCompress.compressWithFile(file.path!,
      minWidth: 500, minHeight: 500, quality: 94, format: CompressFormat.jpeg);

  final tempDir = await getTemporaryDirectory();
  var now = DateTime.now();
  compressedFile =
      await File('${tempDir.path}/${now.microsecondsSinceEpoch}image.jpg')
          .create();
  compressedFile.writeAsBytesSync(result!);

  return compressedFile;
}

callNumber(String number) async {
  return await FlutterPhoneDirectCaller.callNumber(number);
}

LinearGradient getGredient(int index) {
  List<Color> colors = [
    Colors.red,
    Colors.blue,
    Colors.green,
    Colors.purple,
    Colors.orange,
    Colors.pink,
    Colors.yellow,
    Colors.teal,
    Colors.indigo,
    Colors.brown,
    Colors.cyan,
    Colors.lime,
    Colors.lightBlue,
    Colors.lightGreen,
    Colors.deepOrange,
    Colors.deepPurple,
    Colors.amber,
    Colors.blueGrey,
    Colors.brown,
    Colors.cyan,
    Colors.deepOrange,
    Colors.deepPurple,
    Colors.green,
    Colors.indigo,
    Colors.lightBlue,
    Colors.lightGreen,
    Colors.lime,
    Colors.orange,
    Colors.pink,
    Colors.purple,
    Colors.red,
    Colors.teal,
    Colors.yellow,
  ];
  return LinearGradient(
    colors: [
      colors[index].withOpacity(0.5),
      colors[index].withOpacity(0.5),
      colors[index].withOpacity(0.2),
      colors[index]
    ],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );
}

downloadAttachment(Post post, bool isShare) async {
  var tempDir = await getTemporaryDirectory();
  var fileName = post.photo;
  String fullPath = "${tempDir.path}/$fileName";

  await downloadFile(resolveImageUrl(fileName!), fullPath, post.id, isShare);
  return fullPath;
}

Future<void> shareFile(Post post) async {
  final fullPath = await downloadAttachment(post, true);
  final result = await Share.shareXFiles([XFile(fullPath)],
      subject: " تطبيق ${Config.nameApp}", text: "استمتع");
  if (result.status == ShareResultStatus.dismissed) {
    print('Did you not like the pictures?');
  }
}

DecorationImage? universelImage(PlatformFile? file, String? photo) {
  if (file == null && photo == null) {
    return const DecorationImage(image: AssetImage("assets/no-image.png"));
  }
  return file != null
      ? (kIsWeb
          ? DecorationImage(image: MemoryImage(file.bytes!), fit: BoxFit.fill)
          : DecorationImage(
              image: FileImage(File(file.path!)), fit: BoxFit.fill))
      : (photo != null ? resolveImage(photo) : null);
}
