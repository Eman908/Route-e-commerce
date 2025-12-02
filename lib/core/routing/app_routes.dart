import 'package:e_commerce/core/routing/routes.dart';
import 'package:e_commerce/features/auth/presentation/login/login_view.dart';
import 'package:e_commerce/features/auth/presentation/register/register_view.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

abstract class AppRoutes {
  static final GoRouter router = GoRouter(
    routes: <RouteBase>[
      GoRoute(
        path: Routes.loginRoute,
        builder: (BuildContext context, GoRouterState state) {
          return const LoginView();
        },
        routes: <RouteBase>[
          GoRoute(
            path: Routes.registerRoute,
            builder: (BuildContext context, GoRouterState state) {
              return const RegisterView();
            },
          ),
        ],
      ),
    ],
  );
}
