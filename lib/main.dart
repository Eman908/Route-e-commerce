import 'package:e_commerce/core/constants/app_constants.dart';
import 'package:e_commerce/core/di/di.dart';
import 'package:e_commerce/core/utils/bloc_observer.dart';
import 'package:e_commerce/run_app.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await dotenv.load(fileName: ".env");

  await configureDependencies();
  Bloc.observer = MyBlocObserver();
  SharedPreferences preferences = getIt();
  var token = preferences.getString(AppConstants.token);
  runApp(MyApp(token: token));
  // runApp(
  //   DevicePreview(
  //     enabled: !kReleaseMode,
  //     builder: (context) => MyApp(token: token),
  //   ),
  // );
}
