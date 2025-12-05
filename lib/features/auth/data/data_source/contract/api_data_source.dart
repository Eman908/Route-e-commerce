import 'package:e_commerce/core/errors/results.dart';
import 'package:e_commerce/features/auth/data/models/auth_response/auth_response.dart';
import 'package:e_commerce/features/auth/data/models/login_request.dart';
import 'package:e_commerce/features/auth/data/models/register_request.dart';

abstract class ApiDataSource {
  Future<Results<AuthResponse>> signUp(RegisterRequest body);
  Future<Results<AuthResponse>> logIn(LoginRequest body);
}
