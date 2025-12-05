import 'package:e_commerce/core/base/base_status.dart';
import 'package:e_commerce/core/utils/context_extension.dart';
import 'package:e_commerce/features/auth/data/models/login_request.dart';
import 'package:e_commerce/features/auth/presentation/login/cubit/login_cubit.dart';
import 'package:e_commerce/features/auth/presentation/login/cubit/login_state.dart';
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

  late LoginCubit cubit;
  @override
  void initState() {
    cubit = context.read<LoginCubit>();
    cubit.navigation.listen((navEvent) {
      switch (navEvent) {
        case LoginNavigationToHome():
          {}

        case LoginShowScaffoldMessage():
          {
            ScaffoldMessenger.of(
              context,
            ).showSnackBar(SnackBar(content: Text(navEvent.message)));
          }
      }
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: context.colors.primary,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Form(
            child: Column(
              children: [
                Image.asset('assets/images/logo.png'),
                TextFormField(
                  controller: email,
                  style: const TextStyle(color: Colors.white),

                  decoration: const InputDecoration(hintText: 'email'),
                ),
                TextFormField(
                  controller: pass,
                  style: const TextStyle(color: Colors.white),

                  decoration: const InputDecoration(hintText: 'password'),
                ),
                BlocBuilder<LoginCubit, LoginState>(
                  builder: (context, state) {
                    return FilledButton(
                      onPressed: () async {
                        var request = LoginRequest(
                          email: email.text,
                          password: pass.text,
                        );
                        await cubit.doAction(LoginUser(request));
                      },
                      child: state.loginState.status == Status.loading
                          ? const CircularProgressIndicator()
                          : const Text('signUp'),
                    );
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
