import 'package:clean_architecture_bloc/core/network/failure.dart';
import 'package:clean_architecture_bloc/features/products/data/datasource/product_remote_datasource.dart';
import 'package:fpdart/fpdart.dart';
import '../../domain/entities/product_entity.dart';
import '../../domain/repositories/product_repository.dart';

class ProductRepositoryImpl implements ProductRepository {
  final ProductRemoteDatasource remoteDataSource;
  ProductRepositoryImpl({required this.remoteDataSource});

  @override
  Future<Either<Failure, List<ProductEntity>>> getProducts() async {
    final result = await remoteDataSource.getProducts();
    // Convert ProductModel -> Product if needed
    return result.map((models) => models.map((m) => m as ProductEntity).toList());
  }


}
