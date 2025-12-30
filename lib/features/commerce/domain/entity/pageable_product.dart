import 'package:e_commerce/features/commerce/domain/entity/products_entity.dart';

class PageableProducts {
  int currentPage;
  int numberOfPages;
  List<ProductsEntity> products;

  PageableProducts(this.currentPage, this.numberOfPages, this.products);
}
