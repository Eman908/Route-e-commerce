import 'package:e_commerce/core/base/base_status.dart';
import 'package:e_commerce/features/orders/domain/entity/cart_item_entity.dart';

class CartState {
  BaseStatus<String> addProduct;
  BaseStatus<String> deleteProductFromCart;
  BaseStatus<List<CartItemEntity>> cartItems;
  final int? count;
  CartState({
    this.addProduct = const BaseStatus.initial(),
    this.deleteProductFromCart = const BaseStatus.initial(),
    this.cartItems = const BaseStatus.initial(),
    this.count = 0,
  });
  CartState copyWith({
    BaseStatus<String>? addProduct,
    BaseStatus<String>? deleteProductFromCart,
    BaseStatus<List<CartItemEntity>>? cartItems,
    int? count,
  }) {
    return CartState(
      addProduct: addProduct ?? this.addProduct,
      deleteProductFromCart:
          deleteProductFromCart ?? this.deleteProductFromCart,
      cartItems: cartItems ?? this.cartItems,
      count: count ?? this.count,
    );
  }

  bool isProductInCart(String productId) {
    return (cartItems.data ?? []).any((item) => item.id == productId);
  }
}

sealed class CartAction {}

final class AddProductToCart extends CartAction {
  final String productId;
  AddProductToCart(this.productId);
}

final class DeleteProductFromCart extends CartAction {
  final String productId;
  DeleteProductFromCart(this.productId);
}

final class LoadCartItems extends CartAction {}

final class UpdateCartItems extends CartAction {
  final int count;
  final String productId;

  UpdateCartItems(this.count, this.productId);
}
