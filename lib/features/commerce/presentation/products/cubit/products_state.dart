import 'package:e_commerce/core/base/base_status.dart';
import 'package:e_commerce/features/commerce/domain/entity/products_entity.dart';

class ProductsState {
  int page;
  int numberOfPages;
  bool isFav;
  bool isFavLoading;
  BaseStatus<List<ProductsEntity>> products;
  BaseStatus<String> fav;

  ProductsState({
    this.page = 1,
    this.numberOfPages = 1,
    this.isFav = false,
    this.isFavLoading = false,
    this.products = const BaseStatus.initial(),
    this.fav = const BaseStatus.initial(),
  });

  ProductsState copyWith({
    int? page,
    int? numberOfPages,
    bool? isFav,
    bool? isFavLoading,
    BaseStatus<String>? fav,
    BaseStatus<List<ProductsEntity>>? products,
  }) {
    return ProductsState(
      page: page ?? this.page,
      numberOfPages: numberOfPages ?? this.numberOfPages,
      products: products ?? this.products,
      isFav: isFav ?? this.isFav,
      isFavLoading: isFavLoading ?? this.isFavLoading,
      fav: fav ?? this.fav,
    );
  }

  // final List<ProductsEntity> products;
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
}

sealed class ProductsActions {}

final class LoadProducts extends ProductsActions {
  final String categoryId;
  LoadProducts(this.categoryId);
}

final class AddToFav extends ProductsActions {
  final String productID;
  AddToFav(this.productID);
}
