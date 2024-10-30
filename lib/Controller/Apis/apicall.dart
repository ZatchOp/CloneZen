import 'package:dio/dio.dart';
import 'package:fitzenapp/Controller/Apis/endpoints.dart';

class ApiService {
  final Dio _dio = Dio();

  ApiService() {
    _dio.options.baseUrl = EndPoints.baseUrl;
    _dio.options.connectTimeout =
        const Duration(microseconds: 5000); // 5 seconds
    _dio.options.receiveTimeout =
        const Duration(microseconds: 3000); // 3 seconds
  }

  Future<Response> fetchData(String endpoint) async {
    try {
      final response = await _dio.post(endpoint,
          data: {"Method_Name": "homepage", "SearchBy": "M008241012067"});
      return response; // Return the response
    } on DioException catch (e) {
      // Handle DioException
      if (e.response != null) {
        // The server responded with a non-200 status code
        print('Received invalid status code: ${e.response?.statusCode}');
      } else {
        switch (e.type) {
          case DioExceptionType.cancel:
            print('Request to API was cancelled');
            break;
          case DioExceptionType.connectionTimeout:
            print('Connection timeout with API');
            break;
          case DioExceptionType.sendTimeout:
            print('Send timeout with API');
            break;
          case DioExceptionType.receiveTimeout:
            print('Receive timeout with API');
            break;
          case DioExceptionType.badCertificate:
            print('Bad certificate error');
            break;
          case DioExceptionType.unknown:
            print('Unexpected error: ${e.message}');
            break;
          // You can add other specific cases if needed
          case DioExceptionType.badResponse:
            print('Unexpected error: ${e.message}');
            break;
          case DioExceptionType.connectionError:
            print('Unexpected error: ${e.message}');
            break;
        }
      }
      // Optionally, you can rethrow the error or return a default value
      rethrow;
    } catch (e) {
      // Handle any other type of error
      print('An error occurred: $e');
      rethrow;
    }
  }
}
