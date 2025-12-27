import 'package:e_commerce/core/base/base_cubit.dart';
import 'package:e_commerce/core/base/base_status.dart';
import 'package:e_commerce/core/di/di.dart';
import 'package:e_commerce/core/errors/results.dart';
import 'package:e_commerce/features/auth/domain/use_case/sign_up_use_case.dart';
import 'package:e_commerce/features/auth/presentation/register/cubit/register_state.dart';
import 'package:injectable/injectable.dart';

@injectable
class RegisterCubit
    extends BaseCubit<RegisterState, RegisterAction, RegisterNavigationAction> {
  RegisterCubit() : super(RegisterState());
  SignUpUseCase useCase = getIt();

  @override
  Future<void> doAction(RegisterAction action) async {
    switch (action) {
      case RegisterUser():
        await _register(action);
      case PasswordVisibility():
        _passwordVisibility();
      case RePasswordVisibility():
        _rePasswordVisibility();
    }
  }

  void _rePasswordVisibility() {
    safeEmit(state.copyWith(isVisible2: !state.isVisible2));
  }

  void _passwordVisibility() {
    safeEmit(state.copyWith(isVisible: !state.isVisible));
  }

  Future<void> _register(RegisterUser action) async {
    safeEmit(state.copyWith(registerState: const BaseStatus.loading()));

    var response = await useCase.signUp(action.registerRequest);

    switch (response) {
      case Success<String>():
        safeEmit(
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
        safeEmit(
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
