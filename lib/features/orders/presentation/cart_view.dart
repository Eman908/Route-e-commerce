import 'package:e_commerce/core/base/base_status.dart';
import 'package:e_commerce/core/theme/app_colors.dart';
import 'package:e_commerce/core/widgets/custom_app_bar.dart';
import 'package:e_commerce/features/orders/presentation/cubit/cart_cubit.dart';
import 'package:e_commerce/features/orders/presentation/cubit/cart_state.dart';
import 'package:e_commerce/features/orders/presentation/widgets/cart_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CartView extends StatefulWidget {
  const CartView({super.key});

  @override
  State<CartView> createState() => _CartViewState();
}

class _CartViewState extends State<CartView> {
  late CartCubit cubit;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    cubit = context.read<CartCubit>();
    cubit.doAction(LoadCartItems());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: customAppBar('Cart'),
      body: BlocBuilder<CartCubit, CartState>(
        builder: (context, state) {
          switch (state.addProduct.status) {
            case Status.initial:
            case Status.success:
              var items = state.cartItems.data ?? [];
              return ListView.separated(
                padding: const EdgeInsets.all(16),
                itemBuilder: (context, index) {
                  return CartCard(productsEntity: items[index]);
                },
                separatorBuilder: (context, index) =>
                    const SizedBox(height: 16),
                itemCount: items.length,
              );
            case Status.failure:
              return Container(
                alignment: Alignment.center,
                child: Column(
                  children: [
                    Text(
                      state.cartItems.message!,
                      textAlign: TextAlign.center,
                      style: const TextStyle(color: Colors.red),
                    ),
                    FilledButton(
                      onPressed: () {
                        cubit.doAction(LoadCartItems());
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
            case Status.loading:
              return const Center(child: CircularProgressIndicator());
          }
        },
      ),
    );
  }
}
