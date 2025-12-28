import 'package:e_commerce/core/base/base_status.dart';
import 'package:e_commerce/features/commerce/domain/entity/categories_entity.dart';

class CategoriesState {
  BaseStatus<List<CategoriesEntity>>? categoriesStatus;

  CategoriesState({this.categoriesStatus = const BaseStatus.initial()});

  CategoriesState copyWith({
    BaseStatus<List<CategoriesEntity>>? categoriesStatus,
  }) {
    return CategoriesState(
      categoriesStatus: categoriesStatus ?? this.categoriesStatus,
    );
  }

  @override
  String toString() {
    return 'CategoriesState{'
        'categories: ${categoriesStatus?.data?.length ?? 0} items'
        '}';
  }
}

sealed class CategoriesActions {}

final class LoadCategories extends CategoriesActions {}
