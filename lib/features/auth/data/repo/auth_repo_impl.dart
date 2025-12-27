import 'package:dio/dio.dart';
import 'package:e_commerce/core/di/di.dart';
import 'package:e_commerce/core/errors/results.dart';
import 'package:e_commerce/features/auth/data/data_source/contract/api_data_source.dart';
import 'package:e_commerce/features/auth/data/data_source/contract/local_data_source.dart';
import 'package:e_commerce/features/auth/data/models/auth_response/auth_response.dart';
import 'package:e_commerce/features/auth/data/models/login_request.dart';
import 'package:e_commerce/features/auth/data/models/register_request.dart';
import 'package:e_commerce/features/auth/domain/repo/auth_repo.dart';
import 'package:injectable/injectable.dart';

@Injectable(as: AuthRepo)
class AuthRepoImpl implements AuthRepo {
  final ApiDataSource _apiDataSource;
  final LocalDataSource _localDateSource;
  AuthRepoImpl(this._apiDataSource, this._localDateSource);
  @override
  Future<Results<String>> signUp(RegisterRequest request) async {
    final response = await _apiDataSource.signUp(request);

    return switch (response) {
      Success<AuthResponse>() => Success(
        response.data?.message ?? 'Successfully Registered',
      ),

      Failure<AuthResponse>() => Failure(
        exception: response.exception,
        message: response.message,
      ),
    };
  }

  @override
  Future<Results<String>> signIn(LoginRequest request) async {
    final response = await _apiDataSource.logIn(request);
    switch (response) {
      case Success<AuthResponse>():
        {
          _localDateSource.saveToke(response.data?.token ?? '');
          getIt<Dio>().options.headers["token"] = response.data?.token ?? "";
          return Success(response.data?.message ?? 'success');
        }

      case Failure<AuthResponse>():
        {
          return Failure(
            message: response.message,
            exception: response.exception,
          );
        }
    }
  }
}
