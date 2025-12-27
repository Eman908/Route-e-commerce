import 'package:e_commerce/core/errors/results.dart';
import 'package:e_commerce/features/commerce/domain/entity/banner_entity.dart';
import 'package:e_commerce/features/commerce/domain/entity/categories_entity.dart';

abstract interface class HomeRepo {
  Future<Results<List<BannerEntity>>> getHomeBanners();
  Future<Results<List<CategoriesEntity>>> getAllCategories();
}
