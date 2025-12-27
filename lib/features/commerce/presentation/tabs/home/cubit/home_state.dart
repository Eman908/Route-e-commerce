import 'package:e_commerce/core/base/base_status.dart';
import 'package:e_commerce/features/commerce/domain/entity/banner_entity.dart';
import 'package:e_commerce/features/commerce/domain/entity/categories_entity.dart';

class HomeState {
  BaseStatus<List<BannerEntity>>? bannersStatus;
  BaseStatus<List<CategoriesEntity>>? categoriesStatus;

  HomeState({
    this.bannersStatus = const BaseStatus.initial(),
    this.categoriesStatus = const BaseStatus.initial(),
  });

  HomeState copyWith({
    BaseStatus<List<BannerEntity>>? bannersStatus,
    BaseStatus<List<CategoriesEntity>>? categoriesStatus,
  }) {
    return HomeState(
      bannersStatus: bannersStatus ?? this.bannersStatus,
      categoriesStatus: categoriesStatus ?? this.categoriesStatus,
    );
  }

  @override
  String toString() {
    return 'HomeState{'
        'banners: ${bannersStatus?.data?.length ?? 0} items, '
        'categories: ${categoriesStatus?.data?.length ?? 0} items'
        '}';
  }
}

sealed class HomeActions {}

final class LoadHomeBanners extends HomeActions {}

final class LoadHomeCategories extends HomeActions {}
