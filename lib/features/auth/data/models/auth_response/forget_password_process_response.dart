class ForgetPasswordProcessResponse {
  String? statusMsg;
  String? message;

  ForgetPasswordProcessResponse({this.statusMsg, this.message});

  factory ForgetPasswordProcessResponse.fromJson(Map<String, dynamic> json) {
    return ForgetPasswordProcessResponse(
      statusMsg: json['statusMsg'] as String?,
      message: json['message'] as String?,
    );
  }

  Map<String, dynamic> toJson() => {'statusMsg': statusMsg, 'message': message};
}
