import 'package:dio/dio.dart';
import 'package:hoora/constants/api_constants.dart';

class ApiProvider {
  final Dio _dio;

  ApiProvider()
      : _dio = Dio(BaseOptions(
    baseUrl: ApiConstants.baseUrl,
    connectTimeout: Duration(seconds: 10),
    receiveTimeout: Duration(seconds: 10),
    headers: {
      "Content-Type": "application/json",
    },
  ));

  // GET Request
  Future<Response> getRequest(String endpoint,
      {Map<String, dynamic>? queryParams}) async {
    try {
      final response = await _dio.get(endpoint, queryParameters: queryParams);
      return response;
    } catch (e) {
      rethrow;
    }
  }

  // POST Request
  Future<Response> postRequest(String endpoint, dynamic data) async {
    try {
      final response = await _dio.post(endpoint, data: data);
      return response;
    } catch (e) {
      rethrow;
    }
  }

  // PUT Request
  Future<Response> putRequest(String endpoint, dynamic data) async {
    try {
      final response = await _dio.put(endpoint, data: data);
      return response;
    } catch (e) {
      rethrow;
    }
  }

  //DELETE Request
  Future<Response> deleteRequest(String endpoint,
      {dynamic data}) async {
    try {
      final response = await _dio.delete(endpoint, data: data);
      return response;
    } catch (e) {
      rethrow;
    }
  }
}
