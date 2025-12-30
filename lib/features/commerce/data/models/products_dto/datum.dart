import 'brand.dart';
import 'category.dart';

class Datum {
  int? sold;
  List<String>? images;
  int? ratingsQuantity;
  String? title;
  String? slug;
  String? description;
  int? quantity;
  int? price;
  String? imageCover;
  Category? category;
  Brand? brand;
  double? ratingsAverage;
  DateTime? createdAt;
  DateTime? updatedAt;
  String? id;
  int? priceAfterDiscount;
  List<String>? availableColors;

  Datum({
    this.sold,
    this.images,
    this.ratingsQuantity,
    this.title,
    this.slug,
    this.description,
    this.quantity,
    this.price,
    this.imageCover,
    this.category,
    this.brand,
    this.ratingsAverage,
    this.createdAt,
    this.updatedAt,
    this.id,
    this.priceAfterDiscount,
    this.availableColors,
  });

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
    sold: json['sold'] as int?,

    // ✅ FIXED: Proper List<String> conversion
    images: _parseStringList(json['images']),

    ratingsQuantity: json['ratingsQuantity'] as int?,
    id: json['_id'] as String?,
    title: json['title'] as String?,
    slug: json['slug'] as String?,
    description: json['description'] as String?,
    quantity: json['quantity'] as int?,
    price: json['price'] as int?,
    imageCover: json['imageCover'] as String?,

    category: json['category'] == null
        ? null
        : Category.fromJson(json['category'] as Map<String, dynamic>),

    brand: json['brand'] == null
        ? null
        : Brand.fromJson(json['brand'] as Map<String, dynamic>),

    ratingsAverage: (json['ratingsAverage'] as num?)?.toDouble(),

    createdAt: json['createdAt'] == null
        ? null
        : DateTime.parse(json['createdAt'] as String),

    updatedAt: json['updatedAt'] == null
        ? null
        : DateTime.parse(json['updatedAt'] as String),

    priceAfterDiscount: json['priceAfterDiscount'] as int?,

    // ✅ FIXED: Proper List<String> conversion
    availableColors: _parseStringList(json['availableColors']),
  );

  // Helper method to safely parse List<String>
  static List<String>? _parseStringList(dynamic jsonValue) {
    if (jsonValue == null) return null;
    if (jsonValue is List<dynamic>) {
      return jsonValue.cast<String>().toList();
    }
    return null;
  }

  Map<String, dynamic> toJson() => {
    'sold': sold,
    'images': images,
    'ratingsQuantity': ratingsQuantity,
    '_id': id,
    'title': title,
    'slug': slug,
    'description': description,
    'quantity': quantity,
    'price': price,
    'imageCover': imageCover,
    'category': category?.toJson(),
    'brand': brand?.toJson(),
    'ratingsAverage': ratingsAverage,
    'createdAt': createdAt?.toIso8601String(),
    'updatedAt': updatedAt?.toIso8601String(),
    'priceAfterDiscount': priceAfterDiscount,
    'availableColors': availableColors,
  };
}
