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
} // final List<ProductsEntity> products;
// final BaseStatus baseStatus;
// final int currentPage;
// final bool hasMore;
// final bool isFetching;

// ProductsState({
//   this.products = const [],
//   this.baseStatus = const BaseStatus.initial(),
//   this.currentPage = 1,
//   this.hasMore = true,
//   this.isFetching = false,
// });

// ProductsState copyWith({
//   List<ProductsEntity>? products,
//   BaseStatus? baseStatus,
//   int? currentPage,
//   bool? hasMore,
//   bool? isFetching,
// }) {
//   return ProductsState(
//     products: products ?? this.products,
//     baseStatus: baseStatus ?? this.baseStatus,
//     currentPage: currentPage ?? this.currentPage,
//     hasMore: hasMore ?? this.hasMore,
//     isFetching: isFetching ?? this.isFetching,
//   );
// }

sealed class ProductsActions {}

final class LoadProducts extends ProductsActions {
  final String categoryId;
  LoadProducts(this.categoryId);
}

final class AddProductToFav extends ProductsActions {
  final String productID;
  AddProductToFav(this.productID);
}

final class RemoveFromFav extends ProductsActions {
  final String productID;
  RemoveFromFav(this.productID);
}
