import 'package:flutter/material.dart';

class SelectedIcon extends StatelessWidget {
  const SelectedIcon({super.key, required this.iconData});
  final IconData iconData;
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(8),
      decoration: const BoxDecoration(
        shape: BoxShape.circle,
        color: Colors.white,
      ),
      child: Icon(iconData),
    );
  }
}
