import 'package:flutter_bloc/flutter_bloc.dart';
import 'auth_state.dart';
import 'package:clean_architecture_bloc/features/auth/domain/usecases/login_usecase.dart';

class AuthCubit extends Cubit<AuthState> {
  final LoginUsecase loginUseCase;

  AuthCubit({required this.loginUseCase}) : super(AuthInitial());

  Future<void> login({required String name, required String password}) async {
    emit(AuthLoading());

    final result = await loginUseCase.call(
      bodyRequest: {'username': name, 'password': password},
    );

    result.fold(
      (failure) => emit(AuthFailure(message: failure.message)),
      (user) => emit(AuthSuccess(user: user)),
    );
  }
}
