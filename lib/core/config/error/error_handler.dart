import 'package:dio/dio.dart';
import 'package:exam_app/core/constants/api_messages.dart';

class Failure<T> {
  int statusCode;
  String message;
  bool success;
  int status;
  String? prettyMessage;
  Map<String, dynamic>? jsonErrorObject;

  Failure({
    required this.statusCode,
    required this.message,
    required this.success,
    required this.status,
    this.prettyMessage,
    this.jsonErrorObject,
  });
}

class ApiInternalStatus {
  static const int success = 1;
  static const int failure = 0;
}

class ApiResponseCode {
  static const int success = 200;
  static const int noContent = 201;
  static const int badRequest = 400;
  static const int unAuth = 401;
  static const int forbidden = 403;
  static const int notFound = 404;
  static const int conflict = 409;
  static const int apiLogicalError = 422;
  static const int internalServerError = 500;
  static const int connectTimeout = -1;
  static const int receiveTimeout = -3;
  static const int sendTimeout = -4;
  static const int cancel = -2;
  static const int cacheError = -5;
  static const int noInternetConnection = -6;
  static const int defaultError = -7;
}

enum DataSource {
  noContent,
  badRequest,
  unAuth,
  forbidden,
  internalServerError,
  notFound,
  conflict,
  apiLogicError,
  connectTimeout,
  cancel,
  receiveTimeout,
  sendTimeout,
  cacheError,
  noInternetConnection,
  defaultError,
}


extension DataSourceExtension on DataSource {
  Failure getFailure() {
    switch (this) {
      case DataSource.noContent:
        return Failure(
          statusCode: ApiResponseCode.noContent,
          message: ApiResponseMessage.noContentError,
          status: ApiInternalStatus.failure,
          success: false,
        );
      case DataSource.badRequest:
        return Failure(
          statusCode: ApiResponseCode.badRequest,
          message: ApiResponseMessage.badRequestError,
          status: ApiInternalStatus.failure,
          success: false,
        );
      case DataSource.conflict:
        return Failure(
          statusCode: ApiResponseCode.conflict,
          message: ApiResponseMessage.conflictError,
          status: ApiInternalStatus.failure,
          success: false,
        );
      case DataSource.forbidden:
        return Failure(
          statusCode: ApiResponseCode.forbidden,
          message: ApiResponseMessage.forbiddenError,
          status: ApiInternalStatus.failure,
          success: false,
        );
      case DataSource.unAuth:
        return Failure(
          statusCode: ApiResponseCode.unAuth,
          status: ApiInternalStatus.failure,
          message: ApiResponseMessage.unAuthenticationError,
          success: false,
        );
      case DataSource.notFound:
        return Failure(
          statusCode: ApiResponseCode.notFound,
          message: ApiResponseMessage.notFoundError,
          status: ApiInternalStatus.failure,
          success: false,
        );
      case DataSource.internalServerError:
        return Failure(
          statusCode: ApiResponseCode.internalServerError,
          message: ApiResponseMessage.internalServerError,
          status: ApiInternalStatus.failure,
          success: false,
        );
      case DataSource.connectTimeout:
        return Failure(
          statusCode: ApiResponseCode.connectTimeout,
          message: ApiResponseMessage.connectTimeoutError,
          status: ApiInternalStatus.failure,
          success: false,
        );
      case DataSource.cancel:
        return Failure(
          statusCode: ApiResponseCode.cancel,
          message: ApiResponseMessage.cancelError,
          status: ApiInternalStatus.failure,
          success: false,
        );
      case DataSource.receiveTimeout:
        return Failure(
          statusCode: ApiResponseCode.receiveTimeout,
          message: ApiResponseMessage.receiveTimeoutError,
          status: ApiInternalStatus.failure,
          success: false,
        );
      case DataSource.sendTimeout:
        return Failure(
          statusCode: ApiResponseCode.sendTimeout,
          message: ApiResponseMessage.sendTimeoutError,
          status: ApiInternalStatus.failure,
          success: false,
        );
      case DataSource.cacheError:
        return Failure(
          statusCode: ApiResponseCode.cacheError,
          message: ApiResponseMessage.cacheError,
          status: ApiInternalStatus.failure,
          success: false,
        );
      case DataSource.noInternetConnection:
        return Failure(
          statusCode: ApiResponseCode.noInternetConnection,
          message: ApiResponseMessage.noInternetConnectionError,
          status: ApiInternalStatus.failure,
          success: false,
        );
      case DataSource.defaultError:
        return Failure(
          statusCode: ApiResponseCode.defaultError,
          message: ApiResponseMessage.defaultError,
          status: ApiInternalStatus.failure,
          success: false,
        );
      case DataSource.apiLogicError:
        return Failure(
          statusCode: ApiResponseCode.apiLogicalError,
          message: ApiResponseMessage.apiLogicalError,
          status: ApiInternalStatus.failure,
          success: false,
        );
    }
  }
}

class ErrorHandler implements Exception {
  late Failure failure;

  ErrorHandler.handle(dynamic error) {
    if (error is DioException) {
      failure = _handleError(error);
    } else {
      failure = DataSource.defaultError.getFailure();
    }
  }
}

Failure _handleError(DioException error) {
  switch (error.type) {
    case DioExceptionType.connectionTimeout:
      return DataSource.connectTimeout.getFailure();
    case DioExceptionType.sendTimeout:
      return DataSource.sendTimeout.getFailure();
    case DioExceptionType.receiveTimeout:
      return DataSource.receiveTimeout.getFailure();
    case DioExceptionType.badResponse:
     if (error.response != null &&
          error.response?.statusCode != null &&
          error.response?.data != null) {
        String errorsMessage = "";
        Map<String, dynamic> jsonObjectErrors = {};
        dynamic jsonObject = error.response?.data;
        int? statusCode = error.response?.statusCode;
        if (jsonObject != null) {
          if (jsonObject.containsKey("errors")) {
            jsonObjectErrors = jsonObject['errors'];
            if (jsonObjectErrors.isNotEmpty) {
              Iterable<String> keys = jsonObjectErrors.keys;
              for (String key in keys) {
                if (errorsMessage.isNotEmpty) {
                  errorsMessage =
                      '$errorsMessage\n\n ${jsonObjectErrors[key][0]}';
                } else {
                  errorsMessage = " ${jsonObjectErrors[key][0].toString()}";
                }
              }
            }
          } else {
            errorsMessage =
                jsonObject['message'] ?? ApiResponseMessage.badRequestError;
          }
        }
        return Failure(
            statusCode: statusCode ??
                jsonObject['statusCode'] ??
                ApiResponseCode.badRequest,
            status: ApiInternalStatus.failure,
            message:
                jsonObject['message'] ?? ApiResponseMessage.badRequestError,
            success: false,
            jsonErrorObject: jsonObjectErrors,
            prettyMessage: errorsMessage);
      } else {
        return DataSource.badRequest.getFailure();
      }
    case DioExceptionType.cancel:
      return DataSource.cancel.getFailure();
    case DioExceptionType.unknown:
      return DataSource.defaultError.getFailure();
    case DioExceptionType.connectionError:
      return DataSource.defaultError.getFailure();
    case DioExceptionType.badCertificate:
      return DataSource.defaultError.getFailure();
  }
}