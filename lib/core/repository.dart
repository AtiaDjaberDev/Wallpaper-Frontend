import 'dart:io';

import 'package:dio/dio.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/foundation.dart';
import 'package:wallpaper_app/pages/client/order/audio_controller.dart';
import 'package:get/get.dart' as getx;
import 'package:wallpaper_app/core/config.dart';
import 'package:wallpaper_app/core/helper/helper_function.dart';
import 'package:wallpaper_app/models/filter.dart';
import 'package:wallpaper_app/service/helper_service.dart';
import 'package:http_parser/src/media_type.dart';

var dioRequest = Dio()
  ..options = BaseOptions(headers: {'content-Type': 'application/json'});

final helperService = getx.Get.find<HelperService>();

addTokenToHeader(String token) {
  dioRequest.options.headers["authorization"] =
      token.startsWith("Bearer") ? token : "Bearer $token";
}

Future<Response> saveData(String resource, dynamic data) async {
  try {
    final response =
        await dioRequest.post(Config.baseServerUrl + resource, data: data);
    return response;
  } on DioException catch (ex) {
    print(ex.response);
    return ex.response!;
  }
}

addInterceptors() {
  dioRequest.interceptors.add(
    InterceptorsWrapper(
      onError: (e, handler) => errorInterceptor(e, handler),
      // onResponse: (e, handler) => onResponse(e, handler),
    ),
  );
}

// void onResponse(Response response, ResponseInterceptorHandler handler) {
//   final responseData = response.data;
//   if (responseData is Map &&
//       (responseData.keys.every(
//         (e) => ['success', 'data', 'message'].contains(e),
//       ))) {
//     return handler.next(response);
//   }
//   return handler.reject(
//     DioError(
//       requestOptions: response.requestOptions,
//       error: 'The response is not in valid format',
//     ),
//   );
// }

errorInterceptor(DioException error, ErrorInterceptorHandler handler) async {
  if (error.response?.statusCode == 401 ||
      error.response!.data.toString().contains("RouteNotFoundException")) {
    helperService.signOut();

    return handler.reject(DioException(requestOptions: error.requestOptions));
  }

  return handler.next(error);
}

Future<Response> updateData(String resource, dynamic data) async {
  try {
    final response = await dioRequest
        .put("${Config.baseServerUrl}$resource/${data["id"]}", data: data);
    return response;
  } on DioException catch (ex) {
    print(ex.response);

    return ex.response!;
  }
}

Future<Response> saveDataWithFile(String resource, Map<String, dynamic> data,
    PlatformFile? platformFile) async {
  try {
    if (platformFile != null) {
      final contentType = MediaType.parse('image/${platformFile.extension}');
      MultipartFile multipartFile;
      if (kIsWeb) {
        multipartFile = MultipartFile.fromBytes(platformFile.bytes!,
            filename: 'attachment.png', contentType: contentType);
      } else {
        if (Platform.isWindows) {
          multipartFile = await MultipartFile.fromFile(platformFile.path!,
              filename: 'attachment.png', contentType: contentType);
        } else {
          File optimizedFile = await compressFile(platformFile.path!);
          multipartFile = (await MultipartFile.fromFile(optimizedFile.path,
              filename: 'attachment.png', contentType: contentType));
        }
      }

      data["photo"] = multipartFile;
    }
    var formData = FormData.fromMap(data);
    Response response;
    if (data["id"] != null) {
      formData.fields.add(const MapEntry('_method', 'PUT'));
      resource = "$resource/${data["id"]}";
    }
    response =
        await dioRequest.post(Config.baseServerUrl + resource, data: formData);

    return response;
  } on DioException catch (ex) {
    print(ex.response);
    return ex.response!;
  }
}

Future<Response> saveDataWithAudio(String resource, Map<String, dynamic> data,
    PlatformFile? platformFile) async {
  try {
    if (platformFile != null) {
      final contentType = MediaType.parse('audio/${platformFile.extension}');
      MultipartFile multipartFile;
      if (kIsWeb) {
        multipartFile = MultipartFile.fromBytes(platformFile.bytes!,
            filename: 'attachment.wav', contentType: contentType);
      } else {
        multipartFile = (await MultipartFile.fromFile(platformFile.path!,
            filename: 'attachment.wav', contentType: contentType));
      }

      data["file"] = multipartFile;
    }
    var formData = FormData.fromMap(data);
    Response response =
        await dioRequest.post(Config.baseServerUrl + resource, data: formData);

    return response;
  } on DioException catch (ex) {
    print(ex.response);
    return ex.response!;
  }
}

Future<Response> saveDataWithXFile(
    String resource, Map<String, dynamic> data, File? file) async {
  try {
    if (file != null) {
      final contentType = MediaType.parse('audio/${file.path.split('.').last}');
      MultipartFile multipartFile;
      if (kIsWeb) {
        multipartFile = MultipartFile.fromBytes(file.readAsBytesSync(),
            filename: 'attachment.wav', contentType: contentType);
      } else {
        multipartFile = await MultipartFile.fromFile(file.path,
            filename: 'attachment.wav', contentType: contentType);
      }
      data["file"] = multipartFile;
    }
    var formData = FormData.fromMap(data);
    Response response =
        await dioRequest.post(Config.baseServerUrl + resource, data: formData);

    return response;
  } on DioException catch (ex) {
    print(ex.response);
    return ex.response!;
  }
}

Future<Response> getData(String resource, {Filter? filter}) async {
  try {
    Response response;
    if (filter == null) {
      response = await dioRequest.get(Config.baseServerUrl + resource);
    } else {
      response = await dioRequest
          .get("${Config.baseServerUrl}$resource?${filter.toQuery()}");
    }

    return response;
  } on DioException catch (ex) {
    print(ex.response);
    return ex.response!;
  }
}

void showDownloadProgress(received, total, int? id) {
  if (total != -1) {
    print((received / total * 100).toStringAsFixed(0) + "%");
    if (getx.Get.isRegistered<AudioController>()) {
      final controller = getx.Get.find<AudioController>();
      controller.progress((received / total * 100), id);
    }
  }
}

Future downloadFile(String url, String savePath, int? id) async {
  try {
    Response response = await dioRequest.get(
      url,
      onReceiveProgress: (received, total) =>
          showDownloadProgress(received, total, id),
      //Received data with List<int>
      options: Options(
          responseType: ResponseType.bytes,
          followRedirects: false,
          validateStatus: (status) {
            return status! < 500;
          }),
    );
    print(response.headers);
    File file = File(savePath);
    var raf = file.openSync(mode: FileMode.write);
    // response.data is List<int> type
    print(file.path);
    raf.writeFromSync(response.data);
    await raf.close();
  } catch (e) {
    print(e);
  }
}

Future<Response> deleteData(String resource, int id) async {
  try {
    final response =
        await dioRequest.delete("${Config.baseServerUrl}$resource/$id");
    return response;
  } on DioException catch (ex) {
    print(ex.response);
    return ex.response!;
  }
}
