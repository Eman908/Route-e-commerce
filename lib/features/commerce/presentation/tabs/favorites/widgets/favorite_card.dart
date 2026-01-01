import 'package:cached_network_image/cached_network_image.dart';
import 'package:e_commerce/core/routing/routes.dart';
import 'package:e_commerce/core/theme/app_colors.dart';
import 'package:e_commerce/core/utils/context_extension.dart';
import 'package:e_commerce/features/commerce/domain/entity/products_entity.dart';
import 'package:flutter/material.dart';

class FavoriteCard extends StatelessWidget {
  const FavoriteCard({super.key, required this.productsEntity});
  final ProductsEntity productsEntity;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.of(
          context,
        ).pushNamed(Routes.productDetailRoute, arguments: productsEntity);
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
                      //const SizedBox(height: 4),
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

                      Row(
                        spacing: 4,
                        children: [
                          Text(
                            "EGP ${productsEntity.priceAfterDiscount?.toString() ?? '0'}",
                            style: context.textStyle.labelLarge?.copyWith(
                              color: AppColors.darkBlue,
                              fontWeight: FontWeight.bold,
                              fontSize: 16,
                            ),
                          ),
                          Text(
                            "EGP ${productsEntity.price?.toString() ?? '0'}",
                            style: context.textStyle.labelMedium?.copyWith(
                              color: productsEntity.priceAfterDiscount != null
                                  ? Colors.grey
                                  : AppColors.darkBlue,
                              fontWeight:
                                  productsEntity.priceAfterDiscount == null
                                  ? FontWeight.bold
                                  : FontWeight.normal,
                              decoration:
                                  productsEntity.priceAfterDiscount != null
                                  ? TextDecoration.lineThrough
                                  : null,
                            ),
                          ),
                        ],
                      ),

                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          FittedBox(
                            fit: BoxFit.scaleDown,
                            child: IconButton(
                              onPressed: () {},
                              style: IconButton.styleFrom(
                                foregroundColor: AppColors.red,
                                minimumSize: Size.zero,
                                padding: EdgeInsets.zero,
                                tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                              ),
                              icon: const Icon(Icons.favorite),
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
