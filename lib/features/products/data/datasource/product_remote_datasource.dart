import 'package:clean_architecture_bloc/core/local_data/preference_manager.dart';
import 'package:clean_architecture_bloc/core/network/api_client.dart';
import 'package:clean_architecture_bloc/core/network/error_message.dart';
import 'package:clean_architecture_bloc/core/network/failure.dart';
import 'package:fpdart/fpdart.dart';
import '../models/product_model.dart';
import 'package:dio/dio.dart';

class ProductRemoteDatasource {
  final ApiClient client;
  final PreferenceManager preferenceManager;
  ProductRemoteDatasource({
    required this.client,
    required this.preferenceManager,
  });

  Future<Either<Failure, List<ProductModel>>> getProducts() async {
    try {
      final result = await client.getProducts();

      return Right(result);
    } on DioException catch (e) {
      final message = ErrorHandler.handleDioError(e);
      return Left(Failure(message));
    } catch (e) {
      return Left(Failure(e.toString()));
    }
  }
}
