import 'banner.dart';

class BannersResponse {
  List<Banners>? banners;

  BannersResponse({this.banners});

  factory BannersResponse.fromJson(Map<String, dynamic> json) =>
      BannersResponse(
        banners: (json['banners'] as List<dynamic>?)
            ?.map((e) => Banners.fromJson(e as Map<String, dynamic>))
            .toList(),
      );

  Map<String, dynamic> toJson() => {
    'banners': banners?.map((e) => e.toJson()).toList(),
  };
}
