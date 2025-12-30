class AddToFav {
  String? status;
  String? message;
  List<String>? data;

  AddToFav({this.status, this.message, this.data});

  factory AddToFav.fromJson(Map<String, dynamic> json) => AddToFav(
    status: json['status'] as String?,
    message: json['message'] as String?,
    data: json['data'] as List<String>?,
  );

  Map<String, dynamic> toJson() => {
    'status': status,
    'message': message,
    'data': data,
  };
}
