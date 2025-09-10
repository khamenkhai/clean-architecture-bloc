import 'package:clean_architecture_bloc/core/local_data/preference_manager.dart';
import 'package:clean_architecture_bloc/core/network/api_client.dart';
import 'package:clean_architecture_bloc/features/auth/data/datasource/auth_remote_datasource.dart';
import 'package:clean_architecture_bloc/features/auth/data/repositories/auth_repo_impl.dart';
import 'package:clean_architecture_bloc/features/auth/domain/usecases/login_usecase.dart';
import 'package:clean_architecture_bloc/features/auth/presentation/cubit/auth_cubit.dart';
import 'package:clean_architecture_bloc/features/products/data/datasource/product_remote_datasource.dart';
import 'package:clean_architecture_bloc/features/products/data/repositories/product_repository_impl.dart';
import 'package:clean_architecture_bloc/features/products/domain/usecases/get_products.dart';
import 'package:clean_architecture_bloc/features/products/presentation/bloc/product_cubit.dart';
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:get_it/get_it.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';

final sl = GetIt.instance;

void init() {
  // -----------------------------
  // Core
  // -----------------------------
  /// Dio HTTP client
  sl.registerLazySingleton<Dio>(() {
    final dio = Dio(BaseOptions());

    // Add Pretty logger
    if (kDebugMode) {
      dio.interceptors.add(
        PrettyDioLogger(
          requestHeader: false,
          responseHeader: false,
          requestBody: true,
          responseBody: true,
          error: true,
          compact: true,
          maxWidth: 90,
        ),
      );
    }

    return dio;
  });
  sl.registerLazySingleton<ApiClient>(() => ApiClient(sl<Dio>()));

  // -----------------------------
  // Data sources
  // -----------------------------
  sl.registerLazySingleton(() => PreferenceManager());

  sl.registerLazySingleton(
    () => ProductRemoteDatasource(
      client: sl<ApiClient>(),
      preferenceManager: sl<PreferenceManager>(),
    ),
  );
  sl.registerLazySingleton(
    () => AuthRemoteDataSource(
      client: sl<ApiClient>(),
      preferenceManager: sl<PreferenceManager>(),
    ),
  );

  // -----------------------------
  // Repositories
  // -----------------------------
  sl.registerLazySingleton(
    () => AuthRepositoryImpl(remoteDataSource: sl<AuthRemoteDataSource>()),
  );
  sl.registerLazySingleton(
    () =>
        ProductRepositoryImpl(remoteDataSource: sl<ProductRemoteDatasource>()),
  );

  // -----------------------------
  // Use cases
  // -----------------------------
  sl.registerLazySingleton(
    () => LoginUsecase(repository: sl<AuthRepositoryImpl>()),
  );
  sl.registerLazySingleton(
    () => GetProducts(repository: sl<ProductRepositoryImpl>()),
  );
  // -----------------------------
  // Cubit
  // -----------------------------
  sl.registerFactory(() => AuthCubit(loginUseCase: sl<LoginUsecase>()));
  sl.registerFactory(() => ProductCubit(getProductsUseCase: sl<GetProducts>()));
}
