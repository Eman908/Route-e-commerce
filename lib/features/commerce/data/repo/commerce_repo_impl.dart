import 'package:e_commerce/core/di/di.dart';
import 'package:e_commerce/core/errors/results.dart';
import 'package:e_commerce/features/commerce/data/datasource/contract/banners_local_data_source.dart';
import 'package:e_commerce/features/commerce/data/datasource/contract/commerce_api_data_source.dart';
import 'package:e_commerce/features/commerce/data/mappers/commerce_mapper.dart';
import 'package:e_commerce/features/commerce/data/mappers/products_mapper.dart';
import 'package:e_commerce/features/commerce/data/models/banners_response/banner.dart';
import 'package:e_commerce/features/commerce/data/models/categories_response/categories_response.dart';
import 'package:e_commerce/features/commerce/data/models/products_dto/datum.dart';
import 'package:e_commerce/features/commerce/domain/entity/banner_entity.dart';
import 'package:e_commerce/features/commerce/domain/entity/categories_entity.dart';
import 'package:e_commerce/features/commerce/domain/entity/products_entity.dart';
import 'package:e_commerce/features/commerce/domain/repositry/commerce_repo.dart';
import 'package:injectable/injectable.dart';

@Injectable(as: CommerceRepo)
class CommerceRepoImpl implements CommerceRepo {
  final BannersLocalDataSource _bannersLocalDataSource = getIt();
  final CommerceMapper _commerceMapper = getIt();
  final ProductsMapper _productsMapper = getIt();
  final CommerceApiDataSource _commerceApiDataSource = getIt();
  @override
  Future<Results<List<BannerEntity>>> getHomeBanners() async {
    var response = await _bannersLocalDataSource.getBannersList();
    switch (response) {
      case Success<List<Banners>>():
        return Success(
          _commerceMapper.convertBannersToBannerEntity(response.data ?? []),
        );
      case Failure<List<Banners>>():
        return Failure(message: response.message);
    }
  }

  @override
  Future<Results<List<CategoriesEntity>>> getAllCategories() async {
    var response = await _commerceApiDataSource.getAllCategories();
    switch (response) {
      case Success<CategoriesResponse>():
        return Success(
          _commerceMapper.getListOfCategoriesMapper(response.data?.data ?? []),
        );
      case Failure<CategoriesResponse>():
        return Failure(message: response.message);
    }
  }

  @override
  Future<Results<List<ProductsEntity>>> getWishList() async {
    var response = await _commerceApiDataSource.getWishList();
    switch (response) {
      case Success<List<Datum>>():
        return Success(_productsMapper.mapProductsList(response.data ?? []));
      case Failure<List<Datum>>():
        return Failure(message: response.message);
    }
  }
}
