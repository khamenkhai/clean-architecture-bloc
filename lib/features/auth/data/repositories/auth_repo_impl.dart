import 'package:clean_architecture_bloc/core/network/failure.dart';
import 'package:clean_architecture_bloc/features/auth/data/datasource/auth_remote_datasource.dart';
import 'package:clean_architecture_bloc/features/auth/domain/entities/user_entity.dart';
import 'package:clean_architecture_bloc/features/auth/domain/repositories/auth_repo.dart';
import 'package:fpdart/fpdart.dart';

class AuthRepositoryImpl implements AuthRepository {
  final AuthRemoteDataSource remoteDataSource;

  AuthRepositoryImpl({required this.remoteDataSource});

  @override
  Future<Either<Failure, UserEntity>> login({
    required Map<String, dynamic> bodyRequest,
  }) async {
    // Call remote datasource
    final eitherResult = await remoteDataSource.login(bodyRequest: bodyRequest);

    // Map LoginResponseModel to UserEntity if success, otherwise pass Failure
    return eitherResult.map(
      (data) => UserEntity(
        id: data.id,
        name: data.name,
        email: data.email,
        token: data.token,
      ),
    );
  }
}
