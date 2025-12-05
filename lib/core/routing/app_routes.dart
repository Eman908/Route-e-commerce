import 'package:e_commerce/core/routing/routes.dart';
import 'package:e_commerce/features/auth/presentation/login/login_view.dart';
import 'package:e_commerce/features/auth/presentation/register/cubit/register_cubit.dart';
import 'package:e_commerce/features/auth/presentation/register/register_view.dart';
import 'package:e_commerce/not_found_view.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

abstract class AppRouter {
  static Route generateRoute(RouteSettings settings) {
    if (kDebugMode) {
      print('Navigating to: ${settings.name}');
    }

    final uri = Uri.parse(settings.name ?? '/');

    switch (uri.path) {
      case Routes.loginRoute:
        return MaterialPageRoute(
          settings: settings,
          builder: (_) => const LoginView(),
        );
      case Routes.registerRoute:
        return MaterialPageRoute(
          settings: settings,
          builder: (context) => BlocProvider(
            create: (context) => ingection(),
            child: const RegisterView(),
          ),
        );
      default:
        return MaterialPageRoute(
          settings: settings,
          builder: (_) => NotFoundView(),
        );
    }
  }
}
