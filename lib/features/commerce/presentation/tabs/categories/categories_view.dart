import 'package:e_commerce/core/base/base_status.dart';
import 'package:e_commerce/core/theme/app_colors.dart';
import 'package:e_commerce/features/commerce/presentation/tabs/categories/cubit/categories_cubit.dart';
import 'package:e_commerce/features/commerce/presentation/tabs/categories/cubit/categories_state.dart';
import 'package:e_commerce/features/commerce/presentation/tabs/home/widgets/category_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CategoriesView extends StatefulWidget {
  const CategoriesView({super.key});

  @override
  State<CategoriesView> createState() => _CategoriesViewState();
}

class _CategoriesViewState extends State<CategoriesView> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final cubit = context.read<CategoriesCubit>();
      cubit.doAction(LoadCategories());
    });
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CategoriesCubit, CategoriesState>(
      builder: (context, state) {
        final status = state.categoriesStatus?.status;

        if (status == Status.loading) {
          return const SizedBox(
            child: Center(child: CircularProgressIndicator()),
          );
        }

        if (status == Status.failure) {
          return Container(
            alignment: Alignment.center,
            child: Column(
              children: [
                Text(
                  state.categoriesStatus!.message!,
                  textAlign: TextAlign.center,
                  style: const TextStyle(color: Colors.red),
                ),
                FilledButton(
                  onPressed: () {
                    context.read<CategoriesCubit>().doAction(LoadCategories());
                  },
                  style: FilledButton.styleFrom(
                    padding: const EdgeInsets.symmetric(horizontal: 24),
                    backgroundColor: AppColors.red,
                    foregroundColor: AppColors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16),
                    ),
                  ),

                  child: const Text('Try Again'),
                ),
              ],
            ),
          );
        }

        final categories = state.categoriesStatus?.data;
        if (categories == null || categories.isEmpty) {
          return Container(
            alignment: Alignment.center,
            child: Column(
              children: [
                const Text(
                  'No categories available',
                  textAlign: TextAlign.center,
                  style: TextStyle(color: Colors.red),
                ),
                FilledButton(
                  onPressed: () {
                    context.read<CategoriesCubit>().doAction(LoadCategories());
                  },
                  style: FilledButton.styleFrom(
                    padding: const EdgeInsets.symmetric(horizontal: 24),
                    backgroundColor: AppColors.red,
                    foregroundColor: AppColors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16),
                    ),
                  ),

                  child: const Text('Try Again'),
                ),
              ],
            ),
          );
        }

        return GridView.builder(
          padding: const EdgeInsets.all(16),
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 3,
            mainAxisSpacing: 40,
            crossAxisSpacing: 16,
            childAspectRatio: 0.75,
          ),
          itemCount: categories.length,
          itemBuilder: (context, index) {
            return CategoryCard(categoriesEntity: categories[index]);
          },
        );
      },
    );
  }
}
