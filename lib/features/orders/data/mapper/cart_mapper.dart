import 'package:e_commerce/features/orders/data/models/user_cart/product.dart';
import 'package:e_commerce/features/orders/domain/entity/cart_item_entity.dart';
import 'package:injectable/injectable.dart';

@injectable
class CartMapper {
  List<CartItemEntity> mappToCartEntity(List<CartProduct> product) {
    return product
        .map(
          (e) => CartItemEntity(
            categoryId: e.product?.category?.id,
            count: e.count,
            description: e.product?.description,
            id: e.product?.id,
            imageCover: e.product?.imageCover,
            price: e.price,
            ratingsAverage: e.product?.ratingsAverage,
            title: e.product?.title,
          ),
        )
        .toList();
  }
}
