abstract class BaseResponse<T> {}

class SuccessResponse<T> extends BaseResponse<T> {
  final T data;
  SuccessResponse(this.data);
}

class ErrorResponse<T, E>extends BaseResponse<T> {
  final E error;
  ErrorResponse({required this.error});
}