import 'package:e_commerce/core/errors/results.dart';
import 'package:e_commerce/features/commerce/data/models/banners_response/banner.dart';

abstract interface class BannersLocalDataSource {
  Future<Results<List<Banners>>> getBannersList();
}
