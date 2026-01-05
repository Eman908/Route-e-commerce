import 'package:e_commerce/features/commerce/domain/entity/products_entity.dart';
import 'package:e_commerce/features/commerce/presentation/products/cubit/products_cubit.dart';
import 'package:e_commerce/features/commerce/presentation/products/cubit/products_state.dart';
import 'package:e_commerce/features/commerce/presentation/products/widgets/product_card.dart';
import 'package:e_commerce/features/orders/presentation/cubit/cart_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ProductsCardBuilding extends StatelessWidget {
  const ProductsCardBuilding({
    super.key,
    required this.productsEntity,
    this.controller,
    required this.state,
    required this.categoryId,
    this.itemCount,
    required this.cubit,
  });
  final List<ProductsEntity> productsEntity;
  final ScrollController? controller;
  final ProductsState state;
  final String categoryId;
  final int? itemCount;
  final CartCubit cubit;

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      controller: controller,
      padding: const EdgeInsets.all(16),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        mainAxisSpacing: 16,
        crossAxisSpacing: 16,
        childAspectRatio: 1 / 1.7,
      ),
      itemCount: itemCount,

      itemBuilder: (context, index) {
        if (index == state.products.data!.length) {
          context.read<ProductsCubit>().doAction(LoadProducts(categoryId));

          return const Center(child: CircularProgressIndicator());
        }
        return ProductCard(productsEntity: productsEntity[index], cubit: cubit);
      },
    );
  }
}
