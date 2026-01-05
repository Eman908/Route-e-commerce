import 'package:e_commerce/core/errors/results.dart';
import 'package:e_commerce/features/orders/data/models/user_cart/user_cart.dart';

abstract interface class CartApiDataSource {
  Future<Results<UserCartResponse>> addProductToCart(String productId);
  Future<Results<UserCartResponse>> deleteCartItem(String productId);
  Future<Results<UserCartResponse>> getAllCart();
  Future<Results<UserCartResponse>> updateProductQuantity(
    String id,
    String count,
  );
}
