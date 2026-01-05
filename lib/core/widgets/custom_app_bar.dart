import 'package:flutter/material.dart';

AppBar customAppBar(String title) {
  return AppBar(
    centerTitle: true,
    title: Text(title),
    actions: [
      IconButton(onPressed: () {}, icon: const Icon(Icons.search)),
      IconButton(
        onPressed: () {},
        icon: const Icon(Icons.shopping_cart_outlined),
      ),
    ],
  );
}
