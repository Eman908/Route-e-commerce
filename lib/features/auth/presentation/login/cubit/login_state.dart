import 'package:e_commerce/core/base/base_status.dart';
import 'package:e_commerce/features/auth/data/models/login_request.dart';

class LoginState {
  final BaseStatus loginState;
  final bool isVisible;
  const LoginState({
    this.loginState = const BaseStatus.initial(),
    this.isVisible = false,
  });

  LoginState copyWith({BaseStatus? loginState, bool? isVisible}) {
    return LoginState(
      loginState: loginState ?? this.loginState,
      isVisible: isVisible ?? this.isVisible,
    );
  }
}

sealed class LoginAction {}

class LoginUser extends LoginAction {
  final LoginRequest loginRequest;
  LoginUser(this.loginRequest);
}

class PasswordVisibility extends LoginAction {}

sealed class LoginNavigation {}

class LoginNavigationToHome extends LoginNavigation {}

class LoginNavigationToRegister extends LoginNavigation {}

class LoginShowScaffoldMessage extends LoginNavigation {
  final String message;
  LoginShowScaffoldMessage(this.message);
}
