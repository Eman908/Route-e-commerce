import 'package:e_commerce/core/routing/app_routes.dart';
import 'package:e_commerce/core/routing/routes.dart';
import 'package:e_commerce/core/theme/app_theme.dart';
import 'package:flutter/material.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key, this.token});
  final String? token;
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: AppTheme.getLightThemeData(),
      themeMode: ThemeMode.light,
      onGenerateRoute: AppRouter.generateRoute,
      initialRoute: token != null ? Routes.mainRoute : Routes.loginRoute,
    );
  }
}
