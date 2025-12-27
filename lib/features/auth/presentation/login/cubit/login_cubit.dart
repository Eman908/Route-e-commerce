import 'package:e_commerce/core/base/base_cubit.dart';
import 'package:e_commerce/core/base/base_status.dart';
import 'package:e_commerce/core/di/di.dart';
import 'package:e_commerce/core/errors/results.dart';
import 'package:e_commerce/features/auth/domain/use_case/sign_up_use_case.dart';
import 'package:e_commerce/features/auth/presentation/login/cubit/login_state.dart';
import 'package:injectable/injectable.dart';

@injectable
class LoginCubit extends BaseCubit<LoginState, LoginAction, LoginNavigation> {
  LoginCubit() : super(const LoginState());

  SignUpUseCase useCase = getIt();

  @override
  Future<void> doAction(LoginAction action) async {
    switch (action) {
      case LoginUser():
        _loginUser(action);
      case PasswordVisibility():
        _passwordVisibility();
    }
  }

  void _passwordVisibility() {
    safeEmit(state.copyWith(isVisible: !state.isVisible));
  }

  Future<void> _loginUser(LoginUser action) async {
    safeEmit(state.copyWith(loginState: const BaseStatus.loading()));

    var response = await useCase.signIn(action.loginRequest);
    switch (response) {
      case Success<String>():
        safeEmit(
          state.copyWith(loginState: BaseStatus.success(data: response.data)),
        );
        emitNavigation(LoginShowScaffoldMessage(response.data!));
        emitNavigation(LoginNavigationToHome());
      case Failure<String>():
        safeEmit(
          state.copyWith(
            loginState: BaseStatus.failure(
              message: response.message,
              exception: response.exception,
            ),
          ),
        );
        emitNavigation(LoginShowScaffoldMessage(response.message ?? 'Unknown'));
    }
  }
}
