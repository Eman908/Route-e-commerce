import 'package:e_commerce/core/routing/app_routes.dart';
import 'package:e_commerce/core/theme/app_theme.dart';
import 'package:e_commerce/features/auth/presentation/login/cubit/login_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => injectionLogin(),
      child: MaterialApp(
        theme: AppTheme.getLightThemeData(),
        themeMode: ThemeMode.light,
        onGenerateRoute: AppRouter.generateRoute,
      ),
    );
  }
}
