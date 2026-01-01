import 'package:e_commerce/core/errors/results.dart';
import 'package:e_commerce/features/commerce/data/models/add_to_fav.dart';
import 'package:e_commerce/features/commerce/domain/entity/pageable_product.dart';

abstract interface class ProductsRepo {
  Future<Results<PageableProducts>> getAllProducts(
    int limit,
    int page,

    String categoryId,
  );

  Future<Results<AddToFav>> addProductToFav(String productId);
  Future<Results<AddToFav>> removeProductToFav(String productId);
}
