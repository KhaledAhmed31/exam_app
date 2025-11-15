abstract class BaseResponse<T> {
  get error => null;
}

class SuccessResponse<T> extends BaseResponse<T> {
  final T data;
  SuccessResponse(this.data);
}

class ErrorResponse<T, E>extends BaseResponse<T> {
  final E error;
  ErrorResponse({required this.error});
}