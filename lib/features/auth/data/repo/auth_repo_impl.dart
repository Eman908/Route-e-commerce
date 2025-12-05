import 'package:e_commerce/core/errors/results.dart';
import 'package:e_commerce/features/auth/data/data_source/contract/api_data_source.dart';
import 'package:e_commerce/features/auth/data/models/auth_response/auth_response.dart';
import 'package:e_commerce/features/auth/data/models/login_request.dart';
import 'package:e_commerce/features/auth/data/models/register_request.dart';
import 'package:e_commerce/features/auth/domain/repo/auth_repo.dart';

class AuthRepoImpl implements AuthRepo {
  final ApiDataSource _apiDataSource;
  AuthRepoImpl(this._apiDataSource);
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
    return switch (response) {
      Success<AuthResponse>() => Success(response.data?.message ?? 'success'),
      Failure<AuthResponse>() => Failure(
        message: response.message,
        exception: response.exception,
      ),
    };
  }
}
