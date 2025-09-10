import 'package:clean_architecture_bloc/core/network/failure.dart';
import 'package:clean_architecture_bloc/features/products/domain/entities/product_entity.dart';
import 'package:fpdart/fpdart.dart';

abstract class ProductRepository {
  Future<Either<Failure, List<ProductEntity>>> getProducts();
}