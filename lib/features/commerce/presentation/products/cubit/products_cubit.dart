import 'package:e_commerce/core/base/base_cubit.dart';
import 'package:e_commerce/core/base/base_status.dart';
import 'package:e_commerce/core/di/di.dart';
import 'package:e_commerce/core/errors/results.dart';
import 'package:e_commerce/features/commerce/domain/entity/pageable_product.dart';
import 'package:e_commerce/features/commerce/domain/repositry/products_repo.dart';
import 'package:e_commerce/features/commerce/presentation/products/cubit/products_state.dart';
import 'package:injectable/injectable.dart';

@injectable
class ProductsCubit extends BaseCubit<ProductsState, ProductsActions, void> {
  ProductsCubit() : super(ProductsState());

  final ProductsRepo _productsRepo = getIt();

  @override
  Future<void> doAction(ProductsActions action) async {
    switch (action) {
      case LoadProducts():
        await _loadProducts(action.categoryId);
      case AddToFav():
        _addProductToFav(action.productID);
    }
  }

  Future<void> _addProductToFav(String productID) async {
    var response = await _productsRepo.addProductToFav(productID);
    switch (response) {
      case Success<String>():
        print("--------------------");
        if (state.isFav = false) {
          safeEmit(state.copyWith(isFav: true));
        }
        safeEmit(state.copyWith(isFav: false));
        safeEmit(state.copyWith(fav: BaseStatus.success(data: response.data)));
      case Failure<String>():
        print("+++++++++++++++++");
        safeEmit(
          state.copyWith(fav: BaseStatus.failure(message: response.message)),
        );
    }
  }

  Future<void> _loadProducts(String categoryId) async {
    if (state.page > state.numberOfPages) {
      return;
    }

    if (state.page == 1) {
      safeEmit(state.copyWith(products: const BaseStatus.loading()));
    }
    var response = await _productsRepo.getAllProducts(
      10,
      state.page,
      categoryId,
    );

    switch (response) {
      case Success<PageableProducts>():
        {
          var products = response.data?.products ?? [];
          if (state.page != 1) {
            products = state.products.data ?? [];
            products.addAll(response.data?.products ?? []);
          }
          var page = state.page + 1;
          safeEmit(
            state.copyWith(
              page: (page),
              numberOfPages: response.data?.numberOfPages ?? state.page,
              products: BaseStatus.success(data: products),
            ),
          );
        }
      case Failure<PageableProducts>():
        {
          safeEmit(
            state.copyWith(
              products: BaseStatus.failure(
                exception: response.exception,
                message: response.message,
              ),
            ),
          );
        }
    }
  }
  //   if (state.isFetching || !state.hasMore) return;

  //   safeEmit(
  //     state.copyWith(isFetching: true, baseStatus: const BaseStatus.loading()),
  //   );

  //   final response = await _productsRepo.getAllProducts(
  //     10,
  //     state.currentPage,
  //     categoryId,
  //   );

  //   switch (response) {
  //     case Success<List<ProductsEntity>>():
  //       final updatedList = List<ProductsEntity>.from(state.products);
  //       updatedList.addAll(response.data ?? []);
  //       safeEmit(
  //         state.copyWith(
  //           products: updatedList,
  //           currentPage: state.currentPage + 1,
  //           hasMore: response.data?.isNotEmpty,
  //           isFetching: false,
  //           baseStatus: BaseStatus.success(data: updatedList),
  //         ),
  //       );

  //     case Failure<List<ProductsEntity>>():
  //       safeEmit(
  //         state.copyWith(
  //           isFetching: false,
  //           baseStatus: BaseStatus.failure(message: response.message),
  //         ),
  //       );
  //   }
  // }
}
