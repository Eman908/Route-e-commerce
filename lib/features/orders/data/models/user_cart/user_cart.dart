import 'data.dart';

class UserCartResponse {
  String? status;
  int? numOfCartItems;
  String? cartId;
  Data? data;

  UserCartResponse({this.status, this.numOfCartItems, this.cartId, this.data});

  factory UserCartResponse.fromJson(Map<String, dynamic> json) =>
      UserCartResponse(
        status: json['status'] as String?,
        numOfCartItems: json['numOfCartItems'] as int?,
        cartId: json['cartId'] as String?,
        data: json['data'] == null
            ? null
            : Data.fromJson(json['data'] as Map<String, dynamic>),
      );

  Map<String, dynamic> toJson() => {
    'status': status,
    'numOfCartItems': numOfCartItems,
    'cartId': cartId,
    'data': data?.toJson(),
  };
}
