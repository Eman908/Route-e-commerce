import 'package:e_commerce/core/di/di.dart';
import 'package:e_commerce/core/errors/results.dart';
import 'package:e_commerce/features/commerce/data/datasource/contract/products_api_data_source.dart';
import 'package:e_commerce/features/commerce/data/mappers/products_mapper.dart';
import 'package:e_commerce/features/commerce/data/models/add_to_fav.dart';
import 'package:e_commerce/features/commerce/data/models/products_dto/products_dto.dart';
import 'package:e_commerce/features/commerce/domain/entity/pageable_product.dart';
import 'package:e_commerce/features/commerce/domain/repositry/products_repo.dart';
import 'package:injectable/injectable.dart';

@Injectable(as: ProductsRepo)
class ProductsRepoImpl implements ProductsRepo {
  final ProductsApiDataSource _productsApiDataSource = getIt();
  final ProductsMapper _mapper = getIt();
  @override
  Future<Results<PageableProducts>> getAllProducts(
    int limit,
    int page,

    String categoryId,
  ) async {
    var response = await _productsApiDataSource.getAllProducts(
      limit,
      page,
      categoryId,
    );
    switch (response) {
      case Success<ProductsDto>():
        return Success(
          _mapper.mapPageableProductsResponseToEntity(response.data),
        );
      case Failure<ProductsDto>():
        return Failure(message: response.message);
    }
  }

  @override
  Future<Results<AddToFav>> addProductToFav(String productId) async {
    var response = await _productsApiDataSource.addProductToFav(productId);
    switch (response) {
      case Success<AddToFav>():
        // response.data = 'Product Added Successfully';
        return Success(response.data);
      case Failure<AddToFav>():
        return Failure(message: response.message);
    }
  }

  @override
  Future<Results<AddToFav>> removeProductToFav(String productId) async {
    var response = await _productsApiDataSource.removeProductToFav(productId);
    switch (response) {
      case Success<AddToFav>():
        return Success(response.data);
      case Failure<AddToFav>():
        return Failure(message: response.message);
    }
  }
}
