import 'package:e_commerce/core/api%20manager/api_client.dart';
import 'package:e_commerce/core/di/di.dart';
import 'package:e_commerce/core/errors/results.dart';
import 'package:e_commerce/core/errors/safe_call.dart';
import 'package:e_commerce/features/orders/data/data_source/contract/cart_api_data_source.dart';
import 'package:e_commerce/features/orders/data/models/user_cart/user_cart.dart';
import 'package:injectable/injectable.dart';

@Injectable(as: CartApiDataSource)
class CartApiDataSourceImpl implements CartApiDataSource {
  final ApiClient _apiClient = getIt();
  @override
  Future<Results<UserCartResponse>> addProductToCart(String productId) async {
    return safeCall(() async {
      var response = await _apiClient.addProductToCart({
        "productId": productId,
      });
      return Success(response);
    });
  }

  @override
  Future<Results<UserCartResponse>> deleteCartItem(String productId) async {
    return safeCall(() async {
      var response = await _apiClient.deleteCartItems(productId);
      return Success(response);
    });
  }

  @override
  Future<Results<UserCartResponse>> getAllCart() async {
    return safeCall(() async {
      var response = await _apiClient.getAllCart();
      if (response.data?.products == null || response.data!.products!.isEmpty) {
        return Failure(message: response.status);
      }
      return Success(response);
    });
  }

  @override
  Future<Results<UserCartResponse>> updateProductQuantity(
    String productId,
    String count,
  ) async {
    return safeCall(() async {
      var response = await _apiClient.updateCartProductQuantity(productId, {
        "count": count,
      });
      return Success(response);
    });
  }
}
