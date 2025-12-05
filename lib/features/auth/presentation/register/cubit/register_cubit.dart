import 'package:e_commerce/core/api%20manager/api_client.dart';
import 'package:e_commerce/core/api%20manager/dio_provider.dart';
import 'package:e_commerce/core/base/base_cubit.dart';
import 'package:e_commerce/core/base/base_status.dart';
import 'package:e_commerce/core/errors/results.dart';
import 'package:e_commerce/features/auth/data/data_source/impl/api_data_source_impl.dart';
import 'package:e_commerce/features/auth/data/repo/auth_repo_impl.dart';
import 'package:e_commerce/features/auth/domain/use_case/sign_up_use_case.dart';
import 'package:e_commerce/features/auth/presentation/register/cubit/register_state.dart';

RegisterCubit ingection() {
  return RegisterCubit(
    SignUpUseCase(AuthRepoImpl(ApiDataSourceImpl(ApiClient(dioProvider())))),
  );
}

class RegisterCubit
    extends BaseCubit<RegisterState, RegisterAction, RegisterNavigationAction> {
  RegisterCubit(this.useCase) : super(RegisterState());
  SignUpUseCase useCase;

  @override
  Future<void> doAction(RegisterAction action) async {
    switch (action) {
      case RegisterUser():
        await _register(action);
    }
  }

  Future<void> _register(RegisterUser action) async {
    emit(state.copyWith(registerState: const BaseStatus.loading()));

    var response = await useCase.signUp(action.registerRequest);

    switch (response) {
      case Success<String>():
        emit(
          state.copyWith(
            registerState: BaseStatus.success(data: response.data),
          ),
        );
        emitNavigation(ShowScaffoldMessenger(response.data ?? 'Success'));

        emitNavigation(RegisterNavigationToLogin());

      case Failure<String>():
        emitNavigation(
          ShowScaffoldMessenger(response.message ?? 'Unknown error'),
        );
        emit(
          state.copyWith(
            registerState: BaseStatus.failure(
              exception: response.exception,
              message: response.message,
            ),
          ),
        );
    }
  }
}
