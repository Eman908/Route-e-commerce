import 'package:e_commerce/core/errors/results.dart';
import 'package:e_commerce/features/commerce/domain/entity/banner_entity.dart';
import 'package:e_commerce/features/commerce/domain/entity/categories_entity.dart';
import 'package:e_commerce/features/commerce/domain/entity/products_entity.dart';

abstract interface class CommerceRepo {
  Future<Results<List<BannerEntity>>> getHomeBanners();
  Future<Results<List<CategoriesEntity>>> getAllCategories();
  Future<Results<List<ProductsEntity>>> getWishList();
}
