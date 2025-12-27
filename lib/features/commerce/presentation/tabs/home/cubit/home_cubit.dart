import 'package:e_commerce/core/base/base_cubit.dart';
import 'package:e_commerce/core/base/base_status.dart';
import 'package:e_commerce/core/di/di.dart';
import 'package:e_commerce/core/errors/results.dart';
import 'package:e_commerce/features/commerce/domain/entity/banner_entity.dart';
import 'package:e_commerce/features/commerce/domain/entity/categories_entity.dart';
import 'package:e_commerce/features/commerce/domain/repositry/home_repo.dart';
import 'package:e_commerce/features/commerce/presentation/tabs/home/cubit/home_state.dart';
import 'package:injectable/injectable.dart';

@injectable
class HomeCubit extends BaseCubit<HomeState, HomeActions, void> {
  HomeCubit() : super(HomeState());
  final HomeRepo _homeRepo = getIt();
  @override
  Future<void> doAction(HomeActions action) async {
    switch (action) {
      case LoadHomeBanners():
        _loadHomeBanners();
      case LoadHomeCategories():
        _loadHomeCategories();
    }
  }

  Future<void> _loadHomeCategories() async {
    safeEmit(state.copyWith(categoriesStatus: const BaseStatus.loading()));
    var response = await _homeRepo.getAllCategories();
    switch (response) {
      case Success<List<CategoriesEntity>>():
        safeEmit(
          state.copyWith(
            categoriesStatus: BaseStatus.success(data: response.data),
          ),
        );
      case Failure<List<CategoriesEntity>>():
        safeEmit(
          state.copyWith(
            categoriesStatus: BaseStatus.failure(message: response.message),
          ),
        );
    }
  }

  Future<void> _loadHomeBanners() async {
    safeEmit(state.copyWith(bannersStatus: const BaseStatus.loading()));
    var response = await _homeRepo.getHomeBanners();
    switch (response) {
      case Success<List<BannerEntity>>():
        safeEmit(
          state.copyWith(
            bannersStatus: BaseStatus.success(data: response.data),
          ),
        );
      case Failure<List<BannerEntity>>():
        safeEmit(
          state.copyWith(
            bannersStatus: BaseStatus.failure(message: response.message),
          ),
        );
    }
  }
}
