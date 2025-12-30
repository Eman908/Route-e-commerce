import 'package:e_commerce/core/base/base_status.dart';

class ForgetPasswordProcessState {
  BaseStatus<String> forgetPassword;
  BaseStatus<String> verifyCode;
  BaseStatus<String> resetPassword;
  ForgetPasswordProcessState({
    this.forgetPassword = const BaseStatus.initial(),
    this.verifyCode = const BaseStatus.initial(),
    this.resetPassword = const BaseStatus.initial(),
  });
  ForgetPasswordProcessState copyWith({
    BaseStatus<String>? forgetPassword,
    BaseStatus<String>? verifyCode,
    BaseStatus<String>? resetPassword,
  }) {
    return ForgetPasswordProcessState(
      forgetPassword: forgetPassword ?? this.forgetPassword,
      verifyCode: verifyCode ?? this.verifyCode,
      resetPassword: resetPassword ?? this.resetPassword,
    );
  }
}

sealed class ForgetPasswordProcessActions {}

final class SendCode extends ForgetPasswordProcessActions {
  final String email;
  SendCode(this.email);
}

final class VerifyCode extends ForgetPasswordProcessActions {
  final String code;
  VerifyCode(this.code);
}

final class ResetPassword extends ForgetPasswordProcessActions {
  final String email;
  final String password;
  ResetPassword(this.email, this.password);
}
