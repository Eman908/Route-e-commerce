import 'package:e_commerce/core/base/base_status.dart';
import 'package:e_commerce/features/auth/data/models/register_request.dart';

class RegisterState {
  final BaseStatus<String> registerState;
  final bool isVisible;
  final bool isVisible2;
  RegisterState({
    this.registerState = const BaseStatus.initial(),
    this.isVisible = false,
    this.isVisible2 = false,
  });
  RegisterState copyWith({
    BaseStatus<String>? registerState,
    bool? isVisible,
    bool? isVisible2,
  }) {
    return RegisterState(
      registerState: registerState ?? this.registerState,
      isVisible2: isVisible2 ?? this.isVisible2,
      isVisible: isVisible ?? this.isVisible,
    );
  }
}

sealed class RegisterAction {}

final class RegisterUser extends RegisterAction {
  final RegisterRequest registerRequest;
  RegisterUser(this.registerRequest);
}

final class PasswordVisibility extends RegisterAction {}

final class RePasswordVisibility extends RegisterAction {}

sealed class RegisterNavigationAction {}

final class RegisterNavigationToLogin extends RegisterNavigationAction {}

final class ShowScaffoldMessenger extends RegisterNavigationAction {
  final String message;
  ShowScaffoldMessenger(this.message);
}
