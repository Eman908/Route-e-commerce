import 'package:flutter/material.dart';

extension ContextExtension on BuildContext {
  TextTheme get textStyle => Theme.of(this).textTheme;
  ColorScheme get colors => Theme.of(this).colorScheme;
  double get heightSize => MediaQuery.sizeOf(this).height;
  double get widthSize => MediaQuery.sizeOf(this).width;
}
