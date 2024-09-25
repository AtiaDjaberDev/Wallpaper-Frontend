import 'dart:io';

import 'package:ffmpeg_kit_flutter_audio/ffmpeg_kit.dart';
import 'package:ffmpeg_kit_flutter_audio/log.dart';
import 'package:ffmpeg_kit_flutter_audio/return_code.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/foundation.dart';
// import 'package:flutter_ffmpeg/flutter_ffmpeg.dart';
import 'package:path_provider/path_provider.dart';

// final FlutterFFmpeg _flutterFFmpeg = FlutterFFmpeg();

/// Compress audio file and return the compressed file
Future<File?> compressAudio(PlatformFile? inputFile) async {
  if (!kIsWeb && Platform.isAndroid && inputFile != null) {
    // Temproray directory to save the compress audio file
    final directory = await getTemporaryDirectory();

    String newFilePath =
        inputFile.path!.replaceAll(inputFile.name, "audiofile");
    File(inputFile.path!).renameSync(newFilePath);

    final outputFilePath =
        '${directory.path}/${DateTime.now().toIso8601String()}compressed_audio.${inputFile.extension}';

    // To Compress audio file using libmp3lame encoder
    String ffmpegCommand =
        '-i $newFilePath -c:a libmp3lame -b:a 128k $outputFilePath';

    // Check execution output. Zero represents successful execution, 255 means user cancel and non-zero values represent failure
    // final result = await _flutterFFmpeg.execute(ffmpegCommand);
    final session = await FFmpegKit.execute(ffmpegCommand);
    final returnCode = await session.getReturnCode();
    final logs = await session.getAllLogs();
    for (Log log in logs) {
      print("LOG: ${log.getMessage()}");
    }
    // الحصول على رسالة الخطأ وطباعتها
    final failStackTrace = await session.getFailStackTrace();
    if (failStackTrace != null) {
      print("Error: $failStackTrace");
    }

    File(newFilePath).renameSync(inputFile.path!);

    if (ReturnCode.isSuccess(returnCode)) {
      return File(outputFilePath);
    } else {
      return null;
    }
    // final returnCode = await session.();
    // if (ReturnCode.isSuccess(returnCode)) {
    //   // النجاح - تم ضغط الملف
    //   print("تم ضغط الملف الصوتي بنجاح! المسار: $outputFilePath");
    // } else if (ReturnCode.isCancel(returnCode)) {
    //   // إلغاء - تم إلغاء العملية
    //   print("تم إلغاء عملية ضغط الصوت.");
    // } else {
    //   // فشل - هناك مشكلة في الضغط
    //   print("فشل ضغط الملف الصوتي.");
    // }
    // الحصول على السجلات وطباعتها
  } else {
    return null;
  }
}
