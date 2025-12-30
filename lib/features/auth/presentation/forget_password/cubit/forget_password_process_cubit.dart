import 'package:e_commerce/core/base/base_cubit.dart';
import 'package:e_commerce/core/base/base_status.dart';
import 'package:e_commerce/core/di/di.dart';
import 'package:e_commerce/core/errors/results.dart';
import 'package:e_commerce/features/auth/domain/repo/auth_repo.dart';
import 'package:e_commerce/features/auth/presentation/forget_password/cubit/forget_password_process_state.dart';
import 'package:injectable/injectable.dart';

@injectable
class ForgetPasswordProcessCubit
    extends
        BaseCubit<
          ForgetPasswordProcessState,
          ForgetPasswordProcessActions,
          void
        > {
  ForgetPasswordProcessCubit() : super(ForgetPasswordProcessState());
  final AuthRepo _authRepo = getIt();
  @override
  Future<void> doAction(ForgetPasswordProcessActions action) async {
    switch (action) {
      case SendCode():
        await _sendCode(action.email);
      case VerifyCode():
        await _verifyCode(action.code);
      case ResetPassword():
        await _resetPassword(action.email, action.password);
    }
  }

  Future<void> _resetPassword(String email, String password) async {
    safeEmit(state.copyWith(resetPassword: const BaseStatus.loading()));
    var response = await _authRepo.resetPassword(email, password);
    switch (response) {
      case Success<String>():
        safeEmit(
          state.copyWith(
            resetPassword: BaseStatus.success(data: response.data),
          ),
        );

      case Failure<String>():
        safeEmit(
          state.copyWith(
            resetPassword: BaseStatus.failure(message: response.message),
          ),
        );
    }
  }

  Future<void> _verifyCode(String code) async {
    safeEmit(state.copyWith(verifyCode: const BaseStatus.loading()));
    var response = await _authRepo.verifyCode(code);
    switch (response) {
      case Success<String>():
        safeEmit(
          state.copyWith(verifyCode: BaseStatus.success(data: response.data)),
        );
      case Failure<String>():
        safeEmit(
          state.copyWith(
            verifyCode: BaseStatus.failure(message: response.message),
          ),
        );
    }
  }

  Future<void> _sendCode(String email) async {
    safeEmit(state.copyWith(forgetPassword: const BaseStatus.loading()));
    var response = await _authRepo.forgetPassword(email);
    switch (response) {
      case Success<String>():
        safeEmit(
          state.copyWith(
            forgetPassword: BaseStatus.success(data: response.data),
          ),
        );
      case Failure<String>():
        safeEmit(
          state.copyWith(
            forgetPassword: BaseStatus.failure(message: response.message),
          ),
        );
    }
  }
}
