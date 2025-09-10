import 'package:dio/dio.dart';

class ErrorHandler {
  static String handleDioError(DioException dioError) {
    if (dioError.response != null) {
      final response = dioError.response!;
      final data = response.data;

      // Case 1: JSON response with 'message'
      if (data is Map<String, dynamic> && data.containsKey('message')) {
        return data['message'] ?? "Unknown server error";
      }

      // Case 2: Plain text response (like "username or password is incorrect")
      if (data is String && data.isNotEmpty) {
        return data;
      }

      // Case 3: Fallback: status code
      return 'Request failed with status: ${response.statusCode}';
    } else {
      // No response (network error, timeout, etc.)
      return dioError.message ?? "Something went wrong!";
    }
  }
}
