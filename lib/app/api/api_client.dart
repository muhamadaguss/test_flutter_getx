import 'package:dio/dio.dart' as dio;
import 'package:dio/native_imp.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';
import 'package:test_project/app/routes/app_pages.dart';

class ApiClient extends DioForNative {
  ApiClient() : super() {
    var urlHOST = dotenv.env['URL'];
    final box = GetStorage();
    options = dio.BaseOptions(
      baseUrl: urlHOST!,
      connectTimeout: 1000 * 60,
      receiveTimeout: (options.connectTimeout * 0.6).toInt(),
      validateStatus: (status) {
        return true;
      },
    );

    interceptors.add(PrettyDioLogger(
      requestBody: true,
      requestHeader: true,
      // responseBody: false,
    ));

    interceptors
        .add(dio.InterceptorsWrapper(onRequest: (options, handler) async {
      options.headers = <String, dynamic>{
        "token": 'Bearer ${box.read('token')}',
      };
      return handler.next(options);
    }, onResponse: (dio.Response response, handler) {
      _ifTokenExpired(response);
      return handler.next(response);
    }, onError: (dio.DioError e, handler) {
      if (e.type == dio.DioErrorType.connectTimeout) {
        // Handle request time out

        // tokenRTO(e.response);
        //  return tokenRTO(e.response);
      }
      _ifTokenExpired(e.response);
      return handler.next(e);
    }));
  }
}

void _ifTokenExpired(dio.Response<dynamic>? response) {
  final box = GetStorage();
  if (response?.statusCode == 91) {
    box.remove('token');
    Get.offAllNamed(Routes.LOGIN);
  }

  if ((response?.statusCode == 400 || response?.statusCode == 401) &&
      response?.data is Map<String, dynamic>) {
    if (response?.data['message'] is String) {
      final message = (response?.data['message'] as String).toLowerCase();

      if (message.contains('token') && message.contains('expired')) {
        box.remove('token');
        Get.offAllNamed(Routes.LOGIN);
      }
    }
  }
}
