import 'package:cached_network_image/cached_network_image.dart';
import 'package:e_commerce/core/theme/app_colors.dart';
import 'package:e_commerce/core/utils/context_extension.dart';
import 'package:e_commerce/features/orders/domain/entity/cart_item_entity.dart';
import 'package:e_commerce/features/orders/presentation/cubit/cart_cubit.dart';
import 'package:e_commerce/features/orders/presentation/cubit/cart_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CartCard extends StatelessWidget {
  const CartCard({super.key, required this.productsEntity});
  final CartItemEntity productsEntity;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        // Navigator.of(
        //   context,
        // ).pushNamed(Routes.productDetailRoute, arguments: productsEntity);
      },
      child: SizedBox(
        height: context.heightSize * .23,
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(16),
            border: Border.all(color: AppColors.darkBlue),
          ),
          child: Row(
            children: [
              Expanded(
                flex: 3,
                child: ClipRRect(
                  borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(16),
                    bottomLeft: Radius.circular(16),
                  ),
                  child: CachedNetworkImage(
                    imageUrl: productsEntity.imageCover ?? '',
                    fit: BoxFit.cover,
                    height: double.infinity,
                    errorWidget: (context, url, error) =>
                        const Icon(Icons.error),
                    placeholder: (context, url) =>
                        const Center(child: CircularProgressIndicator()),
                  ),
                ),
              ),

              // Content
              Expanded(
                flex: 7,
                child: Padding(
                  padding: const EdgeInsets.all(12),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Text(
                        productsEntity.title ?? '',
                        style: context.textStyle.labelLarge?.copyWith(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                      Row(
                        children: [
                          Text(
                            productsEntity.ratingsAverage?.toStringAsFixed(1) ??
                                '0',
                            style: context.textStyle.labelMedium?.copyWith(
                              color: Colors.amber.shade800,
                            ),
                          ),
                          const SizedBox(width: 2),
                          const Icon(Icons.star, color: Colors.amber, size: 16),
                        ],
                      ),

                      Text(
                        "EGP ${productsEntity.price?.toString() ?? '0'}",
                        style: context.textStyle.labelMedium?.copyWith(
                          color: AppColors.darkBlue,
                        ),
                      ),

                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          FittedBox(
                            fit: BoxFit.scaleDown,
                            child: IconButton(
                              onPressed: () {
                                context.read<CartCubit>().doAction(
                                  DeleteProductFromCart(
                                    productsEntity.id ?? '',
                                  ),
                                );
                              },
                              style: IconButton.styleFrom(
                                foregroundColor: AppColors.red,
                                minimumSize: Size.zero,
                                padding: EdgeInsets.zero,
                                tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                              ),
                              icon: const Icon(Icons.delete_outline),
                            ),
                          ),

                          ConstrainedBox(
                            constraints: const BoxConstraints(
                              maxHeight: 32, // Maximum button height
                            ),
                            child: FilledButton(
                              onPressed: () {},
                              style: FilledButton.styleFrom(
                                backgroundColor: AppColors.darkBlue,
                                foregroundColor: AppColors.white,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(8),
                                ),
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 12,
                                  vertical: 8,
                                ), // Max 8 padding
                                tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                              ),
                              child: Text(
                                'Add To Cart',
                                style: context.textStyle.labelMedium?.copyWith(
                                  color: AppColors.white,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
