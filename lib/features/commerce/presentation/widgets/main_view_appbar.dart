import 'package:flutter/material.dart';

AppBar mainAppBar(int value) {
  return AppBar(
    title: Image.asset('assets/images/Group 5.png'),
    bottom: value == 3
        ? const PreferredSize(
            preferredSize: Size.fromHeight(0),
            child: SizedBox(),
          )
        : const PreferredSize(
            preferredSize: Size.fromHeight(56.0),
            child: Padding(
              padding: EdgeInsets.all(16),
              child: Row(
                spacing: 16,
                children: [
                  Expanded(
                    child: TextField(
                      decoration: InputDecoration(
                        prefixIcon: Icon(Icons.search),
                        hintText: 'Search',
                      ),
                    ),
                  ),
                  Icon(Icons.shopping_cart_outlined),
                ],
              ),
            ),
          ),
  );
}
