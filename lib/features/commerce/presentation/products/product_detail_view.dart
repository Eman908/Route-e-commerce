import 'package:e_commerce/core/theme/app_colors.dart';
import 'package:e_commerce/core/utils/context_extension.dart';
import 'package:e_commerce/core/utils/padding_extension.dart';
import 'package:e_commerce/core/utils/whitespace_extension.dart';
import 'package:e_commerce/features/commerce/domain/entity/products_entity.dart';
import 'package:e_commerce/features/commerce/presentation/products/widgets/image_builder.dart';
import 'package:flutter/material.dart';

class ProductDetailView extends StatelessWidget {
  const ProductDetailView({super.key, required this.productsEntity});
  final ProductsEntity productsEntity;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text('Product Details'),
        actions: [
          IconButton(onPressed: () {}, icon: const Icon(Icons.search)),
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.shopping_cart_outlined),
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ImageBuilder(productsEntity: productsEntity),
            24.heightSpace,
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: Text(
                    productsEntity.title ?? '',
                    style: context.textStyle.headlineMedium,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
                24.widthSpace,
                Text(
                  "${productsEntity.price}EGP",
                  style: context.textStyle.headlineMedium,
                ),
              ],
            ),
            24.heightSpace,
            Text(
              "⭐${productsEntity.ratingsAverage}(${productsEntity.ratingsQuantity})",
              style: context.textStyle.bodyLarge,
            ),
            24.heightSpace,

            Text('Description', style: context.textStyle.headlineMedium),
            Text(
              productsEntity.description ?? '',
              style: context.textStyle.bodyLarge,
            ),
          ],
        ),
      ),
      bottomNavigationBar: Row(
        spacing: 16,
        children: [
          Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text('Total Price', style: context.textStyle.bodyLarge),
              Text(
                productsEntity.price?.toString() ?? '0',
                style: context.textStyle.bodyLarge,
              ),
            ],
          ),
          Expanded(
            child: FilledButton(
              onPressed: () {},
              style: FilledButton.styleFrom(
                backgroundColor: AppColors.darkBlue,
                foregroundColor: AppColors.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16),
                ),
              ),

              child: const Text('Add To Cart'),
            ),
          ),
        ],
      ).allPadding(16),
    );
  }
}
