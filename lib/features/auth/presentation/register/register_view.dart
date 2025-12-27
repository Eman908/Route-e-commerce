import 'dart:async';
import 'package:e_commerce/core/base/base_status.dart';
import 'package:e_commerce/core/routing/routes.dart';
import 'package:e_commerce/core/theme/app_colors.dart';
import 'package:e_commerce/core/utils/context_extension.dart';
import 'package:e_commerce/core/utils/validation.dart';
import 'package:e_commerce/core/utils/whitespace_extension.dart';
import 'package:e_commerce/features/auth/data/models/register_request.dart';
import 'package:e_commerce/features/auth/presentation/register/cubit/register_cubit.dart';
import 'package:e_commerce/features/auth/presentation/register/cubit/register_state.dart';
import 'package:e_commerce/features/auth/presentation/widgets/custom_text_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class RegisterView extends StatefulWidget {
  const RegisterView({super.key});

  @override
  State<RegisterView> createState() => _RegisterViewState();
}

class _RegisterViewState extends State<RegisterView> {
  late RegisterCubit cubit;
  late StreamSubscription nav;
  TextEditingController name = TextEditingController();
  TextEditingController email = TextEditingController();
  TextEditingController pass = TextEditingController();
  TextEditingController rePass = TextEditingController();
  TextEditingController phone = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey();
  @override
  void initState() {
    cubit = context.read<RegisterCubit>();
    nav = cubit.navigation.listen((navigationState) {
      switch (navigationState) {
        case RegisterNavigationToLogin():
          {
            Navigator.of(context).pushReplacementNamed(Routes.loginRoute);
          }
        case ShowScaffoldMessenger():
          {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(
                  navigationState.message,
                  style: context.textStyle.bodySmall,
                ),
                backgroundColor: AppColors.white,
              ),
            );
          }
      }
    });

    super.initState();
  }

  @override
  void dispose() {
    nav.cancel();
    name.dispose();
    email.dispose();
    pass.dispose();
    rePass.dispose();
    phone.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        iconTheme: const IconThemeData(color: AppColors.white),
      ),
      backgroundColor: context.colors.primary,
      body: SafeArea(
        child: BlocBuilder<RegisterCubit, RegisterState>(
          builder: (context, state) {
            return SingleChildScrollView(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Form(
                key: _formKey,
                child: Column(
                  children: [
                    Image.asset(
                      width: double.infinity,
                      height: context.heightSize * 0.1,
                      'assets/images/logo.png',
                    ),
                    32.heightSpace,
                    CustomTextFormField(
                      enabled: state.registerState.status != Status.loading,

                      validator: (value) {
                        return Validation.validateName(value);
                      },
                      keyboardType: TextInputType.name,
                      prefix: Icons.person,
                      hintText: 'Name',
                      controller: name,
                    ),
                    16.heightSpace,
                    CustomTextFormField(
                      enabled: state.registerState.status != Status.loading,

                      validator: (value) {
                        return Validation.validateEmail(value);
                      },

                      keyboardType: TextInputType.emailAddress,
                      prefix: Icons.email,
                      hintText: 'Email',
                      controller: email,
                    ),
                    16.heightSpace,

                    CustomTextFormField(
                      enabled: state.registerState.status != Status.loading,

                      validator: (value) {
                        return Validation.validateEgyptianPhoneNumber(value);
                      },

                      keyboardType: TextInputType.phone,
                      prefix: Icons.phone,
                      hintText: 'Phone',
                      controller: phone,
                    ),
                    16.heightSpace,

                    CustomTextFormField(
                      enabled: state.registerState.status != Status.loading,

                      validator: (value) {
                        return Validation.validatePassword(value);
                      },

                      keyboardType: TextInputType.visiblePassword,
                      prefix: Icons.lock,
                      hintText: 'Password',
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
                      isPassword: !state.isVisible,
                      controller: pass,
                    ),
                    16.heightSpace,

                    CustomTextFormField(
                      enabled: state.registerState.status != Status.loading,

                      validator: (value) {
                        return Validation.validatePasswordConfirmation(
                          pass.text,
                          rePass.text,
                        );
                      },

                      keyboardType: TextInputType.visiblePassword,
                      prefix: Icons.lock,
                      suffix: InkWell(
                        onTap: () {
                          cubit.doAction(RePasswordVisibility());
                        },
                        child: Icon(
                          state.isVisible2
                              ? Icons.visibility
                              : Icons.visibility_off,
                        ),
                      ),
                      isPassword: !state.isVisible2,
                      hintText: 'Confirm Password',
                      controller: rePass,
                    ),
                    24.heightSpace,

                    SizedBox(
                      width: double.infinity,
                      height: 56,

                      child: FilledButton(
                        onPressed: () async {
                          if (_formKey.currentState!.validate()) {
                            var request = RegisterRequest(
                              name: name.text,
                              email: email.text,
                              password: pass.text,
                              phone: phone.text,
                              rePassword: rePass.text,
                            );
                            await cubit.doAction(RegisterUser(request));
                          }
                        },
                        child: state.registerState.status == Status.loading
                            ? const CircularProgressIndicator(
                                constraints: BoxConstraints(
                                  minHeight: 24,
                                  minWidth: 24,
                                ),
                                color: Colors.amber,
                              )
                            : const Text('signUp'),
                      ),
                    ),
                    24.heightSpace,
                    TextButton(
                      onPressed: () {
                        cubit.emitNavigation(RegisterNavigationToLogin());
                      },
                      child: Text(
                        "Already have an account? LogIn",
                        style: context.textStyle.bodyMedium,
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
