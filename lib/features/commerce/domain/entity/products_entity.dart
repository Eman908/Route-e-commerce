class ProductsEntity {
  List<String>? images;
  int? ratingsQuantity;
  String? title;
  String? slug;
  String? description;
  int? quantity;
  int? price;
  String? imageCover;
  String? categoryId;
  double? ratingsAverage;
  DateTime? updatedAt;
  String? id;
  int? priceAfterDiscount;
  List<String>? availableColors;
  int? currentPage;

  ProductsEntity({
    this.images,
    this.ratingsQuantity,
    this.title,
    this.slug,
    this.description,
    this.quantity,
    this.price,
    this.imageCover,
    this.categoryId,
    this.ratingsAverage,
    this.updatedAt,
    this.id,
    this.priceAfterDiscount,
    this.availableColors,
    this.currentPage,
  });
}
