// features/auth/data/models/login_response_model.dart
import 'package:clean_architecture_bloc/features/auth/domain/entities/user_entity.dart';

class LoginResponseModel extends UserEntity {
  LoginResponseModel({required super.token});

  // Factory to create from JSON manually
  factory LoginResponseModel.fromJson(Map<String, dynamic> json) {
    return LoginResponseModel(
      token: json['token'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {"token": token};
  }
}
