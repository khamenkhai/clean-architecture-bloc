import 'package:clean_architecture_bloc/core/network/failure.dart';
import 'package:clean_architecture_bloc/features/auth/domain/entities/user_entity.dart';
import 'package:clean_architecture_bloc/features/auth/domain/repositories/auth_repo.dart';
import 'package:fpdart/fpdart.dart';

class LoginUsecase {
  final AuthRepository repository;
  LoginUsecase({required this.repository});

  Future<Either<Failure, UserEntity>> call({
    required Map<String, dynamic> bodyRequest,
  }) async => await repository.login(bodyRequest: bodyRequest);
}
