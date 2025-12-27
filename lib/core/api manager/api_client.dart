import 'package:dio/dio.dart';
import 'package:e_commerce/core/constants/api_constants.dart';
import 'package:e_commerce/features/auth/data/models/auth_response/auth_response.dart';
import 'package:e_commerce/features/auth/data/models/login_request.dart';
import 'package:e_commerce/features/auth/data/models/register_request.dart';
import 'package:e_commerce/features/commerce/data/models/categories_response/categories_response.dart';
import 'package:injectable/injectable.dart';
import 'package:retrofit/retrofit.dart';

part 'api_client.g.dart';

@singleton
@RestApi()
abstract class ApiClient {
  @factoryMethod
  factory ApiClient(Dio dio) = _ApiClient;

  @POST(ApiConstants.signUp)
  Future<AuthResponse> signUp(@Body() RegisterRequest request);

  @POST(ApiConstants.signIn)
  Future<AuthResponse> logIn(@Body() LoginRequest request);

  @GET(ApiConstants.getAllCategories)
  Future<CategoriesResponse> getAllCategories();

  // @POST(ApiConstants.forgetPassword)
  // Future<String> forgetPassword(@Body() String email);

  // @POST(ApiConstants.verifyRestCode)
  // Future<String> verifyCode(@Body() String code);

  // @PUT(ApiConstants.resetPassword)
  // Future<String> resetPassword(@Body() String newPassword);
}
