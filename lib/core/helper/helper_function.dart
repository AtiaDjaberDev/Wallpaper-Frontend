import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_image_compress/flutter_image_compress.dart';
import 'package:flutter_phone_direct_caller/flutter_phone_direct_caller.dart';
import 'package:wallpaper_app/core/config.dart';
import 'package:wallpaper_app/core/repository.dart';
import 'package:wallpaper_app/models/post.dart';
import 'package:path_provider/path_provider.dart';
import 'package:share_plus/share_plus.dart';

DecorationImage resolveImage(String? photo) {
  if (photo == null) {
    return const DecorationImage(
        image: AssetImage("assets/no-image.png"), fit: BoxFit.fill);
  }
  return DecorationImage(
      image: NetworkImage(
          photo!.startsWith("http") ? photo : Config.storageUrl + photo),
      fit: BoxFit.fill);
}

String resolveImageUrl(String photo) {
  return photo.startsWith("http") ? photo : Config.storageUrl + photo;
}

Future<File> compressFile(String path) async {
  File? compressedFile;

  var result = await FlutterImageCompress.compressWithFile(path,
      minWidth: 800, minHeight: 800, quality: 90, format: CompressFormat.jpeg);

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

shareFile(Post post) async {
  var tempDir = await getTemporaryDirectory();
  var fileName = post.attachment;
  String fullPath = "${tempDir.path}/$fileName";

  await downloadFile(Config.storageUrl + fileName!, fullPath, post.id);
  print(fullPath);
  final result = await Share.shareXFiles(
      [XFile(fullPath, mimeType: 'audio/mpeg')],
      subject: " تطبيق ملصقات صوتية", text: "استمتع بالملصق الصوتي");
  if (result.status == ShareResultStatus.dismissed) {
    print('Did you not like the pictures?');
  }
}
