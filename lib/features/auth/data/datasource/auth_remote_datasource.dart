import 'package:clean_architecture_bloc/core/local_data/preference_manager.dart';
import 'package:clean_architecture_bloc/core/network/api_client.dart';
import 'package:clean_architecture_bloc/core/network/error_message.dart';
import 'package:clean_architecture_bloc/core/network/failure.dart';
import 'package:fpdart/fpdart.dart';
import '../models/response_model/login_model.dart';
import 'package:dio/dio.dart';

class AuthRemoteDataSource {
  final ApiClient client;
  final PreferenceManager preferenceManager;
  AuthRemoteDataSource({required this.client, required this.preferenceManager});

  Future<Either<Failure, LoginResponseModel>> login({
    required Map<String, dynamic> bodyRequest,
  }) async {
    try {
      final result = await client.login(bodyRequest);

      return Right(result);
    } on DioException catch (e) {
      final message = ErrorHandler.handleDioError(e);
      return Left(Failure(message));
    } catch (e) {
      return Left(Failure(e.toString()));
    }
  }
}
