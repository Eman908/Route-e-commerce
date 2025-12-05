import 'package:e_commerce/core/utils/bloc_observer.dart';
import 'package:e_commerce/run_app.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

void main() async {
  Bloc.observer = MyBlocObserver();
  await dotenv.load(fileName: ".env");
  runApp(const MyApp());
}
