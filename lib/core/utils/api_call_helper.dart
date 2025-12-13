import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:exam_app/core/shared/error/failure.dart';

class ApiCallHelper {
  static Future<Either<Failure, T>> executeApiCall<T, R>({
    required Future<R> Function() apiCall,
    T Function(R response)? onSuccess,
  }) async {
    try {
      final result = await apiCall();
      final transformed = onSuccess != null ? onSuccess(result) : result as T;
      return Right(transformed);
    } on DioException catch (e) {
      return Left(_handleDioException(e));
    } catch (e) {
      return Left(ServerFailure('Something went wrong. Please try again.'));
    }
  }

  /// Handle Dio exceptions and convert to Failure.
  static Failure _handleDioException(DioException e) {
    if (e.response != null) {
      final data = e.response?.data;

      // Check if response data is a Map before accessing.
      if (data is Map<String, dynamic>) {
        final message = data['message'] ?? data['error'] ?? 'Request failed';
        return ServerFailure(message);
      }

      return ServerFailure('Request failed');
    }

    // Network errors.
    if (e.type == DioExceptionType.connectionTimeout ||
        e.type == DioExceptionType.receiveTimeout) {
      return ServerFailure('Connection timeout. Please try again.');
    }

    if (e.type == DioExceptionType.connectionError) {
      return ServerFailure(
        'No internet connection. Please check your network.',
      );
    }

    return ServerFailure('Network error. Please try again.');
  }
}
