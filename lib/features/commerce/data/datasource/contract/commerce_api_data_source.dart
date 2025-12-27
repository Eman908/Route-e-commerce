import 'package:e_commerce/core/errors/results.dart';
import 'package:e_commerce/features/commerce/data/models/categories_response/categories_response.dart';

abstract interface class CommerceApiDataSource {
  Future<Results<CategoriesResponse>> getAllCategories();
}
