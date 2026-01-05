import 'package:e_commerce/core/base/base_status.dart';
import 'package:e_commerce/features/commerce/domain/entity/products_entity.dart';

class ProductsState {
  int page;
  int numberOfPages;
  BaseStatus<List<ProductsEntity>> products;
  BaseStatus<List<String>> favoriteIds;

  ProductsState({
    this.page = 1,
    this.numberOfPages = 1,
    this.products = const BaseStatus.initial(),
    this.favoriteIds = const BaseStatus.initial(),
  });

  ProductsState copyWith({
    int? page,
    int? numberOfPages,
    BaseStatus<List<ProductsEntity>>? products,
    BaseStatus<List<String>>? favoriteIds,
  }) {
    return ProductsState(
      page: page ?? this.page,
      numberOfPages: numberOfPages ?? this.numberOfPages,
      products: products ?? this.products,
      favoriteIds: favoriteIds ?? this.favoriteIds,
    );
  }

  bool isProductFavorite(String productId) {
    return favoriteIds.data?.contains(productId) ?? false;
  }
}

sealed class ProductsActions {}

final class LoadProducts extends ProductsActions {
  final String categoryId;
  LoadProducts(this.categoryId);
}

final class LoadFavorites extends ProductsActions {}

final class AddProductToFav extends ProductsActions {
  final String productID;
  AddProductToFav(this.productID);
}

final class RemoveFromFav extends ProductsActions {
  final String productID;
  RemoveFromFav(this.productID);
}
