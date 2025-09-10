import 'package:clean_architecture_bloc/features/products/domain/usecases/get_products.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'product_state.dart';

class ProductCubit extends Cubit<ProductState> {
  final GetProducts getProductsUseCase;
  ProductCubit({required this.getProductsUseCase}) : super(ProductInitial());

  /// Load all products
  Future<void> loadProducts() async {
    emit(ProductLoading());
    final result = await getProductsUseCase.call();
    result.match(
      (failure) => emit(ProductError(failure.message)),
      (products) => emit(ProductLoaded(products)),
    );
  }
}
