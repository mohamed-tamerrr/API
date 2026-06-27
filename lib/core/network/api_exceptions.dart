import 'package:dio/dio.dart';

abstract class Failure {
  final String errorMessage;

  const Failure({required this.errorMessage});
}

class ApiException extends Failure {
  const ApiException({required super.errorMessage});

  factory ApiException.fromDioException(
    DioException dioException,
  ) {
    switch (dioException.type) {
      case DioExceptionType.connectionTimeout:
        return const ApiException(
          errorMessage: 'Connection timeout with ApiServer',
        );

      case DioExceptionType.sendTimeout:
        return const ApiException(
          errorMessage: 'Send timeout with ApiServer',
        );

      case DioExceptionType.receiveTimeout:
        return const ApiException(
          errorMessage: 'Receive timeout with ApiServer',
        );

      case DioExceptionType.badResponse:
        return ApiException.fromResponse(
          dioException.response?.statusCode,
          dioException.response?.data,
        );

      case DioExceptionType.cancel:
        return const ApiException(
          errorMessage: 'Request to ApiServer was cancelled',
        );

      case DioExceptionType.unknown:
        if (dioException.message?.contains('SocketException') ??
            false) {
          return const ApiException(
            errorMessage: 'No Internet Connection',
          );
        }

        return const ApiException(
          errorMessage:
              'Unexpected error, please try again later.',
        );

      default:
        return const ApiException(
          errorMessage:
              'Oops! There was an error, please try again.',
        );
    }
  }

  factory ApiException.fromResponse(
    int? statusCode,
    dynamic response,
  ) {
    String message = 'Unknown Error';

    if (response is Map<String, dynamic>) {
      message =
          response['message'] ??
          response['error'] ??
          'Unknown Error';
    }

    switch (statusCode) {
      case 400:
      case 401:
      case 403:
        return ApiException(errorMessage: message);

      case 404:
        return const ApiException(
          errorMessage:
              'Your request was not found, please try later.',
        );

      case 500:
        return const ApiException(
          errorMessage:
              'Internal server error, please try later.',
        );

      default:
        return ApiException(errorMessage: message);
    }
  }
}
