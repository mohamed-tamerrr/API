import 'package:API/core/network/api_exceptions.dart';
import 'package:API/core/network/dio_client.dart';
import 'package:dio/dio.dart';

class ApiService {
  ApiService({required this.dioClient});
  final DioClient dioClient;

  /// Get
  Future<dynamic> get({required String endPoint}) async {
    try {
      final response = await dioClient.dio.get(endPoint);
      return response.data;
    } on DioException catch (e) {
      throw ApiException.fromDioException(e);
    }
  }

  /// Post
  Future<dynamic> post({
    required String endPoint,
    required dynamic data,
  }) async {
    try {
      final response = await dioClient.dio.post(
        endPoint,
        data: data,
      );
      return response.data;
    } on DioException catch (e) {
      throw ApiException.fromDioException(e);
    }
  }

  /// Put = Update
  Future<dynamic> put({
    required String endPoint,
    required dynamic data,
  }) async {
    try {
      final response = await dioClient.dio.put(
        endPoint,
        data: data,
      );
      return response.data;
    } on DioException catch (e) {
      throw ApiException.fromDioException(e);
    }
  }

  /// Delete
  Future<dynamic> delete({required String endpoint}) async {
    try {
      final response = await dioClient.dio.delete(endpoint);
      return response.data;
    } on DioException catch (e) {
      throw ApiException.fromDioException(e);
    }
  }
}
