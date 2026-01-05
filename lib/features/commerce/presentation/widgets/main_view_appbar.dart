import 'package:flutter/material.dart';

AppBar mainAppBar(int value, {required void Function()? onPressed}) {
  return AppBar(
    title: Image.asset('assets/images/Group 5.png'),
    bottom: value == 3
        ? const PreferredSize(
            preferredSize: Size.fromHeight(0),
            child: SizedBox(),
          )
        : PreferredSize(
            preferredSize: const Size.fromHeight(56.0),
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Row(
                spacing: 16,
                children: [
                  const Expanded(
                    child: TextField(
                      decoration: InputDecoration(
                        prefixIcon: Icon(Icons.search),
                        hintText: 'Search',
                      ),
                    ),
                  ),
                  IconButton(
                    onPressed: onPressed,
                    icon: const Icon(Icons.shopping_cart_outlined),
                  ),
                ],
              ),
            ),
          ),
  );
}
