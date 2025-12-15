import 'package:dartz/dartz.dart';
import 'package:exam_app/core/config/error/error_handler.dart';

class ApiCallHelper {
  static Future<Either<Failure, T>> executeApiCall<T, R>({
    required Future<R> Function() apiCall,
    T Function(R response)? onSuccess,
  }) async {
    try {
      final result = await apiCall();
      final transformed = onSuccess != null ? onSuccess(result) : result as T;
      return Right(transformed);
    } catch (error) {
      return Left(ErrorHandler.handle(error).failure);
    }
  }
}