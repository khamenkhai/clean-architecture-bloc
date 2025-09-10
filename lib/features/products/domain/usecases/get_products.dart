import 'package:clean_architecture_bloc/core/network/failure.dart';
import 'package:clean_architecture_bloc/features/products/domain/entities/product_entity.dart';
import 'package:clean_architecture_bloc/features/products/domain/repositories/product_repository.dart';
import 'package:fpdart/fpdart.dart';

class GetProducts {
  final ProductRepository repository;
  GetProducts({required this.repository});

  Future<Either<Failure, List<ProductEntity>>> call() async =>
      await repository.getProducts();
}
