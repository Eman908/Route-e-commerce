import 'dart:convert';

import 'package:e_commerce/core/errors/results.dart';
import 'package:e_commerce/core/errors/safe_call.dart';
import 'package:e_commerce/features/commerce/data/datasource/contract/banners_local_data_source.dart';
import 'package:e_commerce/features/commerce/data/models/banners_response/banner.dart';
import 'package:e_commerce/features/commerce/data/models/banners_response/banners_model.dart';
import 'package:flutter/material.dart' hide Banner;
import 'package:injectable/injectable.dart';

@Injectable(as: BannersLocalDataSource)
class BannersLocalDataSourceImpl implements BannersLocalDataSource {
  final AssetBundle _assetBundle;
  BannersLocalDataSourceImpl(this._assetBundle);
  @override
  Future<Results<List<Banners>>> getBannersList() async {
    return safeCall(() async {
      var response = await _assetBundle.loadString(
        "assets/files/home_banners.json",
      );
      var decodeResponse = jsonDecode(response);
      var data = BannersResponse.fromJson(decodeResponse);
      if (data.banners == []) {
        return Failure(message: 'Something Went Wrong');
      }
      return Success(data.banners);
    });
  }
}
