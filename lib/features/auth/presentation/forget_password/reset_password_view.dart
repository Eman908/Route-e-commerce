import 'package:e_commerce/core/base/base_status.dart';
import 'package:e_commerce/core/routing/routes.dart';
import 'package:e_commerce/core/theme/app_colors.dart';
import 'package:e_commerce/core/utils/context_extension.dart';
import 'package:e_commerce/core/utils/padding_extension.dart';
import 'package:e_commerce/core/utils/validation.dart';
import 'package:e_commerce/core/utils/whitespace_extension.dart';
import 'package:e_commerce/features/auth/presentation/forget_password/cubit/forget_password_process_cubit.dart';
import 'package:e_commerce/features/auth/presentation/forget_password/cubit/forget_password_process_state.dart';
import 'package:e_commerce/features/auth/presentation/widgets/custom_text_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ResetPasswordView extends StatefulWidget {
  const ResetPasswordView({super.key, required this.email});
  final String email;
  @override
  State<ResetPasswordView> createState() => _ResetPasswordViewState();
}

class _ResetPasswordViewState extends State<ResetPasswordView> {
  TextEditingController password = TextEditingController();
  TextEditingController confirmPassword = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey();
  late ForgetPasswordProcessCubit cubit;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    cubit = context.read<ForgetPasswordProcessCubit>();
  }

  @override
  void dispose() {
    password.dispose();
    confirmPassword.dispose();
    cubit.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: context.colors.primary,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        centerTitle: true,
        title: const Text(
          'Reset Password',
          style: TextStyle(color: Colors.white),
        ),
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      body:
          BlocConsumer<ForgetPasswordProcessCubit, ForgetPasswordProcessState>(
            listener: (context, state) {
              if (state.resetPassword.status == Status.failure) {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    backgroundColor: AppColors.red,
                    content: Text(
                      state.resetPassword.message ?? 'Something Went Wrong',
                    ),
                  ),
                );
              } else if (state.resetPassword.status == Status.success) {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    backgroundColor: AppColors.white,
                    content: Text(
                      state.resetPassword.message ??
                          'Password Rest Successfully',
                      style: const TextStyle(color: AppColors.darkBlue),
                    ),
                  ),
                );
                Navigator.pushNamed(context, Routes.loginRoute);
              }
            },
            builder: (context, state) {
              return SafeArea(
                child: Form(
                  key: _formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      32.heightSpace,
                      Text(
                        'Enter Your New Password',
                        style: context.textStyle.titleLarge!.copyWith(
                          color: AppColors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 24,
                        ),
                      ),
                      40.heightSpace,
                      CustomTextFormField(
                        controller: password,
                        hintText: 'New Password',
                        prefix: Icons.lock,
                        validator: (value) {
                          return Validation.validatePassword(value);
                        },
                        keyboardType: TextInputType.visiblePassword,
                      ),
                      24.heightSpace,
                      CustomTextFormField(
                        controller: confirmPassword,
                        hintText: 'Confirm Password',
                        prefix: Icons.lock,
                        validator: (value) {
                          return Validation.validatePasswordConfirmation(
                            password.text,
                            confirmPassword.text,
                          );
                        },
                        keyboardType: TextInputType.visiblePassword,
                      ),
                      32.heightSpace,
                      SizedBox(
                        width: double.infinity,
                        child: FilledButton(
                          onPressed: () {
                            if (_formKey.currentState!.validate()) {
                              cubit.doAction(
                                ResetPassword(widget.email, password.text),
                              );
                            }
                          },
                          child: state.resetPassword.status == Status.loading
                              ? const CircularProgressIndicator()
                              : const Text('Reset Password'),
                        ),
                      ),
                    ],
                  ),
                ).horizontalPadding(16),
              );
            },
          ),
    );
  }
}
