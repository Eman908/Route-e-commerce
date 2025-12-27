import 'dart:async';
import 'package:e_commerce/core/base/base_status.dart';
import 'package:e_commerce/core/routing/routes.dart';
import 'package:e_commerce/core/theme/app_colors.dart';
import 'package:e_commerce/core/utils/context_extension.dart';
import 'package:e_commerce/core/utils/validation.dart';
import 'package:e_commerce/core/utils/whitespace_extension.dart';
import 'package:e_commerce/features/auth/data/models/login_request.dart';
import 'package:e_commerce/features/auth/presentation/login/cubit/login_cubit.dart';
import 'package:e_commerce/features/auth/presentation/login/cubit/login_state.dart';
import 'package:e_commerce/features/auth/presentation/widgets/custom_text_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LoginView extends StatefulWidget {
  const LoginView({super.key});

  @override
  State<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  TextEditingController email = TextEditingController();
  TextEditingController pass = TextEditingController();
  late StreamSubscription nav;
  late LoginCubit cubit;
  final GlobalKey<FormState> _formKey = GlobalKey();
  @override
  void initState() {
    super.initState();
    cubit = context.read<LoginCubit>();
    nav = cubit.navigation.listen((navEvent) {
      switch (navEvent) {
        case LoginNavigationToHome():
          {
            Navigator.of(context).pushReplacementNamed(Routes.mainRoute);
          }

        case LoginShowScaffoldMessage():
          {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(
                  navEvent.message,
                  style: context.textStyle.bodySmall,
                ),
                backgroundColor: AppColors.white,
              ),
            );
          }
        case LoginNavigationToRegister():
          Navigator.of(context).pushNamed(Routes.registerRoute);
      }
    });
  }

  @override
  void dispose() {
    email.dispose();
    pass.dispose();
    nav.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: context.colors.primary,
      body: BlocBuilder<LoginCubit, LoginState>(
        builder: (context, state) {
          return SafeArea(
            child: SingleChildScrollView(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Form(
                key: _formKey,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Image.asset(
                      width: double.infinity,
                      height: context.heightSize * 0.1,
                      'assets/images/logo.png',
                    ),
                    32.heightSpace,
                    Text(
                      'Welcome Back To Route',
                      style: context.textStyle.titleLarge!.copyWith(
                        color: AppColors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 24,
                      ),
                    ),
                    Text(
                      'Please sign in with your mail',
                      style: context.textStyle.labelSmall,
                    ),
                    24.heightSpace,
                    CustomTextFormField(
                      validator: (value) {
                        return Validation.validateEmail(value);
                      },

                      keyboardType: TextInputType.emailAddress,
                      prefix: Icons.email,
                      hintText: 'Email',
                      controller: email,
                      enabled: state.loginState.status != Status.loading,
                    ),
                    24.heightSpace,

                    CustomTextFormField(
                      validator: (value) {
                        return Validation.validatePassword(value);
                      },

                      prefix: Icons.lock,
                      keyboardType: TextInputType.visiblePassword,
                      suffix: InkWell(
                        onTap: () {
                          cubit.doAction(PasswordVisibility());
                        },
                        child: Icon(
                          state.isVisible
                              ? Icons.visibility
                              : Icons.visibility_off,
                        ),
                      ),
                      hintText: 'Password',
                      isPassword: !state.isVisible,
                      controller: pass,
                      enabled: state.loginState.status != Status.loading,
                    ),
                    TextButton(
                      onPressed: () {
                        // Navigator.of(
                        //   context,
                        // ).pushNamed(Routes.forgetRoute, arguments: email.text);
                        // ScaffoldMessenger.of(context).showSnackBar(
                        //   const SnackBar(content: Text('code sent to ur email')),
                        // );
                      },
                      child: Align(
                        alignment: AlignmentGeometry.centerRight,
                        child: Text(
                          'forget password',
                          style: context.textStyle.labelSmall,
                        ),
                      ),
                    ),
                    24.heightSpace,

                    SizedBox(
                      width: double.infinity,
                      height: 56,
                      child: FilledButton(
                        onPressed: state.loginState.status == Status.loading
                            ? null
                            : () {
                                if (_formKey.currentState!.validate()) {
                                  var request = LoginRequest(
                                    email: email.text,
                                    password: pass.text,
                                  );

                                  cubit.doAction(LoginUser(request));
                                }
                              },
                        child: state.loginState.status == Status.loading
                            ? const CircularProgressIndicator(
                                constraints: BoxConstraints(
                                  minHeight: 24,
                                  minWidth: 24,
                                ),
                                color: Colors.amber,
                              )
                            : const Text('Log In'),
                      ),
                    ),
                    24.heightSpace,
                    TextButton(
                      onPressed: () {
                        cubit.emitNavigation(LoginNavigationToRegister());
                      },
                      child: Text(
                        "Don't have an account? Create Account",
                        style: context.textStyle.bodyMedium,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
