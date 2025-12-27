import 'package:e_commerce/features/commerce/data/models/banners_response/banner.dart';
import 'package:e_commerce/features/commerce/data/models/categories_response/datum.dart';
import 'package:e_commerce/features/commerce/domain/entity/banner_entity.dart';
import 'package:e_commerce/features/commerce/domain/entity/categories_entity.dart';
import 'package:flutter/material.dart';
import 'package:injectable/injectable.dart';

@injectable
class CommerceMapper {
  List<BannerEntity> convertBannersToBannerEntity(List<Banners> banner) {
    List<BannerEntity> response = banner
        .map((e) => _mapBannerToBannerEntity(e))
        .toList();
    return response;
  }

  BannerEntity _mapBannerToBannerEntity(Banners banner) {
    return BannerEntity(
      imagePath: banner.imagePath ?? '',
      title: banner.title ?? '',
      categoryName: banner.categoryName ?? '',
      alignment: (banner.alignment ?? 'start') == 'start'
          ? Alignment.centerRight
          : Alignment.centerLeft,
      btnColor: Color(banner.btnColor ?? 0),
      textColor: Color(banner.textColor ?? 0),
    );
  }

  List<CategoriesEntity> getListOfCategoriesMapper(List<Datum> categories) {
    var response = categories
        .map((e) => _mapCategoryResponseToCategoryEntity(e))
        .toList();
    return response;
  }

  CategoriesEntity _mapCategoryResponseToCategoryEntity(Datum category) {
    return CategoriesEntity(
      id: category.id,
      image: category.image,
      name: category.name,
    );
  }
}
