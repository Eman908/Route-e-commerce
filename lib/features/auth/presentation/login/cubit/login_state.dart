import 'package:e_commerce/core/base/base_status.dart';
import 'package:e_commerce/features/auth/data/models/login_request.dart';

class LoginState {
  BaseStatus loginState;
  LoginState({this.loginState = const BaseStatus.initial()});
  LoginState copyWith({BaseStatus? loginState}) {
    return LoginState(loginState: loginState ?? this.loginState);
  }
}

sealed class LoginAction {}

class LoginUser extends LoginAction {
  final LoginRequest loginRequest;
  LoginUser(this.loginRequest);
}

sealed class LoginNavigation {}

class LoginNavigationToHome extends LoginNavigation {}

class LoginShowScaffoldMessage extends LoginNavigation {
  final String message;
  LoginShowScaffoldMessage(this.message);
}
