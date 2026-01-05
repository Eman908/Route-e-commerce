import 'package:e_commerce/core/di/di.dart';
import 'package:e_commerce/core/routing/app_routes.dart';
import 'package:e_commerce/core/routing/routes.dart';
import 'package:e_commerce/core/theme/app_theme.dart';
import 'package:e_commerce/features/commerce/presentation/products/cubit/products_cubit.dart';
import 'package:e_commerce/features/orders/presentation/cubit/cart_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key, this.token});
  final String? token;
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => getIt<ProductsCubit>()),
        BlocProvider(create: (context) => getIt<CartCubit>()),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        // locale: DevicePreview.locale(context),
        // builder: DevicePreview.appBuilder,
        theme: AppTheme.getLightThemeData(),
        themeMode: ThemeMode.light,
        onGenerateRoute: AppRouter.generateRoute,
        initialRoute: token != null ? Routes.mainRoute : Routes.loginRoute,
      ),
    );
  }
}
