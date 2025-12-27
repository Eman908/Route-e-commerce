import 'package:flutter/material.dart';

class BannerEntity {
  String imagePath;
  String title;
  String categoryName;
  Alignment alignment;
  Color btnColor;
  Color textColor;

  BannerEntity({
    required this.imagePath,
    required this.title,
    required this.categoryName,
    required this.alignment,
    required this.btnColor,
    required this.textColor,
  });
}
