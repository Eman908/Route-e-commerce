import 'package:e_commerce/core/base/base_status.dart';
import 'package:e_commerce/core/routing/routes.dart';
import 'package:e_commerce/core/utils/context_extension.dart';
import 'package:e_commerce/features/auth/data/models/register_request.dart';
import 'package:e_commerce/features/auth/presentation/register/cubit/register_cubit.dart';
import 'package:e_commerce/features/auth/presentation/register/cubit/register_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class RegisterView extends StatefulWidget {
  const RegisterView({super.key});

  @override
  State<RegisterView> createState() => _RegisterViewState();
}

class _RegisterViewState extends State<RegisterView> {
  late RegisterCubit cubit;
  TextEditingController name = TextEditingController();
  TextEditingController email = TextEditingController();
  TextEditingController pass = TextEditingController();
  TextEditingController rePass = TextEditingController();
  TextEditingController phone = TextEditingController();
  @override
  void initState() {
    cubit = context.read<RegisterCubit>();
    cubit.navigation.listen((navigationState) {
      switch (navigationState) {
        case RegisterNavigationToLogin():
          {
            Navigator.of(context).pushReplacementNamed(Routes.loginRoute);
          }
        case ShowScaffoldMessenger():
          {
            ScaffoldMessenger.of(
              context,
            ).showSnackBar(SnackBar(content: Text(navigationState.message)));
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
                  style: const TextStyle(color: Colors.white),
                  controller: name,
                  decoration: const InputDecoration(hintText: 'name'),
                ),
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
                TextFormField(
                  controller: rePass,
                  style: const TextStyle(color: Colors.white),

                  decoration: const InputDecoration(hintText: 'confirm'),
                ),
                TextFormField(
                  controller: phone,
                  style: const TextStyle(color: Colors.white),

                  decoration: const InputDecoration(hintText: 'phone'),
                ),
                BlocBuilder<RegisterCubit, RegisterState>(
                  builder: (context, state) {
                    return FilledButton(
                      onPressed: () async {
                        var request = RegisterRequest(
                          name: name.text,
                          email: email.text,
                          password: pass.text,
                          phone: phone.text,
                          rePassword: rePass.text,
                        );
                        await cubit.doAction(RegisterUser(request));
                      },
                      child: state.registerState.status == Status.loading
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
