import 'package:e_commerce/core/api%20manager/api_client.dart';
import 'package:e_commerce/core/di/di.dart';
import 'package:e_commerce/core/errors/results.dart';
import 'package:e_commerce/core/errors/safe_call.dart';
import 'package:e_commerce/features/commerce/data/datasource/contract/products_api_data_source.dart';
import 'package:e_commerce/features/commerce/data/models/add_to_fav.dart';
import 'package:e_commerce/features/commerce/data/models/products_dto/products_dto.dart';
import 'package:injectable/injectable.dart';

@Injectable(as: ProductsApiDataSource)
class ProductsApiDataSourceImpl implements ProductsApiDataSource {
  final ApiClient _apiClient = getIt();
  @override
  Future<Results<ProductsDto>> getAllProducts(
    int limit,
    int page,
    String categoryId,
  ) async {
    return safeCall(() async {
      var response = await _apiClient.getAllProducts(limit, page, categoryId);
      if (response.data == null || response.data!.isEmpty) {
        return Failure(message: 'No Products To Show');
      }
      return Success(response);
    });
  }

  @override
  Future<Results<AddToFav>> addProductToFav(String productId) async {
    return safeCall(() async {
      var response = await _apiClient.addProductToFav(productId);
      if (response.data == null || response.data!.isEmpty) {
        return Failure(message: 'something went wrong');
      }
      return Success(response);
    });
  }
}
