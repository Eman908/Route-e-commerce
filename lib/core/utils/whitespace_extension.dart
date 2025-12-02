import 'package:flutter/material.dart';

extension WhitespaceExtension on num {
  SizedBox get heightSpace => SizedBox(height: toDouble());
  SizedBox get widthSpace => SizedBox(width: toDouble());
}
