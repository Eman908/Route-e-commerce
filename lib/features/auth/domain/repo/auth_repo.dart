import 'package:e_commerce/core/errors/results.dart';
import 'package:e_commerce/features/auth/data/models/login_request.dart';
import 'package:e_commerce/features/auth/data/models/register_request.dart';

abstract interface class AuthRepo {
  Future<Results<String>> signUp(RegisterRequest request);
  Future<Results<String>> signIn(LoginRequest request);
}
