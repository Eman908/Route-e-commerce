import 'package:e_commerce/core/api%20manager/api_client.dart';
import 'package:e_commerce/core/api%20manager/dio_provider.dart';
import 'package:e_commerce/core/base/base_cubit.dart';
import 'package:e_commerce/core/base/base_status.dart';
import 'package:e_commerce/core/errors/results.dart';
import 'package:e_commerce/features/auth/data/data_source/impl/api_data_source_impl.dart';
import 'package:e_commerce/features/auth/data/repo/auth_repo_impl.dart';
import 'package:e_commerce/features/auth/domain/use_case/sign_up_use_case.dart';
import 'package:e_commerce/features/auth/presentation/login/cubit/login_state.dart';

LoginCubit injectionLogin() {
  return LoginCubit(
    SignUpUseCase(AuthRepoImpl(ApiDataSourceImpl(ApiClient(dioProvider())))),
  );
}

class LoginCubit extends BaseCubit<LoginState, LoginAction, LoginNavigation> {
  LoginCubit(this.useCase) : super(LoginState());
  SignUpUseCase useCase;

  @override
  Future<void> doAction(LoginAction action) async {
    switch (action) {
      case LoginUser():
        _loginUser(action);
    }
  }

  Future<void> _loginUser(LoginUser action) async {
    emit(state.copyWith(loginState: BaseStatus.loading()));
    var response = await useCase.signIn(action.loginRequest);
    switch (response) {
      case Success<String>():
        emit(
          state.copyWith(loginState: BaseStatus.success(data: response.data)),
        );
        emitNavigation(LoginShowScaffoldMessage(response.data!));
        emitNavigation(LoginNavigationToHome());
      case Failure<String>():
        emit(
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
