import 'package:dio/dio.dart';
import 'package:e_commerce/core/constants/api_constants.dart';
import 'package:e_commerce/core/constants/app_constants.dart';
import 'package:e_commerce/core/di/di.dart';
import 'package:flutter/foundation.dart';
import 'package:injectable/injectable.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';
import 'package:shared_preferences/shared_preferences.dart';

@module
abstract class DioModule {
  @singleton
  Dio dioProvider() {
    Dio dio = Dio();
    SharedPreferences preferences = getIt();
    var token = preferences.getString(AppConstants.token);
    Map<String, dynamic> headers = {};
    if (token != null) {
      headers["token"] = token;
    }
    dio.options = BaseOptions(
      baseUrl: ApiConstants.baseUrl,
      headers: headers,
      receiveTimeout: const Duration(seconds: 120),
      sendTimeout: const Duration(seconds: 120),
      connectTimeout: const Duration(seconds: 120),
      validateStatus: (state) => true,
    );
    dio.interceptors.add(
      PrettyDioLogger(
        requestHeader: true,
        requestBody: true,
        responseBody: true,
        responseHeader: false,
        maxWidth: 90,
        compact: false,
        enabled: kDebugMode,
      ),
    );
    return dio;
  }
}
