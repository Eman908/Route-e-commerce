import 'package:e_commerce/core/base/base_status.dart';
import 'package:e_commerce/core/theme/app_colors.dart';
import 'package:e_commerce/features/commerce/presentation/tabs/home/cubit/home_cubit.dart';
import 'package:e_commerce/features/commerce/presentation/tabs/home/cubit/home_state.dart';
import 'package:e_commerce/features/commerce/presentation/tabs/home/widgets/categories_list_builder.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CategoriesSectionBuilder extends StatelessWidget {
  const CategoriesSectionBuilder({super.key});
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HomeCubit, HomeState>(
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
                    context.read<HomeCubit>().doAction(LoadHomeCategories());
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
                    context.read<HomeCubit>().doAction(LoadHomeCategories());
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

        return CategoriesListBuilder(categoriesEntity: categories);
      },
    );
  }

}
