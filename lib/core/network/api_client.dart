// core/network/api_client.dart
import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';
import '../../features/products/data/models/product_model.dart';
import '../../features/auth/data/models/response_model/login_model.dart';

part 'api_client.g.dart';

@RestApi(baseUrl: "https://fakestoreapi.com")

abstract class ApiClient {
  factory ApiClient(Dio dio, {String baseUrl}) = _ApiClient;

  // Auth
  @POST("/auth/login")
  Future<LoginResponseModel> login(@Body() Map<String, dynamic> body);

  // Products
  @GET("/products")
  Future<List<ProductModel>> getProducts();
}
