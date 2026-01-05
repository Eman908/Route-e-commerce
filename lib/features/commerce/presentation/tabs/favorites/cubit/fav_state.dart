import 'package:e_commerce/core/base/base_status.dart';
import 'package:e_commerce/features/commerce/domain/entity/products_entity.dart';

class FavState {
  BaseStatus<List<ProductsEntity>> favList;
  FavState({this.favList = const BaseStatus.initial()});
  FavState copyWith({BaseStatus<List<ProductsEntity>>? favList}) {
    return FavState(favList: favList ?? this.favList);
  }
}

sealed class FavListActions {}

final class LoadAllFavList extends FavListActions {}
