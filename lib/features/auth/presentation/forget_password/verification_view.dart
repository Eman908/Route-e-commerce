import 'package:e_commerce/core/base/base_status.dart';
import 'package:e_commerce/core/routing/routes.dart';
import 'package:e_commerce/core/theme/app_colors.dart';
import 'package:e_commerce/core/utils/context_extension.dart';
import 'package:e_commerce/core/utils/padding_extension.dart';
import 'package:e_commerce/core/utils/whitespace_extension.dart';
import 'package:e_commerce/features/auth/presentation/forget_password/cubit/forget_password_process_cubit.dart';
import 'package:e_commerce/features/auth/presentation/forget_password/cubit/forget_password_process_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pin_code_fields/pin_code_fields.dart';

class VerificationView extends StatefulWidget {
  const VerificationView({super.key, required this.email});
  final String email;
  @override
  State<VerificationView> createState() => _VerificationViewState();
}

class _VerificationViewState extends State<VerificationView> {
  late ForgetPasswordProcessCubit cubit;
  TextEditingController code = TextEditingController();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    cubit = context.read<ForgetPasswordProcessCubit>();
  }

  @override
  void dispose() {
    cubit.close();
    code.dispose();
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
          'Verification Code',
          style: TextStyle(color: Colors.white),
        ),
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      body:
          BlocConsumer<ForgetPasswordProcessCubit, ForgetPasswordProcessState>(
            listener: (context, state) {
              if (state.verifyCode.status == Status.failure) {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    backgroundColor: AppColors.red,
                    content: Text(
                      state.verifyCode.message ?? 'Something Went Wrong',
                    ),
                  ),
                );
              } else if (state.verifyCode.status == Status.success) {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    backgroundColor: AppColors.white,
                    content: Text(
                      state.verifyCode.message ??
                          'Verification Code Is Correct',
                      style: const TextStyle(color: AppColors.darkBlue),
                    ),
                  ),
                );
                Navigator.pushNamed(
                  context,
                  Routes.resetPasswordRoute,
                  arguments: widget.email,
                );
              }
            },
            builder: (context, state) {
              return SafeArea(
                child: Form(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      32.heightSpace,
                      Text(
                        'We Sent Code To\n${widget.email}',
                        style: context.textStyle.titleLarge!.copyWith(
                          color: AppColors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 24,
                        ),
                      ),
                      //add counter 10 min
                      40.heightSpace,
                      PinCodeTextField(
                        controller: code,
                        appContext: context,
                        length: 6,
                        keyboardType: TextInputType.number,
                        animationType: AnimationType.fade,
                        pinTheme: PinTheme(
                          shape: PinCodeFieldShape.box,
                          borderRadius: BorderRadius.circular(8),
                          activeFillColor: Colors.white,
                          inactiveFillColor: Colors.white,
                          selectedFillColor: AppColors.white,
                          activeColor: Colors.white,
                          inactiveColor: Colors.white,
                        ),
                        enableActiveFill: true,
                        textStyle: const TextStyle(color: AppColors.darkBlue),
                      ),
                      32.heightSpace,
                      Align(
                        alignment: AlignmentGeometry.center,
                        child: Text(
                          "Didn't receive the code ?",
                          style: context.textStyle.labelSmall!.copyWith(
                            fontWeight: FontWeight.normal,
                          ),
                        ),
                      ),
                      Align(
                        alignment: AlignmentGeometry.center,
                        child: TextButton(
                          onPressed: () {
                            cubit.doAction(SendCode(widget.email));
                          },
                          child: state.forgetPassword.status == Status.loading
                              ? const CircularProgressIndicator()
                              : Text(
                                  'Resend',
                                  style: context.textStyle.labelSmall!.copyWith(
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                        ),
                      ),
                      SizedBox(
                        width: double.infinity,
                        child: FilledButton(
                          onPressed: () {
                            cubit.doAction(VerifyCode(code.text));
                          },
                          child: state.verifyCode.status == Status.loading
                              ? const CircularProgressIndicator()
                              : const Text('Verify'),
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
