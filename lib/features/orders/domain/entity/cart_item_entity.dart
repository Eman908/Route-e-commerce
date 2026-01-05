class CartItemEntity {
  int? count;
  String? id;
  String? title;
  String? description;
  int? price;
  //num? totalPrice;
  String? imageCover;
  String? categoryId;
  double? ratingsAverage;

  CartItemEntity({
    this.categoryId,
    this.count,
    this.description,
    this.id,
    this.imageCover,
    this.price,
    this.ratingsAverage,
    this.title,
  });
}
