import 'package:e_commerce/features/commerce/presentation/tabs/home/cubit/home_cubit.dart';
import 'package:e_commerce/features/commerce/presentation/tabs/home/cubit/home_state.dart';
import 'package:e_commerce/features/commerce/presentation/tabs/home/widgets/banner_section_builder.dart';
import 'package:e_commerce/features/commerce/presentation/tabs/home/widgets/categories_section.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final cubit = context.read<HomeCubit>();
      cubit.doAction(LoadHomeBanners());
      cubit.doAction(LoadHomeCategories());
    });
  }

  @override
  Widget build(BuildContext context) {
    return const CustomScrollView(
      slivers: [
        // Banners Section - Handles its own loading/error states
        SliverToBoxAdapter(child: BannerSectionBuilder()),
        SliverToBoxAdapter(child: SizedBox(height: 24)),
        // Categories Section - Handles its own loading/error states
        SliverToBoxAdapter(child: CategoriesSection()),
      ],
    );
  }
}
