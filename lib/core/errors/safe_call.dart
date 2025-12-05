import 'dart:async';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:e_commerce/core/errors/results.dart';

Future<Results<T>> safeCall<T>(Future<Results<T>> Function() call) async {
  try {
    return await call();
  } on DioException catch (e) {
    return Failure(exception: e, message: _mapDioMessage(e));
  } on TimeoutException catch (e) {
    return Failure(exception: e, message: 'Request timeout');
  } on SocketException catch (e) {
    return Failure(exception: e, message: 'No internet connection');
  } on IOException catch (e) {
    return Failure(exception: e, message: 'Network error');
  } catch (e) {
    return Failure(exception: Exception(e.toString()), message: e.toString());
  }
}

String _mapDioMessage(DioException e) {
  switch (e.type) {
    case DioExceptionType.connectionTimeout:
      return 'Connection timeout';
    case DioExceptionType.sendTimeout:
      return 'Send timeout';
    case DioExceptionType.receiveTimeout:
      return 'Receive timeout';
    case DioExceptionType.badCertificate:
      return 'Bad SSL certificate';
    case DioExceptionType.badResponse:
      return 'Server error';
    case DioExceptionType.cancel:
      return 'Request cancelled';
    case DioExceptionType.connectionError:
      return 'No internet connection';
    case DioExceptionType.unknown:
      return 'Unexpected network error';
  }
}
