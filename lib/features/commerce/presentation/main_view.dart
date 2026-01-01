import 'package:e_commerce/core/di/di.dart';
import 'package:e_commerce/core/utils/context_extension.dart';
import 'package:e_commerce/features/commerce/presentation/tabs/categories/categories_view.dart';
import 'package:e_commerce/features/commerce/presentation/tabs/categories/cubit/categories_cubit.dart';
import 'package:e_commerce/features/commerce/presentation/tabs/favorites/cubit/fav_cubit.dart';
import 'package:e_commerce/features/commerce/presentation/tabs/favorites/favorite_view.dart';
import 'package:e_commerce/features/commerce/presentation/tabs/home/cubit/home_cubit.dart';
import 'package:e_commerce/features/commerce/presentation/widgets/main_view_appbar.dart';
import 'package:e_commerce/features/commerce/presentation/widgets/selected_icon.dart';
import 'package:e_commerce/features/commerce/presentation/tabs/home/home_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class MainView extends StatefulWidget {
  const MainView({super.key});

  @override
  State<MainView> createState() => _MainViewState();
}

class _MainViewState extends State<MainView> {
  ValueNotifier<int> currentIndex = ValueNotifier(0);
  @override
  void dispose() {
    currentIndex.dispose();
    super.dispose();
  }

  final List<Widget> _pages = [
    BlocProvider.value(value: getIt<HomeCubit>(), child: const HomeView()),
    BlocProvider.value(
      value: getIt<CategoriesCubit>(),
      child: const CategoriesView(),
    ),
    BlocProvider.value(value: getIt<FavCubit>(), child: const FavoriteView()),
    Container(
      color: Colors.orange,
      child: const Center(child: Text('Profile')),
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
      valueListenable: currentIndex,
      builder: (context, value, child) {
        return Scaffold(
          appBar: mainAppBar(value),
          body: _pages[value],
          bottomNavigationBar: ClipRRect(
            borderRadius: const BorderRadiusGeometry.only(
              topLeft: Radius.circular(30),
              topRight: Radius.circular(30),
            ),
            child: BottomNavigationBar(
              type: BottomNavigationBarType.fixed,
              backgroundColor: context.colors.primary,
              selectedItemColor: context.colors.primary,
              unselectedItemColor: Colors.white,
              showSelectedLabels: false,
              showUnselectedLabels: false,
              currentIndex: value,
              onTap: (index) {
                currentIndex.value = index;
              },
              items: [
                BottomNavigationBarItem(
                  icon: _buildWidget(0, Icons.home_outlined),
                  label: '',
                ),
                BottomNavigationBarItem(
                  icon: _buildWidget(1, Icons.dashboard_outlined),
                  label: '',
                ),
                BottomNavigationBarItem(
                  icon: _buildWidget(2, Icons.favorite_outline),
                  label: '',
                ),
                BottomNavigationBarItem(
                  icon: _buildWidget(3, Icons.person_outline),
                  label: '',
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _buildWidget(int index, IconData iconData) {
    return currentIndex.value == index
        ? SelectedIcon(iconData: iconData)
        : Icon(iconData);
  }
}
