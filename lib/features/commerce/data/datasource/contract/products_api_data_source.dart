import 'package:e_commerce/core/errors/results.dart';
import 'package:e_commerce/features/commerce/data/models/add_to_fav.dart';
import 'package:e_commerce/features/commerce/data/models/products_dto/products_dto.dart';

abstract interface class ProductsApiDataSource {
  Future<Results<ProductsDto>> getAllProducts(
    int limit,
    int page,

    String categoryId,
  );
  Future<Results<AddToFav>> addProductToFav(String productId);
}
