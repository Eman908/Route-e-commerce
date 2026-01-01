import 'package:e_commerce/core/base/base_cubit.dart';
import 'package:e_commerce/core/base/base_status.dart';
import 'package:e_commerce/core/di/di.dart';
import 'package:e_commerce/core/errors/results.dart';
import 'package:e_commerce/features/commerce/domain/entity/products_entity.dart';
import 'package:e_commerce/features/commerce/domain/repositry/commerce_repo.dart';
import 'package:e_commerce/features/commerce/presentation/tabs/favorites/cubit/fav_state.dart';
import 'package:injectable/injectable.dart';

@injectable
class FavCubit extends BaseCubit<FavState, FavListActions, void> {
  FavCubit() : super(FavState());
  final CommerceRepo _commerceRepo = getIt();
  @override
  Future<void> doAction(FavListActions action) async {
    switch (action) {
      case LoadAllFavList():
        await _loadFavList();
    }
  }

  Future<void> _loadFavList() async {
    safeEmit(state.copyWith(favList: const BaseStatus.loading()));
    var response = await _commerceRepo.getWishList();
    switch (response) {
      case Success<List<ProductsEntity>>():
        safeEmit(
          state.copyWith(favList: BaseStatus.success(data: response.data)),
        );
      case Failure<List<ProductsEntity>>():
        safeEmit(
          state.copyWith(
            favList: BaseStatus.failure(message: response.message),
          ),
        );
    }
  }
}
