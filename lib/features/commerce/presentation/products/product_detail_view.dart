import 'package:e_commerce/core/theme/app_colors.dart';
import 'package:e_commerce/core/utils/context_extension.dart';
import 'package:e_commerce/core/utils/padding_extension.dart';
import 'package:e_commerce/core/utils/whitespace_extension.dart';
import 'package:e_commerce/core/widgets/custom_app_bar.dart';
import 'package:e_commerce/features/commerce/domain/entity/products_entity.dart';
import 'package:e_commerce/features/commerce/presentation/products/widgets/image_builder.dart';
import 'package:e_commerce/features/orders/domain/entity/cart_item_entity.dart';
import 'package:e_commerce/features/orders/presentation/cubit/cart_cubit.dart';
import 'package:e_commerce/features/orders/presentation/cubit/cart_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ProductDetailView extends StatefulWidget {
  const ProductDetailView({super.key, required this.productsEntity});
  final ProductsEntity productsEntity;

  @override
  State<ProductDetailView> createState() => _ProductDetailViewState();
}

class _ProductDetailViewState extends State<ProductDetailView> {
  late CartCubit cartCubit;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    cartCubit = context.read<CartCubit>();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CartCubit, CartState>(
      builder: (context, state) {
        CartItemEntity? cartItemEntity;
        try {
          cartItemEntity = state.cartItems.data?.firstWhere(
            (element) => element.id == widget.productsEntity.id,
          );
        } catch (e) {
          cartItemEntity = null;
        }

        return Scaffold(
          appBar: customAppBar('Product Details'),
          body: SingleChildScrollView(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ImageBuilder(productsEntity: widget.productsEntity),
                24.heightSpace,
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      child: Text(
                        widget.productsEntity.title ?? '',
                        style: context.textStyle.headlineMedium,
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                    24.widthSpace,
                    Text(
                      "${widget.productsEntity.price}EGP",
                      style: context.textStyle.headlineMedium,
                    ),
                  ],
                ),
                24.heightSpace,
                Text(
                  "⭐${widget.productsEntity.ratingsAverage}(${widget.productsEntity.ratingsQuantity})",
                  style: context.textStyle.bodyLarge,
                ),
                24.heightSpace,

                Text('Description', style: context.textStyle.headlineMedium),
                Text(
                  widget.productsEntity.description ?? '',
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
                    widget.productsEntity.price?.toString() ?? '0',
                    style: context.textStyle.bodyLarge,
                  ),
                ],
              ),
              if (cartItemEntity != null)
                Expanded(
                  child: Container(
                    decoration: BoxDecoration(
                      color: AppColors.darkBlue,
                      borderRadius: BorderRadius.circular(16),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        IconButton(
                          onPressed: () {
                            cartCubit.doAction(
                              UpdateCartItems(
                                ((cartItemEntity?.count ?? 1) - 1),
                                widget.productsEntity.id ?? '',
                              ),
                            );
                          },
                          icon: const Icon(Icons.remove, color: Colors.white),
                        ),
                        Text(
                          cartItemEntity.count?.toString() ?? '0',
                          style: const TextStyle(color: Colors.white),
                        ),
                        IconButton(
                          onPressed: () {
                            cartCubit.doAction(
                              UpdateCartItems(
                                ((cartItemEntity?.count ?? 1) + 1),
                                widget.productsEntity.id ?? '',
                              ),
                            );
                          },
                          icon: const Icon(Icons.add, color: Colors.white),
                        ),
                      ],
                    ),
                  ),
                ),
              if (cartItemEntity == null)
                Expanded(
                  child: FilledButton(
                    onPressed: () {
                      cartCubit.doAction(
                        AddProductToCart(widget.productsEntity.id ?? ''),
                      );
                    },
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
      },
    );
  }
}
