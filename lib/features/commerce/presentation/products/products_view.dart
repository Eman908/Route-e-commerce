import 'package:e_commerce/core/base/base_status.dart';
import 'package:e_commerce/core/theme/app_colors.dart';
import 'package:e_commerce/core/utils/context_extension.dart';
import 'package:e_commerce/features/commerce/domain/entity/categories_entity.dart';
import 'package:e_commerce/features/commerce/presentation/products/cubit/products_cubit.dart';
import 'package:e_commerce/features/commerce/presentation/products/cubit/products_state.dart';
import 'package:e_commerce/features/commerce/presentation/products/widgets/products_card_building.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ProductsView extends StatefulWidget {
  const ProductsView({super.key, required this.categoriesEntity});
  final CategoriesEntity categoriesEntity;

  @override
  State<ProductsView> createState() => _ProductsViewState();
}

class _ProductsViewState extends State<ProductsView> {
  late ScrollController controller;
  late ProductsCubit cubit;
  @override
  void initState() {
    super.initState();
    cubit = context.read<ProductsCubit>();
    controller = ScrollController();

    controller.addListener(() {
      if (controller.position.pixels >=
          controller.position.maxScrollExtent - 200) {
        cubit.doAction(LoadProducts(widget.categoriesEntity.id ?? ''));
      }
    });

    WidgetsBinding.instance.addPostFrameCallback((_) {
      cubit.doAction(LoadProducts(widget.categoriesEntity.id ?? ''));
    });
  }

  @override
  void dispose() {
    cubit.close();
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(widget.categoriesEntity.name ?? 'Category Name'),
      ),
      body: BlocBuilder<ProductsCubit, ProductsState>(
        builder: (context, state) {
          switch (state.products.status) {
            case Status.initial:
            case Status.success:
              var products = state.products.data ?? [];
              return ProductsCardBuilding(
                productsEntity: products,
                controller: controller,
                state: state,
                cubit: cubit,
              );

            case Status.failure:
              return Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Icon(Icons.error, color: Colors.red, size: 50),
                    const SizedBox(height: 16),
                    Text(
                      state.products.message ?? 'Failed to load products',
                      textAlign: TextAlign.center,
                      style: context.textStyle.bodyLarge!.copyWith(
                        color: AppColors.red,
                      ),
                    ),
                  ],
                ),
              );
            case Status.loading:
              return const Center(child: CircularProgressIndicator());
          }
          // if (state.products.status == Status.loading) {
          //   return const Center(child: CircularProgressIndicator());
          // }

          // if (state.products.status == Status.failure) {
          //   return Center(
          //     child: Column(
          //       mainAxisAlignment: MainAxisAlignment.center,
          //       children: [
          //         const Icon(Icons.error, color: Colors.red, size: 50),
          //         const SizedBox(height: 16),
          //         Text(
          //           state.products.message ?? 'Failed to load products',
          //           textAlign: TextAlign.center,
          //           style: context.textStyle.bodyLarge!.copyWith(
          //             color: AppColors.red,
          //           ),
          //         ),
          //       ],
          //     ),
          //   );
          // }

          // if (state.products.data!.isNotEmpty) {
          //   var products = state.products.data ?? [];
          //   return ProductsCardBuilding(
          //     productsEntity: products,
          //     controller: controller,
          //     state: state,
          //   );
          // }

          // return const Center(child: Text('No products available'));
        },
      ),
    );
  }
}
