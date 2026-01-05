import 'package:e_commerce/features/commerce/data/models/products_dto/datum.dart';

class CartProduct {
  int? count;
  String? id;
  Datum? product;
  int? price;

  CartProduct({this.count, this.id, this.product, this.price});

  factory CartProduct.fromJson(Map<String, dynamic> json) => CartProduct(
    count: json['count'] as int?,
    id: json['_id'] as String?,
    product: json['product'] == null
        ? null
        : Datum.fromJson(json['product'] as Map<String, dynamic>),
    price: json['price'] as int?,
  );

  Map<String, dynamic> toJson() => {
    'count': count,
    '_id': id,
    'product': product?.toJson(),
    'price': price,
  };
}
