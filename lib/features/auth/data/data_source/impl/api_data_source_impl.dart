import 'package:e_commerce/core/api%20manager/api_client.dart';
import 'package:e_commerce/core/errors/results.dart';
import 'package:e_commerce/core/errors/safe_call.dart';
import 'package:e_commerce/features/auth/data/data_source/contract/api_data_source.dart';
import 'package:e_commerce/features/auth/data/models/auth_response/auth_response.dart';
import 'package:e_commerce/features/auth/data/models/login_request.dart';
import 'package:e_commerce/features/auth/data/models/register_request.dart';
import 'package:injectable/injectable.dart';

@Injectable(as: ApiDataSource)
class ApiDataSourceImpl implements ApiDataSource {
  final ApiClient _apiClient;
  ApiDataSourceImpl(this._apiClient);
  @override
  Future<Results<AuthResponse>> signUp(RegisterRequest body) async {
    return safeCall(() async {
      var response = await _apiClient.signUp(body);

      if (response.user == null) {
        return Failure(exception: Exception(), message: response.message);
      }

      return Success(response);
    });
  }

  @override
  Future<Results<AuthResponse>> logIn(LoginRequest body) async {
    return safeCall(() async {
      var response = await _apiClient.logIn(body);
      if (response.user == null) {
        return Failure(exception: Exception(), message: response.message);
      }
      return Success(response);
    });
  }
}
