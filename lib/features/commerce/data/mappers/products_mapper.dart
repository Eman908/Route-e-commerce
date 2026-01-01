import 'package:e_commerce/features/commerce/data/models/products_dto/datum.dart';
import 'package:e_commerce/features/commerce/data/models/products_dto/products_dto.dart';
import 'package:e_commerce/features/commerce/domain/entity/pageable_product.dart';
import 'package:e_commerce/features/commerce/domain/entity/products_entity.dart';
import 'package:injectable/injectable.dart';

@injectable
class ProductsMapper {
  List<ProductsEntity> mapProductsList(List<Datum> products) {
    var result = products.map((e) => _mapProductsToProductsEntity(e)).toList();
    return result;
  }

  ProductsEntity _mapProductsToProductsEntity(Datum product) {
    return ProductsEntity(
      id: product.id,
      availableColors: product.availableColors,
      description: product.description,
      imageCover: product.imageCover,
      images: product.images,
      quantity: product.quantity,
      ratingsAverage: product.ratingsAverage,
      ratingsQuantity: product.ratingsQuantity,
      slug: product.slug,
      title: product.title,
      price: product.price,
      priceAfterDiscount: product.priceAfterDiscount,
      categoryId: product.category?.id,
    );
  }

  PageableProducts mapPageableProductsResponseToEntity(ProductsDto? response) {
    var currentPage = (response?.metadata?.currentPage ?? 1).toInt();
    var numberOfPages = (response?.metadata?.numberOfPages ?? 1).toInt();
    var products = mapProductsList(response?.data ?? []);
    return PageableProducts(currentPage, numberOfPages, products);
  }
}
