import 'package:e_commerce/core/base/base_status.dart';
import 'package:e_commerce/features/auth/data/models/register_request.dart';

class RegisterState {
  BaseStatus<String> registerState;
  RegisterState({this.registerState = const BaseStatus.initial()});
  RegisterState copyWith({BaseStatus<String>? registerState}) {
    return RegisterState(registerState: registerState ?? this.registerState);
  }
}

sealed class RegisterAction {}

final class RegisterUser extends RegisterAction {
  final RegisterRequest registerRequest;
  RegisterUser(this.registerRequest);
}

sealed class RegisterNavigationAction {}

final class RegisterNavigationToLogin extends RegisterNavigationAction {}

final class ShowScaffoldMessenger extends RegisterNavigationAction {
  final String message;
  ShowScaffoldMessenger(this.message);
}
