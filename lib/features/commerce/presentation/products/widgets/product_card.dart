import 'package:cached_network_image/cached_network_image.dart';
import 'package:e_commerce/core/routing/routes.dart';
import 'package:e_commerce/core/theme/app_colors.dart';
import 'package:e_commerce/core/utils/context_extension.dart';
import 'package:e_commerce/core/utils/padding_extension.dart';
import 'package:e_commerce/features/commerce/domain/entity/products_entity.dart';
import 'package:e_commerce/features/commerce/presentation/products/cubit/products_cubit.dart';
import 'package:e_commerce/features/commerce/presentation/products/cubit/products_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ProductCard extends StatelessWidget {
  const ProductCard({super.key, required this.productsEntity});
  final ProductsEntity productsEntity;
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ProductsCubit, ProductsState>(
      builder: (context, state) {
        final cubit = context.read<ProductsCubit>();
        final productId = productsEntity.id ?? '';

        final isFavorite = cubit.state.isProductFavorite(productId);

        return InkWell(
          onTap: () {
            Navigator.of(
              context,
            ).pushNamed(Routes.productDetailRoute, arguments: productsEntity);
          },

          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(16),
              border: Border.all(color: AppColors.blue),
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              spacing: 8,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: Stack(
                    alignment: AlignmentGeometry.topRight,
                    children: [
                      ClipRRect(
                        borderRadius: const BorderRadius.only(
                          topLeft: Radius.circular(16),
                          topRight: Radius.circular(16),
                        ),
                        child: CachedNetworkImage(
                          fit: BoxFit.cover,
                          width: double.infinity,
                          imageUrl: productsEntity.imageCover ?? '',
                          placeholder: (context, url) =>
                              const Center(child: CircularProgressIndicator()),
                          errorWidget: (context, url, error) =>
                              const Icon(Icons.error),
                        ),
                      ),
                      IconButton(
                        onPressed: () {
                          if (isFavorite) {
                            cubit.doAction(
                              RemoveFromFav(productsEntity.id ?? ''),
                            );
                          } else {
                            cubit.doAction(
                              AddProductToFav(productsEntity.id ?? ''),
                            );
                          }
                        },
                        style: IconButton.styleFrom(
                          backgroundColor: AppColors.white,
                          foregroundColor: AppColors.red,
                          elevation: 2,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadiusGeometry.circular(1000),
                          ),
                        ),
                        icon: Icon(
                          isFavorite ? Icons.favorite : Icons.favorite_border,
                        ),
                      ),
                    ],
                  ),
                ),
                Text(
                  productsEntity.title ?? '',
                  maxLines: 2,

                  overflow: TextOverflow.ellipsis,
                  style: context.textStyle.labelLarge!.copyWith(
                    fontSize: 16,
                    color: AppColors.darkBlue,
                  ),
                ).horizontalPadding(8),
                Row(
                  spacing: 8,
                  children: [
                    Text(
                      "EGP ${productsEntity.price.toString()}",
                      style: context.textStyle.headlineSmall,
                    ),
                    Text(
                      productsEntity.priceAfterDiscount != null
                          ? "${productsEntity.priceAfterDiscount.toString()} EGP"
                          : "",

                      style: Theme.of(context).textTheme.headlineSmall
                          ?.copyWith(
                            color: context.colors.primary.withValues(alpha: .6),
                            decoration: TextDecoration.lineThrough,
                          ),
                    ),
                  ],
                ).horizontalPadding(8),
                Row(
                  children: [
                    Text(
                      'Reviews (${productsEntity.ratingsAverage})',
                      style: context.textStyle.headlineSmall,
                    ),

                    const Icon(Icons.star, color: Colors.amber),
                    const Spacer(),
                    FittedBox(
                      fit: BoxFit.scaleDown,
                      child: IconButton(
                        onPressed: () {},
                        style: IconButton.styleFrom(
                          backgroundColor: AppColors.darkBlue,
                          foregroundColor: AppColors.white,
                          minimumSize: Size.zero,
                          padding: EdgeInsets.zero,
                          tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                        ),
                        icon: const Icon(Icons.add),
                      ),
                    ),
                  ],
                ).horizontalPadding(8),
                const SizedBox(height: 8),
              ],
            ),
          ),
        );
      },
    );
  }
}
