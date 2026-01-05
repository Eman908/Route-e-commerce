import 'package:e_commerce/core/errors/results.dart';
import 'package:e_commerce/features/orders/domain/entity/cart_item_entity.dart';

abstract interface class CartRepo {
  Future<Results<String>> addProductToCart(String productId);
  Future<Results<String>> deleteCartItem(String productId);
  Future<Results<List<CartItemEntity>>> getCartItem();
  Future<Results<List<CartItemEntity>>> updateCartItem(
    String productId,
    String count,
  );
}
