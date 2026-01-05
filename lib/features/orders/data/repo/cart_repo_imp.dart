import 'package:e_commerce/core/di/di.dart';
import 'package:e_commerce/core/errors/results.dart';
import 'package:e_commerce/features/orders/data/data_source/contract/cart_api_data_source.dart';
import 'package:e_commerce/features/orders/data/mapper/cart_mapper.dart';
import 'package:e_commerce/features/orders/data/models/user_cart/user_cart.dart';
import 'package:e_commerce/features/orders/domain/entity/cart_item_entity.dart';
import 'package:e_commerce/features/orders/domain/repo/cart_repo.dart';
import 'package:injectable/injectable.dart';

@Injectable(as: CartRepo)
class CartRepoImp implements CartRepo {
  final CartApiDataSource _cartApiDataSource = getIt();
  final CartMapper _cartMapper = getIt();
  @override
  Future<Results<String>> addProductToCart(String productId) async {
    var response = await _cartApiDataSource.addProductToCart(productId);
    switch (response) {
      case Success<UserCartResponse>():
        return Success(response.data?.status ?? 'Product Added Successfully');
      case Failure<UserCartResponse>():
        return Failure(message: response.message);
    }
  }

  @override
  Future<Results<String>> deleteCartItem(String productId) async {
    var response = await _cartApiDataSource.deleteCartItem(productId);

    switch (response) {
      case Success<UserCartResponse>():
        return Success('Success');
      case Failure<UserCartResponse>():
        return Failure(message: response.message);
    }
  }

  @override
  Future<Results<List<CartItemEntity>>> getCartItem() async {
    var response = await _cartApiDataSource.getAllCart();
    switch (response) {
      case Success<UserCartResponse>():
        return Success(
          _cartMapper.mappToCartEntity(response.data?.data?.products ?? []),
        );
      case Failure<UserCartResponse>():
        return Failure(message: response.message);
    }
  }

  @override
  Future<Results<List<CartItemEntity>>> updateCartItem(
    String productId,
    String count,
  ) async {
    var response = await _cartApiDataSource.updateProductQuantity(
      productId,
      count,
    );
    switch (response) {
      case Success<UserCartResponse>():
        return Success(
          _cartMapper.mappToCartEntity(response.data?.data?.products ?? []),
        );
      case Failure<UserCartResponse>():
        return Failure(message: response.message);
    }
  }
}
