import 'package:e_commerce/core/api%20manager/api_client.dart';
import 'package:e_commerce/core/di/di.dart';
import 'package:e_commerce/core/errors/results.dart';
import 'package:e_commerce/core/errors/safe_call.dart';
import 'package:e_commerce/features/commerce/data/datasource/contract/commerce_api_data_source.dart';
import 'package:e_commerce/features/commerce/data/models/categories_response/categories_response.dart';
import 'package:e_commerce/features/commerce/data/models/products_dto/datum.dart';
import 'package:injectable/injectable.dart';

@Injectable(as: CommerceApiDataSource)
class CommerceApiDataSourceImpl implements CommerceApiDataSource {
  final ApiClient _apiClient = getIt();
  @override
  Future<Results<CategoriesResponse>> getAllCategories() async {
    return safeCall(() async {
      var response = await _apiClient.getAllCategories();
      if (response.data == null || response.data!.isEmpty) {
        return Failure(message: 'No Categories To Show');
      }
      return Success(response);
    });
  }

  @override
  Future<Results<List<Datum>>> getWishList() async {
    return safeCall(() async {
      var response = await _apiClient.getWishList();
      if (response.isEmpty) {
        return Failure(message: 'No Products To Display');
      }
      return Success(response);
    });
  }
}
