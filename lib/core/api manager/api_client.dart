import 'package:dio/dio.dart';
import 'package:e_commerce/core/constants/api_constants.dart';
import 'package:e_commerce/features/auth/data/models/auth_response/auth_response.dart';
import 'package:e_commerce/features/auth/data/models/login_request.dart';
import 'package:e_commerce/features/auth/data/models/register_request.dart';
import 'package:e_commerce/features/commerce/data/models/add_to_fav.dart';
import 'package:e_commerce/features/commerce/data/models/categories_response/categories_response.dart';
import 'package:e_commerce/features/commerce/data/models/products_dto/datum.dart';
import 'package:e_commerce/features/commerce/data/models/products_dto/products_dto.dart';
import 'package:e_commerce/features/orders/data/models/user_cart/user_cart.dart';
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

  @GET(ApiConstants.getAllProducts)
  Future<ProductsDto> getAllProducts(
    @Query('limit') int limit,
    @Query("page") int page,
    @Query("category[in]") String categoryId,
  );

  @POST(ApiConstants.addProductToWishlist)
  Future<AddToFav> addProductToFav(@Body() Map<String, dynamic> productId);

  @DELETE(ApiConstants.removeProductFromWishList)
  Future<AddToFav> removeProductFromFav(@Path('id') String productId);

  @POST(ApiConstants.forgetPassword)
  Future<Map<String, dynamic>> forgetPassword(
    @Body() Map<String, dynamic> email,
  );

  @POST(ApiConstants.verifyRestCode)
  Future<Map<String, dynamic>> verifyCode(@Body() Map<String, dynamic> code);

  @PUT(ApiConstants.resetPassword)
  Future<Map<String, dynamic>> resetPassword(@Body() Map<String, dynamic> body);

  @GET(ApiConstants.getWishList)
  Future<List<Datum>> getWishList();

  @DELETE(ApiConstants.cart)
  Future<Map<String, dynamic>> deleteAllCartItems();

  @DELETE(ApiConstants.removeProductFromCart)
  Future<UserCartResponse> deleteCartItems(@Path('id') String productId);

  @GET(ApiConstants.cart)
  Future<UserCartResponse> getAllCart();

  @PUT(ApiConstants.updateCartProductQuantity)
  Future<UserCartResponse> updateCartProductQuantity(
    @Path('id') String productId,
    @Body() Map<String, dynamic> count,
  );

  @POST(ApiConstants.cart)
  Future<UserCartResponse> addProductToCart(
    @Body() Map<String, dynamic> productId,
  );
}
