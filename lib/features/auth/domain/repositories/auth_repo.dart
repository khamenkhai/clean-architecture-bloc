import 'package:clean_architecture_bloc/core/network/failure.dart';
import 'package:clean_architecture_bloc/features/auth/domain/entities/user_entity.dart';
import 'package:fpdart/fpdart.dart';

abstract class AuthRepository {
  Future<Either<Failure, UserEntity>> login({
    required Map<String, dynamic> bodyRequest,
  });
}
