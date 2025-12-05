import 'package:e_commerce/core/errors/results.dart';
import 'package:e_commerce/features/auth/data/models/login_request.dart';
import 'package:e_commerce/features/auth/data/models/register_request.dart';
import 'package:e_commerce/features/auth/domain/repo/auth_repo.dart';

class SignUpUseCase {
  final AuthRepo _authRepo;
  SignUpUseCase(this._authRepo);
  Future<Results<String>> signUp(RegisterRequest request) {
    return _authRepo.signUp(request);
  }

  Future<Results<String>> signIn(LoginRequest request) {
    return _authRepo.signIn(request);
  }
}
