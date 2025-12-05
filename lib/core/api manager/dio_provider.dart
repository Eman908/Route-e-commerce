import 'package:dio/dio.dart';
import 'package:e_commerce/core/constants/api_constants.dart';
import 'package:flutter/foundation.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';

Dio dioProvider() {
  Dio dio = Dio();
  dio.options = BaseOptions(
    baseUrl: ApiConstants.baseUrl,
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
